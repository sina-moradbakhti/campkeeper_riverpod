import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/campsite.dart';
import '../../domain/entities/campsite_filter.dart';
import '../../domain/usecases/get_campsites.dart';

part 'campsite_notifier.freezed.dart';

@freezed
class CampsiteState with _$CampsiteState {
  const factory CampsiteState.initial() = CampsiteInitial;
  const factory CampsiteState.loading() = CampsiteLoading;
  const factory CampsiteState.loaded({
    required List<Campsite> campsites,
  }) = CampsiteLoaded;
  const factory CampsiteState.error(String message) = CampsiteError;
}

class CampsiteNotifier extends StateNotifier<CampsiteState> {
  final GetCampsites _getCampsites;

  CampsiteNotifier(this._getCampsites) : super(const CampsiteState.initial());

  Future<void> loadCampsites() async {
    state = const CampsiteState.loading();

    final result = await _getCampsites();

    result.fold(
      (failure) => state = CampsiteState.error(failure.toString()),
      (campsites) {
        final updatedCampsites = campsites
            .map((campsite) => campsite.copyWith(
                  photo: campsite.photo.replaceFirst('http://', 'https://'),
                ))
            .toList();
        updatedCampsites.sort((a, b) => a.label.compareTo(b.label));
        state = CampsiteState.loaded(
          campsites: updatedCampsites,
        );
      },
    );
  }
}

@freezed
class CampsiteFilterState with _$CampsiteFilterState {
  const factory CampsiteFilterState({
    required CampsiteFilter filter,
    required List<String> availableCountries,
    required List<String> availableLanguages,
    required double minPrice,
    required double maxPrice,
  }) = _CampsiteFilterState;
}

class CampsiteFilterNotifier extends StateNotifier<CampsiteFilterState> {
  CampsiteFilterNotifier()
      : super(const CampsiteFilterState(
          filter: CampsiteFilter(),
          availableCountries: [],
          availableLanguages: [],
          minPrice: 0,
          maxPrice: 1000,
        ));

  void updateAvailableOptions(List<Campsite> campsites) {
    final languages = <String>{};
    for (final campsite in campsites) {
      languages.addAll(campsite.hostLanguages);
    }
    final languagesList = languages.where((l) => l.isNotEmpty).toList();
    final prices = campsites.map((c) => c.pricePerNight).toList();

    languagesList.sort();

    state = state.copyWith(
      availableCountries: [],
      availableLanguages: languagesList,
      minPrice: prices.isEmpty ? 0 : prices.reduce((a, b) => a < b ? a : b),
      maxPrice:
          prices.isEmpty ? 100000 : prices.reduce((a, b) => a > b ? a : b),
    );
  }

  void updateFilter(CampsiteFilter filter) {
    state = state.copyWith(filter: filter);
  }

  void clearFilter() {
    state = state.copyWith(filter: const CampsiteFilter());
  }
}
