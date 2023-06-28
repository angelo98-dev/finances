import 'package:finances/data/entities/envelop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

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

      return await Isar.open(
        [EnvelopSchema],
        directory: dir.path,
        name: 'envelop_instance',
        inspector: true,
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

  Stream<List<Envelop>> listenToEnvelops() async* {
    final db = await instance;

    yield* db.envelops.where().watch(fireImmediately: true);
  }

  Future<void> updateEnvelop({
    required Envelop envelop,
    required double amount,
    bool add = false,
  }) async {
    final newAmount =
        add ? envelop.currentAmount + amount : envelop.currentAmount - amount;

    final initAmount = add ? envelop.initAmount + amount : envelop.initAmount;
    final updatedEnvelop = envelop.copyWith(
      currentAmount: newAmount,
      initAmount: initAmount,
    );
    final db = await instance;

    await db.writeTxnSync(() async {
      db.envelops.putSync(updatedEnvelop);
    });
  }

  Future<void> createEnvelop({
    required String title,
    required double initAmount,
  }) async {
    final newEnvelop = Envelop(
      id: Isar.autoIncrement,
      currentAmount: initAmount,
      title: title,
      initAmount: initAmount,
    );

    final db = await instance;

    await db.writeTxn(() async {
      await db.envelops.put(newEnvelop);
    });
  }
}
