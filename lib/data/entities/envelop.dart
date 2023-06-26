import 'package:freezed_annotation/freezed_annotation.dart';

part 'envelop.freezed.dart';
part 'envelop.g.dart';

@Freezed()
class Envelop with _$Envelop {
  const factory Envelop({
    required String id,
    required double currentAmount,
    required String title,

    // required Map<DateTime, double> history,
    required double initAmount,
  }) = _Envelop;

  factory Envelop.fromJson(Map<String, dynamic> json) =>
      _$EnvelopFromJson(json);
}
