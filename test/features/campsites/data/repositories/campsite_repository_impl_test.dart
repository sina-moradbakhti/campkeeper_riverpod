import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:campkeeper_riverpod/features/campsites/data/repositories/campsite_repository_impl.dart';
import 'package:campkeeper_riverpod/features/campsites/data/datasources/campsite_remote_data_source.dart';
import 'package:campkeeper_riverpod/features/campsites/data/models/campsite_model.dart';
import 'package:campkeeper_riverpod/core/network/network_info.dart';
import 'package:campkeeper_riverpod/core/error/exceptions.dart';
import 'package:campkeeper_riverpod/core/error/failures.dart';

import 'campsite_repository_impl_test.mocks.dart';

@GenerateMocks([CampsiteRemoteDataSource, NetworkInfo])
void main() {
  late CampsiteRepositoryImpl repository;
  late MockCampsiteRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCampsiteRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CampsiteRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tCampsiteModels = [
    CampsiteModel(
      id: '1',
      label: 'Test Campsite',
      geoLocationModel: const GeoLocationModel(lat: 50.0, long: 10.0),
      isCloseToWater: true,
      isCampFireAllowed: false,
      hostLanguages: const ['English'],
      pricePerNight: 25.0,
      photo: 'https://example.com/photo.jpg',
      createdAt: DateTime.parse('2022-09-11T14:25:09.496Z'),
      suitableFor: const [],
    ),
  ];

  group('getCampsites', () {
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCampsites())
          .thenAnswer((_) async => tCampsiteModels);

      await repository.getCampsites();

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getCampsites())
            .thenAnswer((_) async => tCampsiteModels);

        final result = await repository.getCampsites();

        verify(mockRemoteDataSource.getCampsites());
        expect(result, Right(tCampsiteModels));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getCampsites())
            .thenThrow(const ServerException('Server error'));

        final result = await repository.getCampsites();

        verify(mockRemoteDataSource.getCampsites());
        expect(result, const Left(ServerFailure('Server error')));
      });

      test(
          'should return network failure when the call to remote data source throws NetworkException',
          () async {
        when(mockRemoteDataSource.getCampsites())
            .thenThrow(const NetworkException('Network error'));

        final result = await repository.getCampsites();

        verify(mockRemoteDataSource.getCampsites());
        expect(result, const Left(NetworkFailure('Network error')));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when device is offline', () async {
        final result = await repository.getCampsites();

        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure('No internet connection')));
      });
    });
  });
}
