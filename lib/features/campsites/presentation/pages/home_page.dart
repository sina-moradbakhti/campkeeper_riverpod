import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campsite_providers.dart';
import '../providers/campsite_notifier.dart';
import '../widgets/campsite_list_view.dart';
import '../widgets/campsite_filter_bottom_sheet.dart';
import '../widgets/campsite_map_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(campsiteNotifierProvider.notifier).loadCampsites();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(campsiteFilterProvider);

    
    ref.listen<CampsiteState>(campsiteNotifierProvider, (previous, next) {
      if (next is CampsiteLoaded && previous is! CampsiteLoaded) {
        ref
            .read(campsiteFilterProvider.notifier)
            .updateAvailableOptions(next.campsites);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CampKeeper',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer,
          labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedLabelColor:
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
          tabs: const [
            Tab(
              icon: Icon(Icons.view_list_rounded),
            ),
            Tab(
              icon: Icon(Icons.map_outlined),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ]),
          padding: const EdgeInsets.all(10),
          child: Badge(
            isLabelVisible: filterState.filter.hasActiveFilters,
            child: Icon(
              Icons.tune,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        onPressed: () => _showFilterBottomSheet(context),
        tooltip: 'Filter campsites',
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CampsiteListView(),
          CampsiteMapView(),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const CampsiteFilterBottomSheet(),
    );
  }
}
