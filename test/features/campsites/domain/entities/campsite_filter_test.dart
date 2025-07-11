import 'package:flutter_test/flutter_test.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite_filter.dart';

void main() {
  group('CampsiteFilter', () {
    test('should have no active filters when all properties are null', () {
      const filter = CampsiteFilter();

      expect(filter.hasActiveFilters, false);
    });

    test('should have active filters when any property is not null', () {
      const filter = CampsiteFilter(isCloseToWater: true);

      expect(filter.hasActiveFilters, true);
    });

    test('should copy with new values', () {
      const originalFilter = CampsiteFilter(isCloseToWater: true);

      final newFilter = originalFilter.copyWith(isCampFireAllowed: false);

      expect(newFilter.isCloseToWater, true);
      expect(newFilter.isCampFireAllowed, false);
    });

    test('should clear specific filters', () {
      const originalFilter = CampsiteFilter(
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguage: 'English',
      );

      final newFilter = originalFilter.clearFilter(
        clearCloseToWater: true,
        clearHostLanguage: true,
      );

      expect(newFilter.isCloseToWater, null);
      expect(newFilter.isCampFireAllowed, false);
      expect(newFilter.hostLanguage, null);
    });

    test('should maintain equality for same values', () {
      const filter1 = CampsiteFilter(
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguage: 'English',
        minPrice: 10.0,
        maxPrice: 50.0,
      );
      const filter2 = CampsiteFilter(
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguage: 'English',
        minPrice: 10.0,
        maxPrice: 50.0,
      );

      expect(filter1, filter2);
      expect(filter1.hashCode, filter2.hashCode);
    });

    test('should not be equal for different values', () {
      const filter1 = CampsiteFilter(isCloseToWater: true);
      const filter2 = CampsiteFilter(isCloseToWater: false);

      expect(filter1, isNot(filter2));
    });
  });
}