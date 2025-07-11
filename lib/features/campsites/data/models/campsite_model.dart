import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/campsite.dart';
import 'dart:math' as math;

part 'campsite_model.g.dart';

@JsonSerializable()
class CampsiteModel {
  final String id;
  final String label;
  @JsonKey(name: 'geoLocation')
  final GeoLocationModel geoLocationModel;
  final bool isCloseToWater;
  final bool isCampFireAllowed;
  final List<String> hostLanguages;
  final double pricePerNight;
  final String photo;
  final DateTime createdAt;
  final List<String> suitableFor;

  const CampsiteModel({
    required this.id,
    required this.label,
    required this.geoLocationModel,
    required this.isCloseToWater,
    required this.isCampFireAllowed,
    required this.hostLanguages,
    required this.pricePerNight,
    required this.photo,
    required this.createdAt,
    required this.suitableFor,
  });

  // Getter for backward compatibility with tests
  GeoLocationModel get geoLocation => geoLocationModel;

  Campsite toEntity() {
    return Campsite(
      id: id,
      label: label,
      geoLocation: geoLocationModel.toEntity(),
      isCloseToWater: isCloseToWater,
      isCampFireAllowed: isCampFireAllowed,
      hostLanguages: hostLanguages,
      pricePerNight: pricePerNight,
      photo: photo,
      createdAt: createdAt,
      suitableFor: suitableFor,
    );
  }

  factory CampsiteModel.fromJson(Map<String, dynamic> json) {
    final geoLocationData = json['geoLocation'] as Map<String, dynamic>?;
    GeoLocationModel geoLocation;

    if (geoLocationData != null) {
      double lat = (geoLocationData['lat'] as num?)?.toDouble() ?? 0.0;
      double lng = (geoLocationData['long'] as num?)?.toDouble() ?? 0.0;

      if (lat < -90 || lat > 90 || lng < -180 || lng > 180) {
        lat = 45.0 + (math.Random().nextDouble() * 20.0);
        lng = -10.0 + (math.Random().nextDouble() * 40.0);
      }

      geoLocation = GeoLocationModel(lat: lat, long: lng);
    } else {
      final random = math.Random();
      geoLocation = GeoLocationModel(
        lat: 45.0 + (random.nextDouble() * 20.0),
        long: -10.0 + (random.nextDouble() * 40.0),
      );
    }

    final hostLanguagesData = json['hostLanguages'] as List<dynamic>?;
    final hostLanguages =
        hostLanguagesData?.map((e) => e.toString()).toList() ?? <String>[];

    final suitableForData = json['suitableFor'] as List<dynamic>?;
    final suitableFor =
        suitableForData?.map((e) => e.toString()).toList() ?? <String>[];

    final createdAtString = json['createdAt']?.toString() ?? '';
    DateTime createdAt;
    try {
      createdAt = DateTime.parse(createdAtString);
    } catch (e) {
      createdAt = DateTime.now();
    }

    return CampsiteModel(
      id: json['id']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      geoLocationModel: geoLocation,
      isCloseToWater: json['isCloseToWater'] as bool? ?? false,
      isCampFireAllowed: json['isCampFireAllowed'] as bool? ?? false,
      hostLanguages: hostLanguages,
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble() ?? 0.0,
      photo: json['photo']?.toString() ?? '',
      createdAt: createdAt,
      suitableFor: suitableFor,
    );
  }

  Map<String, dynamic> toJson() => _$CampsiteModelToJson(this);
}

@JsonSerializable()
class GeoLocationModel {
  final double lat;
  final double long;

  const GeoLocationModel({
    required this.lat,
    required this.long,
  });

  // Getters for backward compatibility with tests
  double get latitude => lat;
  double get longitude => long;

  GeoLocation toEntity() {
    return GeoLocation(
      lat: lat,
      long: long,
    );
  }

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationModelToJson(this);
}
