import 'package:finances/data/entities/envelop/envelop.dart';
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

  Future<void> deleteAll() async {
    final db = await instance;

    await db.close(deleteFromDisk: true);
    instance = openIsarDB();
  }

  Future<void> resetAll() async {
    final db = await instance;

    final envelops = await db.envelops.where().findAll();

    final newEnvelops = envelops
        .map(
          (env) => env.copyWith(
            currentAmount: env.initAmount,
          ),
        )
        .toList();

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
