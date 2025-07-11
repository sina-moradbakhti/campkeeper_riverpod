import 'package:flutter_test/flutter_test.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';

void main() {
  group('Campsite', () {
    final testCampsite = Campsite(
      id: '1',
      label: 'Test Campsite',
      geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
      isCloseToWater: true,
      isCampFireAllowed: false,
      hostLanguages: const ['English', 'German'],
      pricePerNight: 25.0,
      photo: 'https://example.com/photo.jpg',
      createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
      suitableFor: const ['families', 'couples'],
    );

    test('should maintain equality for same values', () {
      final campsite1 = Campsite(
        id: '1',
        label: 'Test Campsite',
        geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguages: const ['English', 'German'],
        pricePerNight: 25.0,
        photo: 'https://example.com/photo.jpg',
        createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
        suitableFor: const ['families', 'couples'],
      );

      final campsite2 = Campsite(
        id: '1',
        label: 'Test Campsite',
        geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguages: const ['English', 'German'],
        pricePerNight: 25.0,
        photo: 'https://example.com/photo.jpg',
        createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
        suitableFor: const ['families', 'couples'],
      );

      expect(campsite1, campsite2);
      expect(campsite1.hashCode, campsite2.hashCode);
    });

    test('should not be equal for different values', () {
      final campsite1 = testCampsite;
      final campsite2 = Campsite(
        id: '2',
        label: 'Different Campsite',
        geoLocation: const GeoLocation(lat: 51.0, long: 11.0),
        isCloseToWater: false,
        isCampFireAllowed: true,
        hostLanguages: const ['French'],
        pricePerNight: 35.0,
        photo: 'https://example.com/photo2.jpg',
        createdAt: DateTime.parse('2022-09-11T15:25:09.496Z'),
        suitableFor: const ['solo'],
      );

      expect(campsite1, isNot(campsite2));
    });

    test('should have correct properties', () {
      expect(testCampsite.id, '1');
      expect(testCampsite.label, 'Test Campsite');
      expect(testCampsite.geoLocation.lat, 50.0);
      expect(testCampsite.geoLocation.long, 10.0);
      expect(testCampsite.isCloseToWater, true);
      expect(testCampsite.isCampFireAllowed, false);
      expect(testCampsite.hostLanguages, ['English', 'German']);
      expect(testCampsite.pricePerNight, 25.0);
      expect(testCampsite.photo, 'https://example.com/photo.jpg');
      expect(testCampsite.suitableFor, ['families', 'couples']);
    });
  });

  group('GeoLocation', () {
    test('should maintain equality for same coordinates', () {
      const location1 = GeoLocation(lat: 50.0, long: 10.0);
      const location2 = GeoLocation(lat: 50.0, long: 10.0);

      expect(location1, location2);
      expect(location1.hashCode, location2.hashCode);
    });

    test('should not be equal for different coordinates', () {
      const location1 = GeoLocation(lat: 50.0, long: 10.0);
      const location2 = GeoLocation(lat: 51.0, long: 11.0);

      expect(location1, isNot(location2));
    });

    test('should provide backward compatibility getters', () {
      const location = GeoLocation(lat: 50.0, long: 10.0);

      expect(location.latitude, 50.0);
      expect(location.longitude, 10.0);
    });
  });
}