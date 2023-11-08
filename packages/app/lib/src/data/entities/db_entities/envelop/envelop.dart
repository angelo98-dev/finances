import 'package:finance_core/src/data/entities/db_entities/transaction/transaction.dart';
import 'package:isar/isar.dart';

part 'envelop.g.dart';

@Collection()
class Envelop {
  Id id = Isar.autoIncrement;
  late double currentAmount;
  late String title;
  @embedded
  List<Transaction>? transactions;
  late double initAmount;

  Envelop copyWith({
    Id? id,
    double? currentAmount,
    String? title,
    List<Transaction>? transactions,
    double? initAmount,
  }) {
    return Envelop()
      ..id = id ?? this.id
      ..currentAmount = currentAmount ?? this.currentAmount
      ..title = title ?? this.title
      ..transactions = transactions ?? this.transactions
      ..initAmount = initAmount ?? this.initAmount;
  }
}
