import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:campkeeper_riverpod/features/campsites/data/models/campsite_model.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCampsiteModel = CampsiteModel(
    id: '1',
    label: 'Beautiful Forest Campsite',
    geoLocationModel: const GeoLocationModel(lat: 52.5200, long: 13.4050),
    isCloseToWater: true,
    isCampFireAllowed: false,
    hostLanguages: const ['English'],
    pricePerNight: 25.0,
    photo: 'https://example.com/photo.jpg',
    createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
    suitableFor: const [],
  );

  test('should be able to convert to Campsite entity', () async {
    final entity = tCampsiteModel.toEntity();
    expect(entity, isA<Campsite>());
    expect(entity.id, tCampsiteModel.id);
    expect(entity.label, tCampsiteModel.label);
    expect(entity.isCloseToWater, tCampsiteModel.isCloseToWater);
  });

  group('fromJson', () {
    test('should return a valid model when the JSON contains valid data', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('campsite.json'));

      final result = CampsiteModel.fromJson(jsonMap);

      expect(result, isA<CampsiteModel>());
      expect(result.id, jsonMap['id']);
      expect(result.label, jsonMap['label']);
      expect(result.hostLanguages, jsonMap['hostLanguages']);
    });

    test('should handle invalid coordinates by generating valid ones', () async {
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'label': 'Test Campsite',
        'geoLocation': {
          'lat': 999.0, // Invalid latitude
          'long': 999.0, // Invalid longitude
        },
        'createdAt': '2022-09-11T14:25:09.496Z',
        'isCloseToWater': true,
        'isCampFireAllowed': false,
        'hostLanguages': ['English'],
        'pricePerNight': 25.0,
        'photo': 'https://example.com/photo.jpg',
        'suitableFor': [],
      };

      // act
      final result = CampsiteModel.fromJson(jsonMap);

      // assert
      expect(result.geoLocation.latitude, greaterThanOrEqualTo(45.0));
      expect(result.geoLocation.latitude, lessThanOrEqualTo(65.0));
      expect(result.geoLocation.longitude, greaterThanOrEqualTo(-10.0));
      expect(result.geoLocation.longitude, lessThanOrEqualTo(30.0));
    });

    test('should handle missing geoLocation by generating valid coordinates', () async {
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'label': 'Test Campsite',
        'createdAt': '2022-09-11T14:25:09.496Z',
        'isCloseToWater': true,
        'isCampFireAllowed': false,
        'hostLanguages': ['English'],
        'pricePerNight': 25.0,
        'photo': 'https://example.com/photo.jpg',
        'suitableFor': [],
      };

      final result = CampsiteModel.fromJson(jsonMap);

      expect(result.geoLocation.latitude, greaterThanOrEqualTo(45.0));
      expect(result.geoLocation.latitude, lessThanOrEqualTo(65.0));
      expect(result.geoLocation.longitude, greaterThanOrEqualTo(-10.0));
      expect(result.geoLocation.longitude, lessThanOrEqualTo(30.0));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tCampsiteModel.toJson();

      expect(result['id'], '1');
      expect(result['label'], 'Beautiful Forest Campsite');
      expect(result['isCloseToWater'], true);
      expect(result['isCampFireAllowed'], false);
      expect(result['hostLanguages'], ['English']);
      expect(result['pricePerNight'], 25.0);
      expect(result['photo'], 'https://example.com/photo.jpg');
      expect(result['suitableFor'], []);
      expect(result['createdAt'], '2022-09-11T14:25:09.496Z');
      expect(result.containsKey('geoLocation'), true);
    });
  });
}