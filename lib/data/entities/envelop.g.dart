// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Envelop _$$_EnvelopFromJson(Map<String, dynamic> json) => _$_Envelop(
      id: json['id'] as String,
      currentAmount: (json['currentAmount'] as num).toDouble(),
      title: json['title'] as String,
      initAmount: (json['initAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$_EnvelopToJson(_$_Envelop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentAmount': instance.currentAmount,
      'title': instance.title,
      'initAmount': instance.initAmount,
    };
