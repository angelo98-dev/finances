import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:finances/data/repositories/envelop.dart';
import 'package:finances/extensions/envelop.dart';
import 'package:finances/modules/home/widgets/transaction_bottom_sheet.dart';
import 'package:finances/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _envelopDeleteProvider =
    FutureProvider.autoDispose.family((ref, int id) async {
  final envelopRepo = ref.watch(envelopRepositoryProvider);

  return envelopRepo.deleteEnvelop(id);
});

class EnvelopItemView extends ConsumerWidget {
  const EnvelopItemView({
    super.key,
    required this.envelop,
  });

  final Envelop envelop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingPercentage = envelop.getRemainingPercentage();
    final style = ref.watch(textThemeProvider);
    final color = ref.watch(appColorThemeProvider);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: true,
                  context: context,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: TransactionBottomSheet(
                      envelop: envelop,
                    ),
                  ),
                );
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AppDialog(
                      title: 'Delete',
                      content: 'Are you sure you want to delete this envelope?',
                      primaryActionLabel: 'Cancel',
                      secondaryActionLabel: 'OK',
                      primaryActionCallback: () => Navigator.pop(context),
                      secondaryActionCallback: () {
                        ref.read(
                          _envelopDeleteProvider(envelop.id),
                        );

                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 350,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color.background,
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: remainingPercentage / 100,
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 350,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: const Radius.circular(10),
                            top: remainingPercentage > 98.5
                                ? const Radius.circular(10)
                                : const Radius.circular(0),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF846AFF),
                              Color(0xFF755EE8),
                              Colors.purpleAccent,
                              Color.fromARGB(255, 244, 131, 66),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            envelop.title,
                            textAlign: TextAlign.center,
                            style: style.subtitle.surface.bold,
                          ),
                          Text(
                            '${envelop.currentAmount}€',
                            style: style.h3.surface.bold.italic,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              color: color.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Init Amount : ',
                          style: style.caption.surface,
                        ),
                      ),
                      Text(
                        '${envelop.initAmount}€',
                        style: style.caption.surface,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '% Spent : ',
                          style: style.caption.surface,
                        ),
                      ),
                      Text(
                        '${envelop.getPercentageSpent().toStringAsFixed(2)}%',
                        style: style.caption.surface,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
