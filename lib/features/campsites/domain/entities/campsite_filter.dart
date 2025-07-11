import 'package:freezed_annotation/freezed_annotation.dart';

part 'campsite_filter.freezed.dart';

@freezed
class CampsiteFilter with _$CampsiteFilter {
  const factory CampsiteFilter({
    bool? isCloseToWater,
    bool? isCampFireAllowed,
    String? hostLanguage,
    double? minPrice,
    double? maxPrice,
  }) = _CampsiteFilter;
}

extension CampsiteFilterExtension on CampsiteFilter {
  CampsiteFilter clearFilter({
    bool clearCloseToWater = false,
    bool clearCampFireAllowed = false,
    bool clearHostLanguage = false,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
  }) {
    return CampsiteFilter(
      isCloseToWater: clearCloseToWater ? null : isCloseToWater,
      isCampFireAllowed: clearCampFireAllowed ? null : isCampFireAllowed,
      hostLanguage: clearHostLanguage ? null : hostLanguage,
      minPrice: clearMinPrice ? null : minPrice,
      maxPrice: clearMaxPrice ? null : maxPrice,
    );
  }

  bool get hasActiveFilters {
    return isCloseToWater != null ||
        isCampFireAllowed != null ||
        hostLanguage != null ||
        minPrice != null ||
        maxPrice != null;
  }
}
