import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/constants.dart';
import '../common/utils.dart';
import '../providers/items_provider.dart';
import '../widgets/item_card.dart';

class AvailableItemsScreen extends StatelessWidget {
  const AvailableItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, itemsProvider, child) {
        if (itemsProvider.loading) {
          return progressIndicator();
        }

        if (itemsProvider.error != null) {
          return messageWidget('Error: ${itemsProvider.error}');
        }

        if (itemsProvider.items.isEmpty) {
          return messageWidget('No items added yet.');
        }

        return _buildAvailableItems(itemsProvider);
      },
    );
  }

  Widget _buildAvailableItems(ItemsProvider itemsProvider) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: horizontalScreenSidePadding),
        child: ListView.builder(
          itemCount: itemsProvider.items.length,
          itemBuilder: (context, index) {
            final item = itemsProvider.items[index];
            return ItemCard(
              item: item,
              dismissibleTitle: "Add to Consumed Items.",
              onDismissed: (_) async =>
                  await context.read<ItemsProvider>().consumeItem(item.id!),
            );
          },
        ),
      );
}
