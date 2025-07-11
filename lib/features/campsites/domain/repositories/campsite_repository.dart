import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/campsite.dart';

abstract class CampsiteRepository {
  Future<Either<Failure, List<Campsite>>> getCampsites();
}