import 'package:campkeeper_riverpod/core/utils/price_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/campsite.dart';
import '../providers/campsite_providers.dart';
import '../pages/campsite_detail_page.dart';

class CampsiteMapView extends ConsumerStatefulWidget {
  const CampsiteMapView({super.key});

  @override
  ConsumerState<CampsiteMapView> createState() => _CampsiteMapViewState();
}

class _CampsiteMapViewState extends ConsumerState<CampsiteMapView> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final campsiteState = ref.watch(campsiteNotifierProvider);
    final filteredCampsites = ref.watch(filteredCampsitesProvider);

    return campsiteState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (campsites) {
        if (filteredCampsites.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore_off,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No campsites to show on map',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        return _buildMap(filteredCampsites);
      },
      error: (message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading map',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(List<Campsite> campsites) {
    final markers = campsites.map((campsite) {
      return Marker(
        point: LatLng(
          campsite.geoLocation.latitude,
          campsite.geoLocation.longitude,
        ),
        width: 55,
        height: 55,
        child: GestureDetector(
          onTap: () => _onMarkerTapped(campsite),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bungalow_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(
                          0.7,
                        ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '€ ${PriceFormatter.formatEuroWithoutSymbol(
                      campsite.pricePerNight,
                    )}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    final bounds = _calculateBounds(campsites);

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: bounds?.center ?? const LatLng(50.0, 10.0),
        initialZoom: bounds != null ? 6.0 : 6.0,
        minZoom: 3.0,
        maxZoom: 18.0,
        onMapReady: () {
          if (bounds != null && campsites.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 100), () {
              _mapController.fitCamera(
                CameraFit.bounds(
                  bounds: bounds,
                  padding: const EdgeInsets.all(50),
                ),
              );
            });
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.campkeeper_riverpod',
          maxZoom: 19,
        ),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 100,
            size: const Size(40, 40),
            markers: markers,
            builder: (context, markers) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onMarkerTapped(Campsite campsite) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CampsiteDetailPage(campsite: campsite),
      ),
    );
  }

  LatLngBounds? _calculateBounds(List<Campsite> campsites) {
    if (campsites.isEmpty) return null;

    double minLat = campsites.first.geoLocation.latitude;
    double maxLat = campsites.first.geoLocation.latitude;
    double minLng = campsites.first.geoLocation.longitude;
    double maxLng = campsites.first.geoLocation.longitude;

    for (final campsite in campsites) {
      minLat = minLat < campsite.geoLocation.latitude
          ? minLat
          : campsite.geoLocation.latitude;
      maxLat = maxLat > campsite.geoLocation.latitude
          ? maxLat
          : campsite.geoLocation.latitude;
      minLng = minLng < campsite.geoLocation.longitude
          ? minLng
          : campsite.geoLocation.longitude;
      maxLng = maxLng > campsite.geoLocation.longitude
          ? maxLng
          : campsite.geoLocation.longitude;
    }

    return LatLngBounds(
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );
  }
}
