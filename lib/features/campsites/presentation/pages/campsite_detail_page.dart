import 'package:campkeeper_riverpod/core/utils/price_formatter.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/campsite.dart';

class CampsiteDetailPage extends StatelessWidget {
  final Campsite campsite;

  const CampsiteDetailPage({
    super.key,
    required this.campsite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: campsite.photo,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          campsite.label,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              PriceFormatter.formatEuro(campsite.pricePerNight),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                            Text(
                              'per night',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context: context,
                    title: 'Location',
                    icon: Icons.location_on,
                    children: [
                      _buildInfoRow(
                        icon: Icons.my_location,
                        label: 'Coordinates',
                        value:
                            '${campsite.geoLocation.latitude.toStringAsFixed(4)}, ${campsite.geoLocation.longitude.toStringAsFixed(4)}',
                        context: context,
                      ),
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        label: 'Created',
                        value:
                            '${campsite.createdAt.day}/${campsite.createdAt.month}/${campsite.createdAt.year}',
                        context: context,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context: context,
                    title: 'Host Information',
                    icon: Icons.person,
                    children: [
                      _buildInfoRow(
                        icon: Icons.language,
                        label: 'Languages',
                        value: campsite.hostLanguages.join(', '),
                        context: context,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context: context,
                    title: 'Amenities',
                    icon: Icons.local_offer,
                    children: [
                      _buildAmenityRow(
                        icon: Icons.water_drop,
                        label: 'Water nearby',
                        isAvailable: campsite.isCloseToWater,
                        context: context,
                      ),
                      _buildAmenityRow(
                        icon: Icons.local_fire_department,
                        label: 'Campfire allowed',
                        isAvailable: campsite.isCampFireAllowed,
                        context: context,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Booking functionality would be implemented here'),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityRow({
    required IconData icon,
    required String label,
    required bool isAvailable,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isAvailable
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isAvailable ? Colors.black87 : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            size: 20,
            color: isAvailable ? Colors.green : Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
