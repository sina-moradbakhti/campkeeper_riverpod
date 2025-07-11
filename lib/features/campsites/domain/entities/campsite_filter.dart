import 'package:equatable/equatable.dart';

class CampsiteFilter extends Equatable {
  final bool? isCloseToWater;
  final bool? isCampFireAllowed;
  final String? hostLanguage;
  final double? minPrice;
  final double? maxPrice;

  const CampsiteFilter({
    this.isCloseToWater,
    this.isCampFireAllowed,
    this.hostLanguage,
    this.minPrice,
    this.maxPrice,
  });

  CampsiteFilter copyWith({
    bool? isCloseToWater,
    bool? isCampFireAllowed,
    String? hostLanguage,
    double? minPrice,
    double? maxPrice,
  }) {
    return CampsiteFilter(
      isCloseToWater: isCloseToWater ?? this.isCloseToWater,
      isCampFireAllowed: isCampFireAllowed ?? this.isCampFireAllowed,
      hostLanguage: hostLanguage ?? this.hostLanguage,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

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

  @override
  List<Object?> get props => [
        isCloseToWater,
        isCampFireAllowed,
        hostLanguage,
        minPrice,
        maxPrice,
      ];
}
