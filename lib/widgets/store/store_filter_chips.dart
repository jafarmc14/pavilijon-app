import 'package:flutter/material.dart';

class StoreFilterChips extends StatelessWidget {
  const StoreFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    const filters = [
      _StoreFilterData(label: 'All Collections', active: true),
      _StoreFilterData(label: 'Beans'),
      _StoreFilterData(label: 'Equipment'),
      _StoreFilterData(label: 'Gifts'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          for (var i = 0; i < filters.length; i++) ...[
            _StoreFilterChip(data: filters[i]),
            if (i != filters.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _StoreFilterChip extends StatelessWidget {
  const _StoreFilterChip({required this.data});

  final _StoreFilterData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: data.active ? const Color(0xFF5F5E5E) : const Color(0xFFE4E9EA),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        data.label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontSize: 9,
          letterSpacing: 1.8,
          color: data.active
              ? const Color(0xFFFAF7F6)
              : const Color(0xFF5A6061),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StoreFilterData {
  const _StoreFilterData({required this.label, this.active = false});

  final String label;
  final bool active;
}
