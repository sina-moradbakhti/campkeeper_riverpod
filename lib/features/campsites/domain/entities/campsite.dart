import 'package:freezed_annotation/freezed_annotation.dart';

part 'campsite.freezed.dart';

@freezed
class Campsite with _$Campsite {
  const factory Campsite({
    required String id,
    required String label,
    required GeoLocation geoLocation,
    required bool isCloseToWater,
    required bool isCampFireAllowed,
    required List<String> hostLanguages,
    required double pricePerNight,
    required String photo,
    required DateTime createdAt,
    required List<String> suitableFor,
  }) = _Campsite;
}

@freezed
class GeoLocation with _$GeoLocation {
  const factory GeoLocation({
    required double lat,
    required double long,
  }) = _GeoLocation;
}

extension GeoLocationExtension on GeoLocation {
  double get latitude => lat;
  double get longitude => long;
}
