import 'package:finances/data/entities/transaction_isar/transaction_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'envelop.freezed.dart';
part 'envelop.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class Envelop with _$Envelop {
  const Envelop._();

  const factory Envelop({
    required int id,
    required double currentAmount,
    required String title,
    //required List<TransactionModel> transaction,
    required double initAmount,
  }) = _Envelop;

  @override
  // ignore: recursive_getters
  Id get id => id;

  factory Envelop.fromJson(Map<String, dynamic> json) =>
      _$EnvelopFromJson(json);
}
