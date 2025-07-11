import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/campsite_filter.dart';
import '../providers/campsite_providers.dart';

class CampsiteFilterBottomSheet extends ConsumerStatefulWidget {
  const CampsiteFilterBottomSheet({super.key});

  @override
  ConsumerState<CampsiteFilterBottomSheet> createState() =>
      _CampsiteFilterBottomSheetState();
}

class _CampsiteFilterBottomSheetState
    extends ConsumerState<CampsiteFilterBottomSheet> {
  late CampsiteFilter _currentFilter;
  late RangeValues _priceRange;

  @override
  void initState() {
    super.initState();
    final filterState = ref.read(campsiteFilterProvider);
    _currentFilter = filterState.filter;
    _priceRange = RangeValues(
      _currentFilter.minPrice ?? filterState.minPrice,
      _currentFilter.maxPrice ?? filterState.maxPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(campsiteFilterProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'Filter Campsites',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _clearAllFilters,
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    if (filterState.availableLanguages.isNotEmpty) ...[
                      _buildSectionTitle('Host Language'),
                      _buildDropdownFilter(
                        value: _currentFilter.hostLanguage,
                        items: filterState.availableLanguages,
                        hint: 'Select language',
                        onChanged: (value) {
                          setState(() {
                            _currentFilter =
                                _currentFilter.copyWith(hostLanguage: value);
                          });
                        },
                        onClear: () {
                          setState(() {
                            _currentFilter = _currentFilter.clearFilter(
                                clearHostLanguage: true);
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                    _buildSectionTitle('Price Range (€ per night)'),
                    const SizedBox(height: 8),
                    RangeSlider(
                      values: _priceRange,
                      min: filterState.minPrice,
                      max: filterState.maxPrice,
                      divisions: 20,
                      labels: RangeLabels(
                        '€${_priceRange.start.round()}',
                        '€${_priceRange.end.round()}',
                      ),
                      onChanged: (values) {
                        setState(() {
                          _priceRange = values;
                          _currentFilter = _currentFilter.copyWith(
                            minPrice: values.start,
                            maxPrice: values.end,
                          );
                        });
                      },
                    ),
                    Text(
                      '€${_priceRange.start.round()} - €${_priceRange.end.round()}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Amenities'),
                    const SizedBox(height: 8),
                    _buildSwitchTile(
                      title: 'Water nearby',
                      icon: Icons.water_drop,
                      value: _currentFilter.isCloseToWater,
                      onChanged: (value) {
                        setState(() {
                          _currentFilter =
                              _currentFilter.copyWith(isCloseToWater: value);
                        });
                      },
                    ),
                    _buildSwitchTile(
                      title: 'Campfire allowed',
                      icon: Icons.local_fire_department,
                      value: _currentFilter.isCampFireAllowed,
                      onChanged: (value) {
                        setState(() {
                          _currentFilter =
                              _currentFilter.copyWith(isCampFireAllowed: value);
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _applyFilters,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildDropdownFilter({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
    required VoidCallback onClear,
  }) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
        if (value != null) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: onClear,
            icon: const Icon(Icons.clear),
            tooltip: 'Clear filter',
          ),
        ],
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required IconData icon,
    required bool? value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Switch(
              value: value ?? false,
              onChanged: (newValue) {
                onChanged(newValue ? newValue : null);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    ref.read(campsiteFilterProvider.notifier).updateFilter(_currentFilter);
    Navigator.of(context).pop();
  }

  void _clearAllFilters() {
    setState(() {
      _currentFilter = const CampsiteFilter();
      final filterState = ref.read(campsiteFilterProvider);
      _priceRange = RangeValues(filterState.minPrice, filterState.maxPrice);
    });
  }
}
