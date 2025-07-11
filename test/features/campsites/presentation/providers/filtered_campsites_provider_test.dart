import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campkeeper_riverpod/features/campsites/presentation/providers/campsite_providers.dart';
import 'package:campkeeper_riverpod/features/campsites/presentation/providers/campsite_notifier.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite_filter.dart';

void main() {
  group('filteredCampsitesProvider', () {
    late ProviderContainer container;

    final testCampsites = [
      Campsite(
        id: '1',
        label: 'Test Campsite 1',
        geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguages: const ['English', 'German'],
        pricePerNight: 25.0,
        photo: 'https://example.com/photo1.jpg',
        createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
        suitableFor: const [],
      ),
      Campsite(
        id: '2',
        label: 'Test Campsite 2',
        geoLocation: const GeoLocation(lat: 51.0, long: 11.0),
        isCloseToWater: false,
        isCampFireAllowed: true,
        hostLanguages: const ['French'],
        pricePerNight: 35.0,
        photo: 'https://example.com/photo2.jpg',
        createdAt: DateTime.parse('2022-09-11T15:25:09.496Z'),
        suitableFor: const [],
      ),
    ];

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should return empty list when campsites are not loaded', () {
      final result = container.read(filteredCampsitesProvider);

      expect(result, isEmpty);
    });

    test('should return all campsites when no filter is applied', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 2);
    });

    test('should filter campsites by water proximity', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );
      container.read(campsiteFilterProvider.notifier).updateFilter(
            const CampsiteFilter(isCloseToWater: true),
          );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 1);
      expect(result.first.isCloseToWater, true);
    });

    test('should filter campsites by campfire allowed', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );
      container.read(campsiteFilterProvider.notifier).updateFilter(
            const CampsiteFilter(isCampFireAllowed: true),
          );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 1);
      expect(result.first.isCampFireAllowed, true);
    });

    test('should filter campsites by host language', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );
      container.read(campsiteFilterProvider.notifier).updateFilter(
            const CampsiteFilter(hostLanguage: 'French'),
          );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 1);
      expect(result.first.hostLanguages.contains('French'), true);
    });

    test('should filter campsites by price range', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );
      container.read(campsiteFilterProvider.notifier).updateFilter(
            const CampsiteFilter(minPrice: 30.0, maxPrice: 40.0),
          );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 1);
      expect(result.first.pricePerNight, 35.0);
    });

    test('should return empty list when no campsites match filter', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );
      container.read(campsiteFilterProvider.notifier).updateFilter(
            const CampsiteFilter(hostLanguage: 'Spanish'),
          );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 0);
    });

    test('should apply multiple filters', () {
      container.read(campsiteNotifierProvider.notifier).state = CampsiteLoaded(
        campsites: testCampsites,
      );
      container.read(campsiteFilterProvider.notifier).updateFilter(
            const CampsiteFilter(
              isCloseToWater: false,
              isCampFireAllowed: true,
              hostLanguage: 'French',
            ),
          );

      final result = container.read(filteredCampsitesProvider);

      expect(result.length, 1);
      final campsite = result.first;
      expect(campsite.isCloseToWater, false);
      expect(campsite.isCampFireAllowed, true);
      expect(campsite.hostLanguages.contains('French'), true);
    });
  });
}
