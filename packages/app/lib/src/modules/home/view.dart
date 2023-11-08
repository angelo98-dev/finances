import 'package:finance_core/src/core/theme/color.dart';
import 'package:finance_core/src/core/theme/text.dart';
import 'package:finance_core/src/modules/home/widgets/add_envelop_bottom_sheet.dart';
import 'package:finance_core/src/modules/home/widgets/envelop_tile.dart';
import 'package:finance_core/src/modules/reports/view.dart';
import 'package:finance_core/src/notifiers/notifier.dart';
import 'package:finance_core/src/widgets/app_dialog.dart';
import 'package:finance_core/src/widgets/app_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
        backgroundColor: color.surface,
        title: Text(
          title,
          style: style.h4.primary,
        ),
        actions: const [
          _PopMenuButton(),
        ],
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
        onRefresh: () async {
          // ref.refresh(envelopFetcherProvider)
        },
        child: SafeArea(child: _HomeInternalView()),
      ),
    );
  }
}

class _PopMenuButton extends ConsumerWidget {
  const _PopMenuButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorThemeProvider);
    final styles = ref.watch(textThemeProvider);

    return PopupMenuButton(
      itemBuilder: (context) {
        {
          return [
            PopupMenuItem<String>(
              value: 'open_report',
              child: Text(
                'Reports',
                style: styles.body.primary,
              ),
            ),
            PopupMenuItem<String>(
              value: 'open_reset_all',
              child: Text(
                'Reset all envelops',
                style: styles.body.primary,
              ),
            ),
            PopupMenuItem<String>(
              value: 'open_delete_all_dialog',
              child: Text(
                'Delete all envelops',
                style: styles.body.primary,
              ),
            ),
          ];
        }
      },
      surfaceTintColor: colors.neutral0,
      onSelected: (value) async {
        switch (value) {
          case 'open_delete_all_dialog':
            return showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AppDialog(
                  title: 'Delete all',
                  content:
                      'This operation is irreversible. Are you sure you want to delete all the envelops? ',
                  primaryActionLabel: 'Cancel',
                  secondaryActionLabel: 'OK',
                  primaryActionCallback: () => Navigator.pop(context),
                  secondaryActionCallback: () {
                    ref.read(envelopsProvider.notifier).deleteAll();

                    Navigator.pop(context);
                  },
                ),
              ),
            );
          case 'open_reset_all':
            return showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AppDialog(
                  title: 'Reset all',
                  content:
                      'This operation is irreversible. Are you sure you want reset all the envelops? ',
                  primaryActionLabel: 'Cancel',
                  secondaryActionLabel: 'OK',
                  primaryActionCallback: () => Navigator.pop(context),
                  secondaryActionCallback: () {
                    ref.read(envelopsProvider.notifier).resetAll();
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          case 'open_report':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Reports(),
              ),
            );
        }
      },
    );
  }
}

class _HomeInternalView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envelopList = ref.watch(envelopsProvider);
    final styles = ref.watch(textThemeProvider);
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
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Empty List. Create a new Envelope',
                      textAlign: TextAlign.center,
                      style: styles.h2.primary.normal,
                    ),
                  ),
                ),
              ),
              const AppCopyRightView(),
            ],
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
                    style: styles.subtitle.primary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 2,
                children: allEnvelops
                    .map(
                      (envelop) => EnvelopTile(
                        envelop: envelop,
                      ),
                    )
                    .toList(),
              ),
            ),
            const AppCopyRightView(),
          ],
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          'Error',
          style: styles.h2.primary.normal,
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AppCopyRightView extends ConsumerWidget {
  const AppCopyRightView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = ref.watch(textThemeProvider);

    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Text(
        '@ByGrace-Dev | 2023',
        style: styles.caption.primary.light,
      ),
    );
  }
}
