import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/campsite.dart';
import '../../domain/entities/campsite_filter.dart';
import '../../domain/usecases/get_campsites.dart';

abstract class CampsiteState extends Equatable {
  const CampsiteState();

  @override
  List<Object> get props => [];
}

class CampsiteInitial extends CampsiteState {}

class CampsiteLoading extends CampsiteState {}

class CampsiteLoaded extends CampsiteState {
  final List<Campsite> campsites;

  const CampsiteLoaded({
    required this.campsites,
  });

  @override
  List<Object> get props => [campsites];
}

class CampsiteError extends CampsiteState {
  final String message;

  const CampsiteError(this.message);

  @override
  List<Object> get props => [message];
}

class CampsiteNotifier extends StateNotifier<CampsiteState> {
  final GetCampsites _getCampsites;

  CampsiteNotifier(this._getCampsites) : super(CampsiteInitial());

  Future<void> loadCampsites() async {
    state = CampsiteLoading();

    final result = await _getCampsites();

    result.fold(
      (failure) => state = CampsiteError(failure.toString()),
      (campsites) {
        campsites.sort((a, b) => a.label.compareTo(b.label));
        state = CampsiteLoaded(
          campsites: campsites,
        );
      },
    );
  }
}

class CampsiteFilterState extends Equatable {
  final CampsiteFilter filter;
  final List<String> availableCountries;
  final List<String> availableLanguages;
  final double minPrice;
  final double maxPrice;

  const CampsiteFilterState({
    required this.filter,
    required this.availableCountries,
    required this.availableLanguages,
    required this.minPrice,
    required this.maxPrice,
  });

  CampsiteFilterState copyWith({
    CampsiteFilter? filter,
    List<String>? availableCountries,
    List<String>? availableLanguages,
    double? minPrice,
    double? maxPrice,
  }) {
    return CampsiteFilterState(
      filter: filter ?? this.filter,
      availableCountries: availableCountries ?? this.availableCountries,
      availableLanguages: availableLanguages ?? this.availableLanguages,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object> get props =>
      [filter, availableCountries, availableLanguages, minPrice, maxPrice];
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
