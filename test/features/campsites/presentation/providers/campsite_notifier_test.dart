import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:campkeeper_riverpod/features/campsites/presentation/providers/campsite_notifier.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/usecases/get_sorted_campsites.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';
import 'package:campkeeper_riverpod/core/error/failures.dart';

import 'campsite_notifier_test.mocks.dart';

@GenerateMocks([GetSortedCampsites])
void main() {
  late CampsiteNotifier notifier;
  late MockGetSortedCampsites mockGetSortedCampsites;

  setUp(() {
    mockGetSortedCampsites = MockGetSortedCampsites();
    notifier = CampsiteNotifier(mockGetSortedCampsites);
  });

  final tCampsites = [
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

  group('loadCampsites', () {
    test('should emit loading state then loaded state when data is gotten successfully', () async {
      when(mockGetSortedCampsites()).thenAnswer((_) async => Right(tCampsites));

      final expected = [
        const CampsiteState.loading(),
        CampsiteState.loaded(campsites: tCampsites),
      ];
      expectLater(notifier.stream, emitsInOrder(expected));

      await notifier.loadCampsites();
    });

    test('should emit loading state then error state when getting data fails', () async {
      const tFailure = ServerFailure('Server error');
      when(mockGetSortedCampsites()).thenAnswer((_) async => const Left(tFailure));

      final expected = [
        const CampsiteState.loading(),
        const CampsiteState.error('ServerFailure(Server error)'),
      ];
      expectLater(notifier.stream, emitsInOrder(expected));

      await notifier.loadCampsites();
    });

    test('should receive already sorted campsites from use case', () async {
      final sortedCampsites = [
        Campsite(
          id: '1',
          label: 'A Campsite',
          geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
          isCloseToWater: true,
          isCampFireAllowed: false,
          hostLanguages: const ['English'],
          pricePerNight: 25.0,
          photo: 'https://example.com/photo.jpg',
          createdAt: DateTime.now(),
          suitableFor: const [],
        ),
        Campsite(
          id: '2',
          label: 'Z Campsite',
          geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
          isCloseToWater: true,
          isCampFireAllowed: false,
          hostLanguages: const ['English'],
          pricePerNight: 25.0,
          photo: 'https://example.com/photo.jpg',
          createdAt: DateTime.now(),
          suitableFor: const [],
        ),
      ];
      when(mockGetSortedCampsites()).thenAnswer((_) async => Right(sortedCampsites));

      await notifier.loadCampsites();

      notifier.state.when(
        initial: () => fail('Should not be initial'),
        loading: () => fail('Should not be loading'),
        loaded: (campsites) {
          expect(campsites.first.label, 'A Campsite');
          expect(campsites.last.label, 'Z Campsite');
        },
        error: (_) => fail('Should not be error'),
      );
    });
  });
}