import '../models/item_data.dart';

/// An abstract class that defines the contract for database operations.
abstract class DatabaseService {
  Future<List<ItemData>> getItems();

  Future<void> updateItem(ItemData updatedItem);
}
