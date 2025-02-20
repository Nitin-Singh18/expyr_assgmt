import 'package:flutter/material.dart';

import '../common/extensions/context_extension.dart';
import '../common/utils.dart';
import '../models/item_data.dart';
import '../theme/app_color.dart';

class ItemCard extends StatelessWidget {
  final String dismissibleTitle;
  final ItemData item;
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

  Widget _buildItemInfo({
    required BuildContext context,
    required String label,
    required String value,
  }) =>
      Text(
        '$label: $value',
        style: context.textTheme.labelMedium,
      );

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
