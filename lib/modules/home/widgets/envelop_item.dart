import 'package:finances/data/entities/envelop.dart';
import 'package:finances/extensions/envelop.dart';
import 'package:finances/modules/home/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class EnvelopItemView extends StatelessWidget {
  const EnvelopItemView({
    super.key,
    required this.envelop,
  });

  final Envelop envelop;

  @override
  Widget build(BuildContext context) {
    final remainingPercentage = envelop.getRemainingPercentage();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) => TransactionBottomSheet(
                    envelop: envelop,
                  ),
                );
              },
              child: SizedBox(
                width: 200,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(112, 0, 0, 0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: remainingPercentage / 100,
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.vertical(
                            bottom: const Radius.circular(10),
                            top: remainingPercentage > 98.5
                                ? const Radius.circular(10)
                                : const Radius.circular(0),
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
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${envelop.currentAmount}€',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Init Amount : ',
                  ),
                  Text(
                    '${envelop.initAmount}€',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    '% Spent : ',
                  ),
                  Text(
                    '${envelop.getPercentageSpent().toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
