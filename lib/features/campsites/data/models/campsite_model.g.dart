// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campsite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampsiteModel _$CampsiteModelFromJson(Map<String, dynamic> json) =>
    CampsiteModel(
      id: json['id'] as String,
      label: json['label'] as String,
      geoLocationModel: GeoLocationModel.fromJson(
          json['geoLocation'] as Map<String, dynamic>),
      isCloseToWater: json['isCloseToWater'] as bool,
      isCampFireAllowed: json['isCampFireAllowed'] as bool,
      hostLanguages: (json['hostLanguages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      photo: json['photo'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      suitableFor: (json['suitableFor'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CampsiteModelToJson(CampsiteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'isCloseToWater': instance.isCloseToWater,
      'isCampFireAllowed': instance.isCampFireAllowed,
      'hostLanguages': instance.hostLanguages,
      'pricePerNight': instance.pricePerNight,
      'photo': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'suitableFor': instance.suitableFor,
      'geoLocation': instance.geoLocationModel,
    };

GeoLocationModel _$GeoLocationModelFromJson(Map<String, dynamic> json) =>
    GeoLocationModel(
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoLocationModelToJson(GeoLocationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };
