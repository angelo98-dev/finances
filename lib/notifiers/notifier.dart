import 'package:finances/data/entities/envelop/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// We are using NotifierProvider to allow the UI to interact with
// our EnvelopsNotifier class.
final envelopsProvider = AsyncNotifierProvider<EnvelopsNotifier, List<Envelop>>(
  () => EnvelopsNotifier(),
);

// The Notifier class that will be passed to our NotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
class EnvelopsNotifier extends AsyncNotifier<List<Envelop>> {
  @override
  Future<List<Envelop>> build() {
    // Load initial envelop list from the remote repository
    return _getAllEnvelop();
  }

  Future<List<Envelop>> _getAllEnvelop() async {
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
}
