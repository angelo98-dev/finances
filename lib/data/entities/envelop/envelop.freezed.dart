// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'envelop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Envelop _$EnvelopFromJson(Map<String, dynamic> json) {
  return _Envelop.fromJson(json);
}

/// @nodoc
mixin _$Envelop {
  int get id => throw _privateConstructorUsedError;
  double get currentAmount => throw _privateConstructorUsedError;
  String get title =>
      throw _privateConstructorUsedError; //required List<TransactionModel> transaction,
  double get initAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnvelopCopyWith<Envelop> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvelopCopyWith<$Res> {
  factory $EnvelopCopyWith(Envelop value, $Res Function(Envelop) then) =
      _$EnvelopCopyWithImpl<$Res, Envelop>;
  @useResult
  $Res call({int id, double currentAmount, String title, double initAmount});
}

/// @nodoc
class _$EnvelopCopyWithImpl<$Res, $Val extends Envelop>
    implements $EnvelopCopyWith<$Res> {
  _$EnvelopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentAmount = null,
    Object? title = null,
    Object? initAmount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      initAmount: null == initAmount
          ? _value.initAmount
          : initAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EnvelopCopyWith<$Res> implements $EnvelopCopyWith<$Res> {
  factory _$$_EnvelopCopyWith(
          _$_Envelop value, $Res Function(_$_Envelop) then) =
      __$$_EnvelopCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, double currentAmount, String title, double initAmount});
}

/// @nodoc
class __$$_EnvelopCopyWithImpl<$Res>
    extends _$EnvelopCopyWithImpl<$Res, _$_Envelop>
    implements _$$_EnvelopCopyWith<$Res> {
  __$$_EnvelopCopyWithImpl(_$_Envelop _value, $Res Function(_$_Envelop) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentAmount = null,
    Object? title = null,
    Object? initAmount = null,
  }) {
    return _then(_$_Envelop(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      currentAmount: null == currentAmount
          ? _value.currentAmount
          : currentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      initAmount: null == initAmount
          ? _value.initAmount
          : initAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Envelop extends _Envelop {
  const _$_Envelop(
      {required this.id,
      required this.currentAmount,
      required this.title,
      required this.initAmount})
      : super._();

  factory _$_Envelop.fromJson(Map<String, dynamic> json) =>
      _$$_EnvelopFromJson(json);

  @override
  final int id;
  @override
  final double currentAmount;
  @override
  final String title;
//required List<TransactionModel> transaction,
  @override
  final double initAmount;

  @override
  String toString() {
    return 'Envelop(id: $id, currentAmount: $currentAmount, title: $title, initAmount: $initAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Envelop &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.initAmount, initAmount) ||
                other.initAmount == initAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, currentAmount, title, initAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EnvelopCopyWith<_$_Envelop> get copyWith =>
      __$$_EnvelopCopyWithImpl<_$_Envelop>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnvelopToJson(
      this,
    );
  }
}

abstract class _Envelop extends Envelop {
  const factory _Envelop(
      {required final int id,
      required final double currentAmount,
      required final String title,
      required final double initAmount}) = _$_Envelop;
  const _Envelop._() : super._();

  factory _Envelop.fromJson(Map<String, dynamic> json) = _$_Envelop.fromJson;

  @override
  int get id;
  @override
  double get currentAmount;
  @override
  String get title;
  @override //required List<TransactionModel> transaction,
  double get initAmount;
  @override
  @JsonKey(ignore: true)
  _$$_EnvelopCopyWith<_$_Envelop> get copyWith =>
      throw _privateConstructorUsedError;
}
