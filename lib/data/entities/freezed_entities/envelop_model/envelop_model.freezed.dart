// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'envelop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EnvelopModel _$EnvelopModelFromJson(Map<String, dynamic> json) {
  return _EnvelopModel.fromJson(json);
}

/// @nodoc
mixin _$EnvelopModel {
  int get id => throw _privateConstructorUsedError;
  double get currentAmount => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<TransactionModel> get transactions => throw _privateConstructorUsedError;
  double get initAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnvelopModelCopyWith<EnvelopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvelopModelCopyWith<$Res> {
  factory $EnvelopModelCopyWith(
          EnvelopModel value, $Res Function(EnvelopModel) then) =
      _$EnvelopModelCopyWithImpl<$Res, EnvelopModel>;
  @useResult
  $Res call(
      {int id,
      double currentAmount,
      String title,
      List<TransactionModel> transactions,
      double initAmount});
}

/// @nodoc
class _$EnvelopModelCopyWithImpl<$Res, $Val extends EnvelopModel>
    implements $EnvelopModelCopyWith<$Res> {
  _$EnvelopModelCopyWithImpl(this._value, this._then);

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
    Object? transactions = null,
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
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionModel>,
      initAmount: null == initAmount
          ? _value.initAmount
          : initAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EnvelopModelCopyWith<$Res>
    implements $EnvelopModelCopyWith<$Res> {
  factory _$$_EnvelopModelCopyWith(
          _$_EnvelopModel value, $Res Function(_$_EnvelopModel) then) =
      __$$_EnvelopModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double currentAmount,
      String title,
      List<TransactionModel> transactions,
      double initAmount});
}

/// @nodoc
class __$$_EnvelopModelCopyWithImpl<$Res>
    extends _$EnvelopModelCopyWithImpl<$Res, _$_EnvelopModel>
    implements _$$_EnvelopModelCopyWith<$Res> {
  __$$_EnvelopModelCopyWithImpl(
      _$_EnvelopModel _value, $Res Function(_$_EnvelopModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentAmount = null,
    Object? title = null,
    Object? transactions = null,
    Object? initAmount = null,
  }) {
    return _then(_$_EnvelopModel(
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
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionModel>,
      initAmount: null == initAmount
          ? _value.initAmount
          : initAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EnvelopModel implements _EnvelopModel {
  const _$_EnvelopModel(
      {required this.id,
      required this.currentAmount,
      required this.title,
      final List<TransactionModel> transactions = const [],
      required this.initAmount})
      : _transactions = transactions;

  factory _$_EnvelopModel.fromJson(Map<String, dynamic> json) =>
      _$$_EnvelopModelFromJson(json);

  @override
  final int id;
  @override
  final double currentAmount;
  @override
  final String title;
  final List<TransactionModel> _transactions;
  @override
  @JsonKey()
  List<TransactionModel> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final double initAmount;

  @override
  String toString() {
    return 'EnvelopModel(id: $id, currentAmount: $currentAmount, title: $title, transactions: $transactions, initAmount: $initAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EnvelopModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.initAmount, initAmount) ||
                other.initAmount == initAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, currentAmount, title,
      const DeepCollectionEquality().hash(_transactions), initAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EnvelopModelCopyWith<_$_EnvelopModel> get copyWith =>
      __$$_EnvelopModelCopyWithImpl<_$_EnvelopModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnvelopModelToJson(
      this,
    );
  }
}

abstract class _EnvelopModel implements EnvelopModel {
  const factory _EnvelopModel(
      {required final int id,
      required final double currentAmount,
      required final String title,
      final List<TransactionModel> transactions,
      required final double initAmount}) = _$_EnvelopModel;

  factory _EnvelopModel.fromJson(Map<String, dynamic> json) =
      _$_EnvelopModel.fromJson;

  @override
  int get id;
  @override
  double get currentAmount;
  @override
  String get title;
  @override
  List<TransactionModel> get transactions;
  @override
  double get initAmount;
  @override
  @JsonKey(ignore: true)
  _$$_EnvelopModelCopyWith<_$_EnvelopModel> get copyWith =>
      throw _privateConstructorUsedError;
}
