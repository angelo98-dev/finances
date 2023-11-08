import 'package:finance_core/src/data/entities/freezed_entities/envelop_model/envelop_model.dart';
import 'package:finance_core/src/data/entities/freezed_entities/transaction_model/transaction_model.dart';

extension EnvelopExtension on EnvelopModel {
  double getRemainingPercentage() {
    // if current amount is negative, that means we spent 100% of the money.
    if (currentAmount.isNegative) {
      return 0;
    }

    return (currentAmount / initAmount) * 100;
  }

  double getPercentageSpent() {
    if (currentAmount.isNegative) {
      return 100;
    }

    return ((initAmount - currentAmount) / initAmount) * 100;
  }

  Map<DateTime, List<TransactionModel>> transactionsByMonth() {
    final transactionsByMonth = <DateTime, List<TransactionModel>>{};

    for (final transaction in transactions) {
      final transactionDate = transaction.date;

      final dateEntry = transactionDate.day < 27
          ? DateTime(
              transactionDate.year,
              transactionDate.month,
            )
          : DateTime(
              transactionDate.year,
              transactionDate.month + 1,
            );

      if (transactionsByMonth.containsKey(dateEntry)) {
        transactionsByMonth[dateEntry]?.add(transaction);
      } else {
        transactionsByMonth[dateEntry] = [transaction];
      }
    }
    return transactionsByMonth;
  }
}
