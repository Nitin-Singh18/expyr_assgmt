import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/utils.dart';
import '../providers/items_provider.dart';
import '../widgets/item_card.dart';

class ConsumedItemsScreen extends StatelessWidget {
  const ConsumedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, itemsProvider, child) {
        if (itemsProvider.loading) {
          return progressIndicator();
        }

        if (itemsProvider.consumedItems.isEmpty) {
          return messageWidget('No items consumed yet.');
        }

        return _buildConsumedItems(itemsProvider);
      },
    );
  }

  Widget _buildConsumedItems(ItemsProvider itemsProvider) => ListView.builder(
        itemCount: itemsProvider.consumedItems.length,
        itemBuilder: (context, index) {
          final item = itemsProvider.consumedItems[index];
          return ItemCard(
            item: item,
            dismissibleTitle: "Revert to Available Items",
            onDismissed: (_) async =>
                await context.read<ItemsProvider>().undoConsumedItem(item.id!),
          );
        },
      );
}
