// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EnvelopModel _$$_EnvelopModelFromJson(Map<String, dynamic> json) =>
    _$_EnvelopModel(
      id: json['id'] as int,
      currentAmount: (json['currentAmount'] as num).toDouble(),
      title: json['title'] as String,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      initAmount: (json['initAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$_EnvelopModelToJson(_$_EnvelopModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentAmount': instance.currentAmount,
      'title': instance.title,
      'transactions': instance.transactions,
      'initAmount': instance.initAmount,
    };
