import 'package:finances/data/entities/envelop/envelop.dart';
import 'package:finances/data/sources/envelop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envelopRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(envelopApiClientProvider);

  return EnvelopRepository(apiClient: apiClient);
});

class EnvelopRepository {
  const EnvelopRepository({
    required EnvelopApiClient apiClient,
  }) : _apiClient = apiClient;

  final EnvelopApiClient _apiClient;

  Future<List<Envelop>> getAllEnvelop() async => _apiClient.getAllEnvelop();

  Future<void> createEnvelop({
    required String title,
    required double initAmount,
  }) async =>
      _apiClient.createEnvelop(
        title: title,
        initAmount: initAmount,
      );

  Future<void> updateEnvelop({
    required Envelop envelop,
  }) async =>
      _apiClient.updateEnvelop(
        envelop: envelop,
      );

  Stream<List<Envelop>> listenToEnvelops() async* {
    yield* _apiClient.listenToEnvelops();
  }

  Future<void> deleteEnvelop(int id) async => _apiClient.deleteEnvelop(id);

  Future<void> deleteAll() async => _apiClient.deleteAll();

  Future<void> resetAll() async => _apiClient.resetAll();
}
