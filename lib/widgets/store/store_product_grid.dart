import 'package:flutter/material.dart';
import 'package:pavilijon_app/widgets/store/store_product_card.dart';

class StoreProductGrid extends StatelessWidget {
  const StoreProductGrid({super.key, required this.products});

  final List<StoreProductData> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 860;

        if (!isWide) {
          return Column(
            children: [
              for (var i = 0; i < products.length; i++) ...[
                StoreProductCard(data: products[i]),
                if (i != products.length - 1) const SizedBox(height: 28),
              ],
            ],
          );
        }

        final leftColumn = [products[0], products[2]];
        final rightColumn = [products[1], products[3]];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < leftColumn.length; i++) ...[
                    StoreProductCard(data: leftColumn[i]),
                    if (i != leftColumn.length - 1) const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 28),
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < rightColumn.length; i++) ...[
                    StoreProductCard(
                      data: rightColumn[i],
                      addTopSpacing: i == 0,
                    ),
                    if (i != rightColumn.length - 1) const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
