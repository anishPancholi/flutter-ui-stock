// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StockEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StockSearchModel query) search,
    required TResult Function(StockModel model) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StockSearchModel query)? search,
    TResult? Function(StockModel model)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StockSearchModel query)? search,
    TResult Function(StockModel model)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchStock value) search,
    required TResult Function(_CreateStock value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchStock value)? search,
    TResult? Function(_CreateStock value)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchStock value)? search,
    TResult Function(_CreateStock value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockEventCopyWith<$Res> {
  factory $StockEventCopyWith(
          StockEvent value, $Res Function(StockEvent) then) =
      _$StockEventCopyWithImpl<$Res, StockEvent>;
}

/// @nodoc
class _$StockEventCopyWithImpl<$Res, $Val extends StockEvent>
    implements $StockEventCopyWith<$Res> {
  _$StockEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SearchStockImplCopyWith<$Res> {
  factory _$$SearchStockImplCopyWith(
          _$SearchStockImpl value, $Res Function(_$SearchStockImpl) then) =
      __$$SearchStockImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StockSearchModel query});
}

/// @nodoc
class __$$SearchStockImplCopyWithImpl<$Res>
    extends _$StockEventCopyWithImpl<$Res, _$SearchStockImpl>
    implements _$$SearchStockImplCopyWith<$Res> {
  __$$SearchStockImplCopyWithImpl(
      _$SearchStockImpl _value, $Res Function(_$SearchStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchStockImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as StockSearchModel,
    ));
  }
}

/// @nodoc

class _$SearchStockImpl implements _SearchStock {
  const _$SearchStockImpl({required this.query});

  @override
  final StockSearchModel query;

  @override
  String toString() {
    return 'StockEvent.search(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStockImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStockImplCopyWith<_$SearchStockImpl> get copyWith =>
      __$$SearchStockImplCopyWithImpl<_$SearchStockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StockSearchModel query) search,
    required TResult Function(StockModel model) create,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StockSearchModel query)? search,
    TResult? Function(StockModel model)? create,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StockSearchModel query)? search,
    TResult Function(StockModel model)? create,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchStock value) search,
    required TResult Function(_CreateStock value) create,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchStock value)? search,
    TResult? Function(_CreateStock value)? create,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchStock value)? search,
    TResult Function(_CreateStock value)? create,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class _SearchStock implements StockEvent {
  const factory _SearchStock({required final StockSearchModel query}) =
      _$SearchStockImpl;

  StockSearchModel get query;
  @JsonKey(ignore: true)
  _$$SearchStockImplCopyWith<_$SearchStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateStockImplCopyWith<$Res> {
  factory _$$CreateStockImplCopyWith(
          _$CreateStockImpl value, $Res Function(_$CreateStockImpl) then) =
      __$$CreateStockImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StockModel model});
}

/// @nodoc
class __$$CreateStockImplCopyWithImpl<$Res>
    extends _$StockEventCopyWithImpl<$Res, _$CreateStockImpl>
    implements _$$CreateStockImplCopyWith<$Res> {
  __$$CreateStockImplCopyWithImpl(
      _$CreateStockImpl _value, $Res Function(_$CreateStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$CreateStockImpl(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as StockModel,
    ));
  }
}

/// @nodoc

class _$CreateStockImpl implements _CreateStock {
  const _$CreateStockImpl({required this.model});

  @override
  final StockModel model;

  @override
  String toString() {
    return 'StockEvent.create(model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateStockImpl &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateStockImplCopyWith<_$CreateStockImpl> get copyWith =>
      __$$CreateStockImplCopyWithImpl<_$CreateStockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StockSearchModel query) search,
    required TResult Function(StockModel model) create,
  }) {
    return create(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StockSearchModel query)? search,
    TResult? Function(StockModel model)? create,
  }) {
    return create?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StockSearchModel query)? search,
    TResult Function(StockModel model)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchStock value) search,
    required TResult Function(_CreateStock value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchStock value)? search,
    TResult? Function(_CreateStock value)? create,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchStock value)? search,
    TResult Function(_CreateStock value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class _CreateStock implements StockEvent {
  const factory _CreateStock({required final StockModel model}) =
      _$CreateStockImpl;

  StockModel get model;
  @JsonKey(ignore: true)
  _$$CreateStockImplCopyWith<_$CreateStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StockState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StockModel> stocks) searchSuccess,
    required TResult Function(StockModel stock) createSuccess,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StockModel> stocks)? searchSuccess,
    TResult? Function(StockModel stock)? createSuccess,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StockModel> stocks)? searchSuccess,
    TResult Function(StockModel stock)? createSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_CreateSuccess value) createSuccess,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_CreateSuccess value)? createSuccess,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_CreateSuccess value)? createSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockStateCopyWith<$Res> {
  factory $StockStateCopyWith(
          StockState value, $Res Function(StockState) then) =
      _$StockStateCopyWithImpl<$Res, StockState>;
}

/// @nodoc
class _$StockStateCopyWithImpl<$Res, $Val extends StockState>
    implements $StockStateCopyWith<$Res> {
  _$StockStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$StockStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'StockState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StockModel> stocks) searchSuccess,
    required TResult Function(StockModel stock) createSuccess,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StockModel> stocks)? searchSuccess,
    TResult? Function(StockModel stock)? createSuccess,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StockModel> stocks)? searchSuccess,
    TResult Function(StockModel stock)? createSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_CreateSuccess value) createSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_CreateSuccess value)? createSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_CreateSuccess value)? createSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements StockState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StockStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StockState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StockModel> stocks) searchSuccess,
    required TResult Function(StockModel stock) createSuccess,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StockModel> stocks)? searchSuccess,
    TResult? Function(StockModel stock)? createSuccess,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StockModel> stocks)? searchSuccess,
    TResult Function(StockModel stock)? createSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_CreateSuccess value) createSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_CreateSuccess value)? createSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_CreateSuccess value)? createSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements StockState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SearchSuccessImplCopyWith<$Res> {
  factory _$$SearchSuccessImplCopyWith(
          _$SearchSuccessImpl value, $Res Function(_$SearchSuccessImpl) then) =
      __$$SearchSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<StockModel> stocks});
}

/// @nodoc
class __$$SearchSuccessImplCopyWithImpl<$Res>
    extends _$StockStateCopyWithImpl<$Res, _$SearchSuccessImpl>
    implements _$$SearchSuccessImplCopyWith<$Res> {
  __$$SearchSuccessImplCopyWithImpl(
      _$SearchSuccessImpl _value, $Res Function(_$SearchSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
  }) {
    return _then(_$SearchSuccessImpl(
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<StockModel>,
    ));
  }
}

/// @nodoc

class _$SearchSuccessImpl implements _SearchSuccess {
  const _$SearchSuccessImpl({required final List<StockModel> stocks})
      : _stocks = stocks;

  final List<StockModel> _stocks;
  @override
  List<StockModel> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  @override
  String toString() {
    return 'StockState.searchSuccess(stocks: $stocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSuccessImpl &&
            const DeepCollectionEquality().equals(other._stocks, _stocks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stocks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      __$$SearchSuccessImplCopyWithImpl<_$SearchSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StockModel> stocks) searchSuccess,
    required TResult Function(StockModel stock) createSuccess,
    required TResult Function(String message) failure,
  }) {
    return searchSuccess(stocks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StockModel> stocks)? searchSuccess,
    TResult? Function(StockModel stock)? createSuccess,
    TResult? Function(String message)? failure,
  }) {
    return searchSuccess?.call(stocks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StockModel> stocks)? searchSuccess,
    TResult Function(StockModel stock)? createSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(stocks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_CreateSuccess value) createSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return searchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_CreateSuccess value)? createSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return searchSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_CreateSuccess value)? createSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(this);
    }
    return orElse();
  }
}

abstract class _SearchSuccess implements StockState {
  const factory _SearchSuccess({required final List<StockModel> stocks}) =
      _$SearchSuccessImpl;

  List<StockModel> get stocks;
  @JsonKey(ignore: true)
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateSuccessImplCopyWith<$Res> {
  factory _$$CreateSuccessImplCopyWith(
          _$CreateSuccessImpl value, $Res Function(_$CreateSuccessImpl) then) =
      __$$CreateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StockModel stock});
}

/// @nodoc
class __$$CreateSuccessImplCopyWithImpl<$Res>
    extends _$StockStateCopyWithImpl<$Res, _$CreateSuccessImpl>
    implements _$$CreateSuccessImplCopyWith<$Res> {
  __$$CreateSuccessImplCopyWithImpl(
      _$CreateSuccessImpl _value, $Res Function(_$CreateSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stock = null,
  }) {
    return _then(_$CreateSuccessImpl(
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as StockModel,
    ));
  }
}

/// @nodoc

class _$CreateSuccessImpl implements _CreateSuccess {
  const _$CreateSuccessImpl({required this.stock});

  @override
  final StockModel stock;

  @override
  String toString() {
    return 'StockState.createSuccess(stock: $stock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSuccessImpl &&
            (identical(other.stock, stock) || other.stock == stock));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stock);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSuccessImplCopyWith<_$CreateSuccessImpl> get copyWith =>
      __$$CreateSuccessImplCopyWithImpl<_$CreateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StockModel> stocks) searchSuccess,
    required TResult Function(StockModel stock) createSuccess,
    required TResult Function(String message) failure,
  }) {
    return createSuccess(stock);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StockModel> stocks)? searchSuccess,
    TResult? Function(StockModel stock)? createSuccess,
    TResult? Function(String message)? failure,
  }) {
    return createSuccess?.call(stock);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StockModel> stocks)? searchSuccess,
    TResult Function(StockModel stock)? createSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (createSuccess != null) {
      return createSuccess(stock);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_CreateSuccess value) createSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return createSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_CreateSuccess value)? createSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return createSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_CreateSuccess value)? createSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (createSuccess != null) {
      return createSuccess(this);
    }
    return orElse();
  }
}

abstract class _CreateSuccess implements StockState {
  const factory _CreateSuccess({required final StockModel stock}) =
      _$CreateSuccessImpl;

  StockModel get stock;
  @JsonKey(ignore: true)
  _$$CreateSuccessImplCopyWith<_$CreateSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$StockStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'StockState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<StockModel> stocks) searchSuccess,
    required TResult Function(StockModel stock) createSuccess,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<StockModel> stocks)? searchSuccess,
    TResult? Function(StockModel stock)? createSuccess,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<StockModel> stocks)? searchSuccess,
    TResult Function(StockModel stock)? createSuccess,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_CreateSuccess value) createSuccess,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_CreateSuccess value)? createSuccess,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_CreateSuccess value)? createSuccess,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements StockState {
  const factory _Failure({required final String message}) = _$FailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
