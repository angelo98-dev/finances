import 'package:finances/data/entities/db_entities/transaction/transaction.dart';
import 'package:finances/data/entities/freezed_entities/transaction_model/transaction_model.dart';

extension TransactionMapper on TransactionModel {
  Transaction transactionDbEntity() {
    return Transaction()
      ..label = label
      ..amount = amount
      ..date = date
      ..isOutcome = isOutcome;
  }

  static TransactionModel fromDbEntity(Transaction transaction) {
    return TransactionModel(
      date: transaction.date,
      isOutcome: transaction.isOutcome,
      amount: transaction.amount,
      label: transaction.label ?? '',
    );
  }
}
