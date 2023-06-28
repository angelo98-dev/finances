import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/modules/home/widgets/add_envelop_bottom_sheet.dart';
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
    final style = ref.watch(textThemeProvider);
    final color = ref.watch(appColorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primary,
        title: Text(title, style: style.h4.surface),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const AddEnvelopBottomSheet(),
            ),
            isScrollControlled: true,
          );
        },
        tooltip: 'Create an Envelope',
        child: Icon(
          Icons.add,
          color: color.neutral0,
        ),
      ), // This trailing comma makes auto-for
      body: AppRefreshIndicator(
        onRefresh: () async => ref.refresh(envelopFetcherProvider),
        child: SafeArea(child: _HomeInternalView()),
      ),
    );
  }
}

class _HomeInternalView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envelopList = ref.watch(envelopFetcherProvider);
    final style = ref.watch(textThemeProvider);
    final color = ref.watch(appColorThemeProvider);

    final now = DateTime.now();
    final currentMonth = now.day >= 27 ? now.month + 1 : now.month;
    final month = DateFormat('MMMM').format(
      DateTime(0, currentMonth),
    );
    final previousMonth = DateFormat('MMMM').format(
      DateTime(0, currentMonth - 1),
    );

    return envelopList.when(
      data: (allEnvelops) {
        if (allEnvelops.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Empty List. Create a new Envelope",
                textAlign: TextAlign.center,
                style: style.h2.surface.normal,
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
                  color: color.neutral0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 0),
                  child: Text(
                    'Mount of $month | 28/$previousMonth - 28/$month',
                    style: style.subtitle.primary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 25,
                ),
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 2,
                children: allEnvelops
                    .map(
                      (envelop) => EnvelopItemView(
                        envelop: envelop,
                      ),
                    )
                    .toList(),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Text(
                '@ByGrace-Dev | 2023',
                style: style.caption.surface,
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          "Error",
          style: style.h2.primary.normal,
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
