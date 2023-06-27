import 'package:finances/data/entities/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/modules/home/widgets/add_envelop.dart';
import 'package:finances/modules/home/widgets/envelop_item.dart';
import 'package:finances/widgets/app_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final envelopFetcherProvider = StreamProvider.autoDispose<List<Envelop>>(
  (ref) async* {
    final envelopRepo = ref.watch(envelopRepositoryProvider);
    final envelops = envelopRepo.listenToEnvelops();

    yield* envelops;
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
        onRefresh: () async => ref.refresh(envelopFetcherProvider),
        child: _HomeInternalView(),
      ),
    );
  }
}

class _HomeInternalView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envelopList = ref.watch(envelopFetcherProvider);

    final now = DateTime.now();
    final currentMonth = now.day >= 27 ? now.month + 1 : now.month;
    final month = DateFormat('MMMM').format(
      DateTime(0, currentMonth),
    );

    return envelopList.when(
      data: (allEnvelops) {
        if (allEnvelops.isEmpty) {
          return const Center(
            child: Text(
              "Empty List. Create a new Envelop",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          );
        }

        return Column(
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
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    month,
                    style: const TextStyle(
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
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text(
          "Error",
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
