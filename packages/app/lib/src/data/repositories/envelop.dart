import 'package:finance_core/src/data/entities/freezed_entities/envelop_model/envelop_model.dart';
import 'package:finance_core/src/data/entities/mapper/envelop_mapper.dart';
import 'package:finance_core/src/data/sources/envelop.dart';
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

  Future<List<EnvelopModel>> getAllEnvelop() async =>
      _apiClient.getAllEnvelop().then(
            (envelops) => envelops
                .map((envelop) => EnvelopMapper.fromDbEntity(envelop))
                .toList(),
          );

  Future<void> createEnvelop({
    required String title,
    required double initAmount,
  }) async =>
      _apiClient.createEnvelop(
        title: title,
        initAmount: initAmount,
      );

  Future<void> updateEnvelop({
    required EnvelopModel envelop,
  }) async =>
      _apiClient.updateEnvelop(
        envelop: envelop.toDbEntity(),
      );

  Future<void> deleteEnvelop(int id) async => _apiClient.deleteEnvelop(id);

  Future<void> deleteAll() async => _apiClient.deleteAll();

  Future<void> resetAll() async => _apiClient.resetAll();
}
