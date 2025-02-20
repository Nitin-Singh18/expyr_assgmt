import '../models/item_data.dart';

abstract class DatabaseService {
  Future<List<ItemData>> getItems();

  Future<void> updateItem(ItemData updatedItem);
}
