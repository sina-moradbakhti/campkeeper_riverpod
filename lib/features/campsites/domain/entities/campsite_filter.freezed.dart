// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campsite_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CampsiteFilter {
  bool? get isCloseToWater => throw _privateConstructorUsedError;
  bool? get isCampFireAllowed => throw _privateConstructorUsedError;
  String? get hostLanguage => throw _privateConstructorUsedError;
  double? get minPrice => throw _privateConstructorUsedError;
  double? get maxPrice => throw _privateConstructorUsedError;

  /// Create a copy of CampsiteFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampsiteFilterCopyWith<CampsiteFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampsiteFilterCopyWith<$Res> {
  factory $CampsiteFilterCopyWith(
          CampsiteFilter value, $Res Function(CampsiteFilter) then) =
      _$CampsiteFilterCopyWithImpl<$Res, CampsiteFilter>;
  @useResult
  $Res call(
      {bool? isCloseToWater,
      bool? isCampFireAllowed,
      String? hostLanguage,
      double? minPrice,
      double? maxPrice});
}

/// @nodoc
class _$CampsiteFilterCopyWithImpl<$Res, $Val extends CampsiteFilter>
    implements $CampsiteFilterCopyWith<$Res> {
  _$CampsiteFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampsiteFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCloseToWater = freezed,
    Object? isCampFireAllowed = freezed,
    Object? hostLanguage = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
  }) {
    return _then(_value.copyWith(
      isCloseToWater: freezed == isCloseToWater
          ? _value.isCloseToWater
          : isCloseToWater // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCampFireAllowed: freezed == isCampFireAllowed
          ? _value.isCampFireAllowed
          : isCampFireAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      hostLanguage: freezed == hostLanguage
          ? _value.hostLanguage
          : hostLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CampsiteFilterImplCopyWith<$Res>
    implements $CampsiteFilterCopyWith<$Res> {
  factory _$$CampsiteFilterImplCopyWith(_$CampsiteFilterImpl value,
          $Res Function(_$CampsiteFilterImpl) then) =
      __$$CampsiteFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? isCloseToWater,
      bool? isCampFireAllowed,
      String? hostLanguage,
      double? minPrice,
      double? maxPrice});
}

/// @nodoc
class __$$CampsiteFilterImplCopyWithImpl<$Res>
    extends _$CampsiteFilterCopyWithImpl<$Res, _$CampsiteFilterImpl>
    implements _$$CampsiteFilterImplCopyWith<$Res> {
  __$$CampsiteFilterImplCopyWithImpl(
      _$CampsiteFilterImpl _value, $Res Function(_$CampsiteFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of CampsiteFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCloseToWater = freezed,
    Object? isCampFireAllowed = freezed,
    Object? hostLanguage = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
  }) {
    return _then(_$CampsiteFilterImpl(
      isCloseToWater: freezed == isCloseToWater
          ? _value.isCloseToWater
          : isCloseToWater // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCampFireAllowed: freezed == isCampFireAllowed
          ? _value.isCampFireAllowed
          : isCampFireAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      hostLanguage: freezed == hostLanguage
          ? _value.hostLanguage
          : hostLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$CampsiteFilterImpl implements _CampsiteFilter {
  const _$CampsiteFilterImpl(
      {this.isCloseToWater,
      this.isCampFireAllowed,
      this.hostLanguage,
      this.minPrice,
      this.maxPrice});

  @override
  final bool? isCloseToWater;
  @override
  final bool? isCampFireAllowed;
  @override
  final String? hostLanguage;
  @override
  final double? minPrice;
  @override
  final double? maxPrice;

  @override
  String toString() {
    return 'CampsiteFilter(isCloseToWater: $isCloseToWater, isCampFireAllowed: $isCampFireAllowed, hostLanguage: $hostLanguage, minPrice: $minPrice, maxPrice: $maxPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampsiteFilterImpl &&
            (identical(other.isCloseToWater, isCloseToWater) ||
                other.isCloseToWater == isCloseToWater) &&
            (identical(other.isCampFireAllowed, isCampFireAllowed) ||
                other.isCampFireAllowed == isCampFireAllowed) &&
            (identical(other.hostLanguage, hostLanguage) ||
                other.hostLanguage == hostLanguage) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCloseToWater,
      isCampFireAllowed, hostLanguage, minPrice, maxPrice);

  /// Create a copy of CampsiteFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampsiteFilterImplCopyWith<_$CampsiteFilterImpl> get copyWith =>
      __$$CampsiteFilterImplCopyWithImpl<_$CampsiteFilterImpl>(
          this, _$identity);
}

abstract class _CampsiteFilter implements CampsiteFilter {
  const factory _CampsiteFilter(
      {final bool? isCloseToWater,
      final bool? isCampFireAllowed,
      final String? hostLanguage,
      final double? minPrice,
      final double? maxPrice}) = _$CampsiteFilterImpl;

  @override
  bool? get isCloseToWater;
  @override
  bool? get isCampFireAllowed;
  @override
  String? get hostLanguage;
  @override
  double? get minPrice;
  @override
  double? get maxPrice;

  /// Create a copy of CampsiteFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampsiteFilterImplCopyWith<_$CampsiteFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
