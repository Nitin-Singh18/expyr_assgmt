import 'package:flutter/material.dart';

import '../common/extensions/context_extension.dart';
import '../common/utils.dart';
import '../models/item_data.dart';
import '../theme/app_color.dart';

/// A dismissible card widget representing an item.
class ItemCard extends StatelessWidget {
  /// The title displayed when the item is swiped away.
  final String dismissibleTitle;

  /// The food item data.
  final ItemData item;

  /// Callback function triggered when the item is dismissed.
  final Function(DismissDirection) onDismissed;

  const ItemCard({
    super.key,
    required this.item,
    required this.onDismissed,
    required this.dismissibleTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id!),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      background: _buildDismissibleBackGround(context),
      child: _buildItemContent(context),
    );
  }

  /// Builds the main content of the item card.
  Widget _buildItemContent(BuildContext context) => Card(
        child: ListTile(
          title: Text(
            item.name,
            style: context.textTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemInfo(
                context: context,
                label: 'Expires',
                value: item.expiry,
              ),
              _buildItemInfo(
                context: context,
                label: 'Location',
                value: item.location,
              ),
              if (item.quantity > 1)
                _buildItemInfo(
                    context: context,
                    label: 'Quantity',
                    value: item.quantity.toString()),
              if (item.isConsumed)
                _buildItemInfo(
                  context: context,
                  label: 'Consumed on',
                  value: formatDateTime(item.consumedAt!),
                )
            ],
          ),
        ),
      );

  /// Builds an information field inside the card.
  Widget _buildItemInfo({
    required BuildContext context,
    required String label,
    required String value,
  }) =>
      Text(
        '$label: $value',
        style: context.textTheme.labelMedium,
      );

  /// Builds the background shown when the item is dismissed.
  Widget _buildDismissibleBackGround(BuildContext context) => Container(
        color: AppColor.green,
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              dismissibleTitle,
              style: context.textTheme.titleMedium
                  ?.copyWith(color: AppColor.white),
            ),
            hGap(12),
            const Icon(Icons.check, color: Colors.white)
          ],
        ),
      );
}
