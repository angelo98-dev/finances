import 'package:finance_core/src/data/entities/db_entities/envelop/envelop.dart';
import 'package:finance_core/src/data/entities/freezed_entities/envelop_model/envelop_model.dart';
import 'package:finance_core/src/data/entities/mapper/transaction_mapper.dart';

extension EnvelopMapper on EnvelopModel {
  Envelop toDbEntity() {
    return Envelop()
      ..id = id
      ..title = title
      ..currentAmount = currentAmount
      ..initAmount = initAmount
      ..transactions = transactions
          .map((transaction) => transaction.transactionDbEntity())
          .toList();
  }

  static EnvelopModel fromDbEntity(Envelop envelop) {
    final transactions = envelop.transactions;

    return EnvelopModel(
      id: envelop.id,
      currentAmount: envelop.currentAmount,
      title: envelop.title,
      transactions: transactions != null
          ? transactions.map((e) => TransactionMapper.fromDbEntity(e)).toList()
          : [],
      initAmount: envelop.initAmount,
    );
  }
}
