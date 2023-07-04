import 'package:isar/isar.dart';

part 'transaction_model.g.dart';

@embedded
class TransactionModel {
  late DateTime date;
  late bool isOutcome;
  late double amount;
  String? label;
}
