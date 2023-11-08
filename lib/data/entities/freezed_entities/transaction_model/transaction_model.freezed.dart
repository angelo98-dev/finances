// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  DateTime get date => throw _privateConstructorUsedError;
  bool get isOutcome => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call({DateTime date, bool isOutcome, double amount, String label});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? isOutcome = null,
    Object? amount = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isOutcome: null == isOutcome
          ? _value.isOutcome
          : isOutcome // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$_TransactionCopyWith(
          _$_Transaction value, $Res Function(_$_Transaction) then) =
      __$$_TransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, bool isOutcome, double amount, String label});
}

/// @nodoc
class __$$_TransactionCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$_Transaction>
    implements _$$_TransactionCopyWith<$Res> {
  __$$_TransactionCopyWithImpl(
      _$_Transaction _value, $Res Function(_$_Transaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? isOutcome = null,
    Object? amount = null,
    Object? label = null,
  }) {
    return _then(_$_Transaction(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isOutcome: null == isOutcome
          ? _value.isOutcome
          : isOutcome // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transaction implements _Transaction {
  const _$_Transaction(
      {required this.date,
      required this.isOutcome,
      required this.amount,
      this.label = ''});

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

  @override
  final DateTime date;
  @override
  final bool isOutcome;
  @override
  final double amount;
  @override
  @JsonKey()
  final String label;

  @override
  String toString() {
    return 'TransactionModel(date: $date, isOutcome: $isOutcome, amount: $amount, label: $label)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transaction &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isOutcome, isOutcome) ||
                other.isOutcome == isOutcome) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, isOutcome, amount, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      __$$_TransactionCopyWithImpl<_$_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(
      this,
    );
  }
}

abstract class _Transaction implements TransactionModel {
  const factory _Transaction(
      {required final DateTime date,
      required final bool isOutcome,
      required final double amount,
      final String label}) = _$_Transaction;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override
  DateTime get date;
  @override
  bool get isOutcome;
  @override
  double get amount;
  @override
  String get label;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
