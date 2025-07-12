import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/usecases/get_campsites.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/usecases/get_sorted_campsites.dart';
import 'package:campkeeper_riverpod/core/error/failures.dart';

import 'get_sorted_campsites_test.mocks.dart';

@GenerateMocks([GetCampsites])
void main() {
  late GetSortedCampsites usecase;
  late MockGetCampsites mockGetCampsites;

  setUp(() {
    mockGetCampsites = MockGetCampsites();
    usecase = GetSortedCampsites(mockGetCampsites);
  });

  final tUnsortedCampsites = [
    Campsite(
      id: '2',
      label: 'Z Campsite',
      geoLocation: const GeoLocation(lat: 50.0, long: 10.0),
      isCloseToWater: true,
      isCampFireAllowed: false,
      hostLanguages: const ['English'],
      pricePerNight: 25.0,
      photo: 'https://example.com/photo.jpg',
      createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
      suitableFor: const [],
    ),
    Campsite(
      id: '1',
      label: 'A Campsite',
      geoLocation: const GeoLocation(lat: 51.0, long: 11.0),
      isCloseToWater: false,
      isCampFireAllowed: true,
      hostLanguages: const ['French'],
      pricePerNight: 35.0,
      photo: 'https://example.com/photo2.jpg',
      createdAt: DateTime.parse('2022-09-11T15:25:09.496Z'),
      suitableFor: const [],
    ),
    Campsite(
      id: '3',
      label: 'M Campsite',
      geoLocation: const GeoLocation(lat: 52.0, long: 12.0),
      isCloseToWater: true,
      isCampFireAllowed: true,
      hostLanguages: const ['German'],
      pricePerNight: 30.0,
      photo: 'https://example.com/photo3.jpg',
      createdAt: DateTime.parse('2022-09-11T16:25:09.496Z'),
      suitableFor: const [],
    ),
  ];

  test('should get sorted campsites from GetCampsites use case', () async {
    when(mockGetCampsites())
        .thenAnswer((_) async => Right(tUnsortedCampsites));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Should not return failure'),
      (campsites) {
        expect(campsites.length, 3);
        expect(campsites[0].label, 'A Campsite');
        expect(campsites[1].label, 'M Campsite');
        expect(campsites[2].label, 'Z Campsite');
      },
    );
    verify(mockGetCampsites());
    verifyNoMoreInteractions(mockGetCampsites);
  });

  test('should return failure when GetCampsites fails', () async {
    const tFailure = ServerFailure('Server error');
    when(mockGetCampsites())
        .thenAnswer((_) async => const Left(tFailure));

    final result = await usecase();

    expect(result, const Left(tFailure));
    verify(mockGetCampsites());
    verifyNoMoreInteractions(mockGetCampsites);
  });

  test('should handle empty list', () async {
    when(mockGetCampsites())
        .thenAnswer((_) async => const Right([]));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Should not return failure'),
      (campsites) {
        expect(campsites.length, 0);
      },
    );
    verify(mockGetCampsites());
    verifyNoMoreInteractions(mockGetCampsites);
  });

  test('should not modify original list', () async {
    final originalList = List<Campsite>.from(tUnsortedCampsites);
    when(mockGetCampsites())
        .thenAnswer((_) async => Right(tUnsortedCampsites));

    final result = await usecase();

    // Verify original list order is unchanged
    expect(tUnsortedCampsites[0].label, 'Z Campsite');
    expect(tUnsortedCampsites[1].label, 'A Campsite');
    expect(tUnsortedCampsites[2].label, 'M Campsite');

    // Verify returned list is sorted
    result.fold(
      (failure) => fail('Should not return failure'),
      (campsites) {
        expect(campsites[0].label, 'A Campsite');
        expect(campsites[1].label, 'M Campsite');
        expect(campsites[2].label, 'Z Campsite');
      },
    );
  });
}