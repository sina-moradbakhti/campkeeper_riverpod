import 'package:equatable/equatable.dart';

class Campsite extends Equatable {
  final String id;
  final String label;
  final GeoLocation geoLocation;
  final bool isCloseToWater;
  final bool isCampFireAllowed;
  final List<String> hostLanguages;
  final double pricePerNight;
  final String photo;
  final DateTime createdAt;
  final List<String> suitableFor;

  const Campsite({
    required this.id,
    required this.label,
    required this.geoLocation,
    required this.isCloseToWater,
    required this.isCampFireAllowed,
    required this.hostLanguages,
    required this.pricePerNight,
    required this.photo,
    required this.createdAt,
    required this.suitableFor,
  });

  @override
  List<Object?> get props => [
        id,
        label,
        geoLocation,
        isCloseToWater,
        isCampFireAllowed,
        hostLanguages,
        pricePerNight,
        photo,
        createdAt,
        suitableFor,
      ];
}

class GeoLocation extends Equatable {
  final double lat;
  final double long;

  const GeoLocation({
    required this.lat,
    required this.long,
  });

  double get latitude => lat;
  double get longitude => long;

  @override
  List<Object?> get props => [lat, long];
}
