import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../widgets/item_card.dart';

class ConsumedItemsScreen extends StatelessWidget {
  const ConsumedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumed Items'),
      ),
      body: Consumer<ItemsProvider>(
        builder: (context, itemsProvider, child) {
          if (itemsProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemsProvider.consumedItems.isEmpty) {
            return const Center(child: Text('No items consumed yet.'));
          }

          return ListView.builder(
            itemCount: itemsProvider.consumedItems.length,
            itemBuilder: (context, index) {
              return ItemCard(item: itemsProvider.consumedItems[index]);
            },
          );
        },
      ),
    );
  }
} 