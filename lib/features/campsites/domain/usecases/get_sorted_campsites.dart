import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/campsite.dart';
import 'get_campsites.dart';

class GetSortedCampsites {
  final GetCampsites _getCampsites;

  GetSortedCampsites(this._getCampsites);

  Future<Either<Failure, List<Campsite>>> call() async {
    final result = await _getCampsites();
    
    return result.map((campsites) {
      final sortedCampsites = List<Campsite>.from(campsites);
      sortedCampsites.sort((a, b) => a.label.compareTo(b.label));
      return sortedCampsites;
    });
  }
}