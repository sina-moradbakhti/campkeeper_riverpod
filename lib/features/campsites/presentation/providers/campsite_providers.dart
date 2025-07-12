import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/network_info.dart';
import '../../data/datasources/campsite_remote_data_source.dart';
import '../../data/repositories/campsite_repository_impl.dart';
import '../../domain/repositories/campsite_repository.dart';
import '../../domain/usecases/get_campsites.dart';
import '../../domain/usecases/get_sorted_campsites.dart';
import '../../domain/entities/campsite.dart';
import '../../domain/entities/campsite_filter.dart';
import 'campsite_notifier.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl();
});

final campsiteRemoteDataSourceProvider =
    Provider<CampsiteRemoteDataSource>((ref) {
  return CampsiteRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final campsiteRepositoryProvider = Provider<CampsiteRepository>((ref) {
  return CampsiteRepositoryImpl(
    remoteDataSource: ref.watch(campsiteRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final getCampsitesUseCaseProvider = Provider<GetCampsites>((ref) {
  return GetCampsites(ref.watch(campsiteRepositoryProvider));
});

final getSortedCampsitesUseCaseProvider = Provider<GetSortedCampsites>((ref) {
  return GetSortedCampsites(ref.watch(getCampsitesUseCaseProvider));
});

final campsiteNotifierProvider =
    StateNotifierProvider<CampsiteNotifier, CampsiteState>((ref) {
  return CampsiteNotifier(ref.watch(getSortedCampsitesUseCaseProvider));
});

final campsiteFilterProvider =
    StateNotifierProvider<CampsiteFilterNotifier, CampsiteFilterState>((ref) {
  return CampsiteFilterNotifier();
});

final filteredCampsitesProvider = Provider<List<Campsite>>((ref) {
  final campsiteState = ref.watch(campsiteNotifierProvider);
  final filterState = ref.watch(campsiteFilterProvider);

  return campsiteState.when(
    initial: () => [],
    loading: () => [],
    loaded: (campsites) => _applyFilter(campsites, filterState.filter),
    error: (_) => [],
  );
});

List<Campsite> _applyFilter(List<Campsite> campsites, CampsiteFilter filter) {
  return campsites.where((campsite) {
    if (filter.isCloseToWater != null &&
        campsite.isCloseToWater != filter.isCloseToWater) {
      return false;
    }
    if (filter.isCampFireAllowed != null &&
        campsite.isCampFireAllowed != filter.isCampFireAllowed) {
      return false;
    }
    if (filter.hostLanguage != null &&
        !campsite.hostLanguages.contains(filter.hostLanguage)) {
      return false;
    }
    if (filter.minPrice != null && campsite.pricePerNight < filter.minPrice!) {
      return false;
    }
    if (filter.maxPrice != null && campsite.pricePerNight > filter.maxPrice!) {
      return false;
    }
    return true;
  }).toList();
}
