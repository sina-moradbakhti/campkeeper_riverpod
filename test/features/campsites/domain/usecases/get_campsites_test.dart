import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/repositories/campsite_repository.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/usecases/get_campsites.dart';
import 'package:campkeeper_riverpod/core/error/failures.dart';

import 'get_campsites_test.mocks.dart';

@GenerateMocks([CampsiteRepository])
void main() {
  late GetCampsites usecase;
  late MockCampsiteRepository mockRepository;

  setUp(() {
    mockRepository = MockCampsiteRepository();
    usecase = GetCampsites(mockRepository);
  });

  final tCampsites = [
    Campsite(
      id: '1',
      label: 'Test Campsite',
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

  test('should get campsites from the repository', () async {
    when(mockRepository.getCampsites())
        .thenAnswer((_) async => Right(tCampsites));

    final result = await usecase();

    expect(result, Right(tCampsites));
    verify(mockRepository.getCampsites());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    const tFailure = ServerFailure('Server error');
    when(mockRepository.getCampsites())
        .thenAnswer((_) async => const Left(tFailure));

    final result = await usecase();

    expect(result, const Left(tFailure));
    verify(mockRepository.getCampsites());
    verifyNoMoreInteractions(mockRepository);
  });
}