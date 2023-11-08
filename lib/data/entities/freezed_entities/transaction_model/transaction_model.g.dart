// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      date: DateTime.parse(json['date'] as String),
      isOutcome: json['isOutcome'] as bool,
      amount: (json['amount'] as num).toDouble(),
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'isOutcome': instance.isOutcome,
      'amount': instance.amount,
      'label': instance.label,
    };
