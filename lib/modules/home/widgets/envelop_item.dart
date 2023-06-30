import 'package:finances/core/theme/color.dart';
import 'package:finances/core/theme/text.dart';
import 'package:finances/data/entities/envelop.dart';
import 'package:finances/extensions/envelop.dart';
import 'package:finances/modules/home/widgets/app_shadow_box.dart';
import 'package:finances/modules/home/widgets/wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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
    final colors = ref.watch(appColorThemeProvider);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: AppShadowBox.custom(
              offset: const Offset(0, 3),
              backgroundColor: colors.transparent,
              blurRadius: 10,
              shadowOpacity: 1,
              borderRadius: BorderRadius.circular(10),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: colors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors.neutral200,
                              ),
                            ),
                            FractionallySizedBox(
                              heightFactor: remainingPercentage / 100,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutQuad,
                                child: WaveWidget(
                                  size: const Size(200, 250),
                                  yOffset: 0.6,
                                  color: colors.primary,
                                  child: Container(
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
                              ),
                            ),
                            Text(
                              '${remainingPercentage.toStringAsFixed(1)}%',
                              style:
                                  style.caption.withColor(colors.surface).bold,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                envelop.title,
                                style: style.body.primary.light,
                              ),
                              Text(
                                '${envelop.currentAmount}€',
                                style: style.subtitle.primary.bold,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              color: colors.primary,
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
                        width: 90,
                        child: Text(
                          'Init Amount : ',
                          style: style.caption.surface,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${envelop.initAmount}€',
                          style: style.caption.surface,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          '% Spent : ',
                          style: style.caption.surface,
                        ),
                      ),
                      Text(
                        '${envelop.getPercentageSpent().toStringAsFixed(1)}%',
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
