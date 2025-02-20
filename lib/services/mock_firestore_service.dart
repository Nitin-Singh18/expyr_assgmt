class MockFirestoreService {
  // Simulate data storage
  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'name': 'Milk',
      'expiry': '20-12-24',
      'location': 'fridge',
      'quantity': 1,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '2',
      'name': 'Bread',
      'expiry': '25-12-24',
      'location': 'pantry',
      'quantity': 2,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
  ];

  Future<List<Map<String, dynamic>>> getItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _items;
  }

  Future<void> updateItem(String itemId, Map<String, dynamic> updates) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _items.indexWhere((item) => item['id'] == itemId);
    if (index != -1) {
      _items[index] = {..._items[index], ...updates};
    } else {
      throw Exception('MockFirestoreService: Item not found');
    }
  }

  Future<List<Map<String, dynamic>>> batchCreateItems(
      List<Map<String, dynamic>> items) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final List<Map<String, dynamic>> newItems = [];
    for (final item in items) {
      final newItem = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        ...item,
      };
      _items.add(newItem);
      newItems.add(newItem);
    }
    return newItems;
  }
} 