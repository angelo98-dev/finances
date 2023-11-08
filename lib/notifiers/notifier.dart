import 'package:finances/data/entities/freezed_entities/envelop_model/envelop_model.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final envelopsProvider =
    AsyncNotifierProvider<EnvelopsNotifier, List<EnvelopModel>>(
  () => EnvelopsNotifier(),
);

class EnvelopsNotifier extends AsyncNotifier<List<EnvelopModel>> {
  @override
  Future<List<EnvelopModel>> build() {
    // Load initial envelop list from the remote repository
    return _getAllEnvelop();
  }

  Future<List<EnvelopModel>> _getAllEnvelop() async {
    final repository = ref.read(envelopRepositoryProvider);

    return repository.getAllEnvelop();
  }

  Future<void> addEnvelop({
    required String title,
    required double initAmount,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(envelopRepositoryProvider);

      await repository.createEnvelop(
        title: title,
        initAmount: initAmount,
      );

      return _getAllEnvelop();
    });
  }

  Future<void> deleteEnvelop({
    required int id,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(envelopRepositoryProvider);

      await repository.deleteEnvelop(id);

      return _getAllEnvelop();
    });
  }

  Future<void> deleteAll() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(envelopRepositoryProvider);

      await repository.deleteAll();

      return _getAllEnvelop();
    });
  }

  Future<void> resetAll() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(envelopRepositoryProvider);

      await repository.resetAll();

      return _getAllEnvelop();
    });
  }

  Future<void> updateEnvelop({
    required EnvelopModel envelop,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(envelopRepositoryProvider);

      await repository.updateEnvelop(
        envelop: envelop,
      );

      return _getAllEnvelop();
    });
  }
}
