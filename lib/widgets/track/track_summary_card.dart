import 'package:flutter/material.dart';

class TrackSummaryCard extends StatelessWidget {
  const TrackSummaryCard({
    super.key,
    required this.items,
    required this.totalLabel,
    required this.totalAmount,
  });

  final List<TrackSummaryItemData> items;
  final String totalLabel;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RITUAL SUMMARY',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 2.0,
              color: const Color(0xFF9C9D9D),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 22),
          for (var i = 0; i < items.length; i++) ...[
            _TrackSummaryItem(item: items[i]),
            if (i != items.length - 1) const SizedBox(height: 18),
          ],
          const SizedBox(height: 22),
          Container(height: 1, color: const Color(0xFFDADDDD)),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  totalLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    letterSpacing: 2.0,
                    color: const Color(0xFF9C9D9D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                totalAmount,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF815534),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrackSummaryItem extends StatelessWidget {
  const _TrackSummaryItem({required this.item});

  final TrackSummaryItemData item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF17191A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  letterSpacing: 0,
                  color: const Color(0xFF7A7F80),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          item.quantity.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF17191A),
          ),
        ),
      ],
    );
  }
}

class TrackSummaryItemData {
  const TrackSummaryItemData({
    required this.title,
    required this.subtitle,
    required this.quantity,
  });

  final String title;
  final String subtitle;
  final int quantity;
}
