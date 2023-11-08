import 'package:finance_core/src/core/theme/color.dart';
import 'package:finance_core/src/core/theme/text.dart';
import 'package:finance_core/src/data/entities/freezed_entities/envelop_model/envelop_model.dart';
import 'package:finance_core/src/data/entities/freezed_entities/transaction_model/transaction_model.dart';
import 'package:finance_core/src/extensions/envelop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({
    super.key,
    required this.envelop,
  });

  final EnvelopModel envelop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = ref.watch(textThemeProvider);
    final colors = ref.watch(appColorThemeProvider);

    final transactionsByMonth = envelop.transactionsByMonth();
    final now = DateTime.now();
    final nowDate = DateTime(now.year, now.month);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'History',
          style: styles.h4.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                envelop.title,
                style: styles.h3.primary,
              ),
              const Gap(10),
              Text(
                'Le mois est considéré du 27 au 26 du mois suivant',
                style: styles.body.primary.normal,
              ),
              const Gap(10),
              ...transactionsByMonth.entries.map(
                (entry) {
                  final date = entry.key;

                  return ExpansionPanelList.radio(
                    elevation: 1,
                    initialOpenPanelValue: nowDate,
                    children: [
                      ExpansionPanelRadio(
                        value: date,
                        backgroundColor: colors.neutral100,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                            ),
                            child: Text(
                              'Transactions ${DateFormat('MMMM-yyyy').format(date)}',
                              style: styles.body.primary.bold,
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Text('Date'),
                                  ),
                                  Expanded(
                                    child: Text('Label'),
                                  ),
                                  Expanded(
                                    child: Text('Amount'),
                                  ),
                                ],
                              ),
                            ),
                            ...entry.value.map(
                              (transaction) =>
                                  _TransactionItem(transaction: transaction),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionItem extends ConsumerWidget {
  const _TransactionItem({
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appColorThemeProvider);
    final styles = ref.watch(textThemeProvider);

    final isOutcome = transaction.isOutcome;
    final templabel = transaction.label;
    final label = templabel.isEmpty ? '---' : templabel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.neutral0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  DateFormat('dd/MM/yyyy').format(transaction.date),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    label,
                    style: styles.body.primary.light,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isOutcome
                        ? Colors.redAccent.withOpacity(0.4)
                        : Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${transaction.amount}€',
                    style: styles.body.primary.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
