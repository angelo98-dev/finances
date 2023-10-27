import 'package:finances/data/entities/freezed_entities/transaction_model/transaction_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'envelop_model.freezed.dart';
part 'envelop_model.g.dart';

@freezed
class EnvelopModel with _$EnvelopModel {
  const factory EnvelopModel({
    required int id,
    required double currentAmount,
    required String title,
    @Default([]) List<TransactionModel> transactions,
    required double initAmount,
  }) = _EnvelopModel;

  factory EnvelopModel.fromJson(Map<String, dynamic> json) =>
      _$EnvelopModelFromJson(json);
}
