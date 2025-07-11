import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campsite_providers.dart';
import '../providers/campsite_notifier.dart';
import 'campsite_card.dart';
import 'loading_shimmer.dart';

class CampsiteListView extends ConsumerWidget {
  const CampsiteListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campsiteState = ref.watch(campsiteNotifierProvider);
    final filteredCampsites = ref.watch(filteredCampsitesProvider);

    if (campsiteState is CampsiteLoading) {
      return const LoadingShimmer();
    } else if (campsiteState is CampsiteLoaded) {
      if (filteredCampsites.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.nature_people_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No campsites found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Try adjusting your filters',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await ref.read(campsiteNotifierProvider.notifier).loadCampsites();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredCampsites.length,
          itemBuilder: (context, index) {
            final campsite = filteredCampsites[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CampsiteCard(campsite: campsite),
            );
          },
        ),
      );
    } else if (campsiteState is CampsiteError) {
      return Center(
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
              'Error loading campsites',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              campsiteState.message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref.read(campsiteNotifierProvider.notifier).loadCampsites();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return const LoadingShimmer();
  }
}