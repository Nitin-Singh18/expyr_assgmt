import '../models/item_data.dart';
import 'database_service.dart';

class MockFirestoreService implements DatabaseService {
  // Simulated in-memory data store
  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'name': 'Milk',
      'expiry': '2024-12-20',
      'location': 'fridge',
      'quantity': 1,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
      'consumedAt': null,
    },
    {
      'id': '2',
      'name': 'Bread',
      'expiry': '2024-12-25',
      'location': 'pantry',
      'quantity': 2,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
      'consumedAt': null,
    },
  ];

  @override
  Future<List<ItemData>> getItems() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return _items.map((itemMap) => ItemData.fromJson(itemMap)).toList();
  }

  @override
  Future<void> updateItem(ItemData updatedItem) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final index = _items.indexWhere((item) => item['id'] == updatedItem.id);

    if (index != -1) {
      _items[index] = updatedItem.toJson();
    } else {
      throw Exception('Item with ID ${updatedItem.id} not found');
    }
  }
}
