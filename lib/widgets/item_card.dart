import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_data.dart';
import '../providers/items_provider.dart';

class ItemCard extends StatelessWidget {
  final ItemData item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Expires: ${item.expiry}'),
            Text('Location: ${item.location}'),
            if (item.quantity > 1)
              Text('Quantity: ${item.quantity}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {
            if (item.id != null) {
              Provider.of<ItemsProvider>(context, listen: false)
                  .consumeItem(item.id!);
            }
          },
        ),
      ),
    );
  }
} 