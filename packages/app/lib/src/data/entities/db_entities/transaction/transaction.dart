import 'package:isar/isar.dart';

part 'transaction.g.dart';

@embedded
class Transaction {
  late DateTime date;
  late bool isOutcome;
  late double amount;
  String? label;
}
