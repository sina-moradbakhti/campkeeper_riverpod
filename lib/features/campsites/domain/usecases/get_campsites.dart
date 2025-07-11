import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/campsite.dart';
import '../repositories/campsite_repository.dart';

class GetCampsites {
  final CampsiteRepository repository;

  GetCampsites(this.repository);

  Future<Either<Failure, List<Campsite>>> call() async {
    return await repository.getCampsites();
  }
}