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
    required double initAmount,
  }) = _Envelop;

  Id get id => id;

  factory Envelop.fromJson(Map<String, dynamic> json) =>
      _$EnvelopFromJson(json);
}
