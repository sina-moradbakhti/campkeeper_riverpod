import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/campsite.dart';
import '../../domain/repositories/campsite_repository.dart';
import '../datasources/campsite_remote_data_source.dart';

class CampsiteRepositoryImpl implements CampsiteRepository {
  final CampsiteRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CampsiteRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Campsite>>> getCampsites() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCampsites = await remoteDataSource.getCampsites();
        final entities = remoteCampsites.map((model) => model.toEntity()).toList();
        return Right(entities);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
