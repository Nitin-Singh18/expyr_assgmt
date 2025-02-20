import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../widgets/item_card.dart';
import 'consumed_items_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemsProvider>(context, listen: false).loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ConsumedItemsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ItemsProvider>(
        builder: (context, itemsProvider, child) {
          if (itemsProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemsProvider.error != null) {
            return Center(child: Text('Error: ${itemsProvider.error}'));
          }

          if (itemsProvider.items.isEmpty) {
            return const Center(child: Text('No items added yet.'));
          }

          return ListView.builder(
            itemCount: itemsProvider.items.length,
            itemBuilder: (context, index) {
              return ItemCard(item: itemsProvider.items[index]);
            },
          );
        },
      ),
    );
  }
} 