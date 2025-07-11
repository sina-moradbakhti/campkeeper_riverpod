import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/campsite_model.dart';

abstract class CampsiteRemoteDataSource {
  Future<List<CampsiteModel>> getCampsites();
}

class CampsiteRemoteDataSourceImpl implements CampsiteRemoteDataSource {
  final Dio dio;

  CampsiteRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CampsiteModel>> getCampsites() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.campsitesEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> campsitesList = response.data as List<dynamic>;
        return campsitesList
            .map((json) => CampsiteModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to load campsites: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Server error: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}