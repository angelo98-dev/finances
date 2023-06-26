import 'package:finances/data/entities/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/modules/home/widgets/add_envelop.dart';
import 'package:finances/modules/home/widgets/envelop_item.dart';
import 'package:finances/widgets/app_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _envelopFetcherProvider = FutureProvider.autoDispose<List<Envelop>>(
  (ref) async {
    final envelopRepo = ref.watch(envelopRepositoryProvider);

    return envelopRepo.getAllEnvelop();
  },
);

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddEnvelopBottomSheet(),
          );
        },
        tooltip: 'Ajout enveloppe',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-for
      body: AppRefreshIndicator(
        onRefresh: () async => ref.refresh(_envelopFetcherProvider),
        child: _HomeInternalView(),
      ),
    );
  }
}

class _HomeInternalView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envelopList = ref.watch(_envelopFetcherProvider);

    return envelopList.when(
      data: (allEnvelops) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Juillet',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 25,
              ),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: allEnvelops
                  .map(
                    (envelop) => EnvelopItemView(
                      envelop: envelop,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
