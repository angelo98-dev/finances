import 'package:finance_core/src/data/entities/db_entities/envelop/envelop.dart';
import 'package:finance_core/src/data/entities/freezed_entities/transaction_model/transaction_model.dart';
import 'package:finance_core/src/data/entities/mapper/envelop_mapper.dart';
import 'package:finance_core/src/data/entities/mapper/transaction_mapper.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final envelopApiClientProvider = Provider(
  (ref) {
    return EnvelopApiClient();
  },
);

class EnvelopApiClient {
  EnvelopApiClient() {
    instance = openIsarDB();
  }

  late Future<Isar> instance;

  Future<Isar> openIsarDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      return Isar.open(
        [EnvelopSchema],
        directory: dir.path,
        name: 'envelop_instance',
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<List<Envelop>> getAllEnvelop() async {
    final db = await instance;

    return db.envelops.where().findAll();
  }

  Future<void> deleteEnvelop(int id) async {
    final db = await instance;

    return db.writeTxn(() async {
      db.envelops.delete(id);
    });
  }

  Future<void> deleteAll() async {
    final db = await instance;

    await db.close(deleteFromDisk: true);
    instance = openIsarDB();
  }

  Future<void> resetAll() async {
    final db = await instance;

    final envelops = await db.envelops.where().findAll();

    final newEnvelops = envelops.map(
      (env) {
        final envelop = EnvelopMapper.fromDbEntity(env);

        final transactions = [
          ...envelop.transactions,
          TransactionModel(
            date: DateTime.now(),
            isOutcome: false,
            amount: env.initAmount,
            label: 'Init Amount',
          ),
        ];

        return env.copyWith(
          currentAmount: env.initAmount,
          transactions: transactions
              .map((transaction) => transaction.transactionDbEntity())
              .toList() ,
        );
      },
    ).toList();

    return db.writeTxnSync(
      () async {
        db.envelops.putAllSync(newEnvelops);
      },
    );
  }

  Stream<List<Envelop>> listenToEnvelops() async* {
    final db = await instance;

    yield* db.envelops.where().watch(fireImmediately: true);
  }

  Future<void> updateEnvelop({
    required Envelop envelop,
  }) async {
    final db = await instance;

    await db.writeTxnSync(() async {
      db.envelops.putSync(envelop);
    });
  }

  Future<void> createEnvelop({
    required String title,
    required double initAmount,
  }) async {
    final newEnvelop = Envelop()
      ..id = Isar.autoIncrement
      ..currentAmount = initAmount
      ..initAmount = initAmount
      ..title = title
      ..transactions = [];

    final db = await instance;

    await db.writeTxn(() async {
      await db.envelops.put(newEnvelop);
    });
  }
}
