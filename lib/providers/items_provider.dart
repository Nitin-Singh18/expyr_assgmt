import 'package:flutter/material.dart';
import '../models/item_data.dart';
import '../services/database_service.dart';

/// A provider for managing the list of food items.
///
/// This class handles fetching items from the database, consuming and undoing
/// consumed items, and notifying UI updates.
class ItemsProvider with ChangeNotifier {
  /// The database service instance.
  final DatabaseService _databaseService;

  /// Creates an instance of [ItemsProvider].
  ///
  /// - [databaseService]: The service used to fetch and update items.
  ItemsProvider({required DatabaseService databaseService})
      : _databaseService = databaseService;

  /// List of available (non-consumed) food items.
  List<ItemData> _items = [];

  /// List of consumed food items.
  List<ItemData> _consumedItems = [];

  /// Stores the latest error message, if any.
  String? _error;

  /// Indicates whether the app is currently loading data.
  bool _loading = false;

  /// Getter for available items.
  List<ItemData> get items => _items;

  /// Getter for consumed items.
  List<ItemData> get consumedItems => _consumedItems;

  /// Getter for error messages.
  String? get error => _error;

  /// Getter for the loading state.
  bool get loading => _loading;

  /// Fetches all items from the database and updates the state.
  ///
  /// Splits the fetched items into [_items] and [_consumedItems] lists.
  Future<void> fetchItems() async {
    _setLoading(true);
    try {
      final items = await _databaseService.getItems();
      _items = items.where((item) => !item.isConsumed).toList();
      _consumedItems = items.where((item) => item.isConsumed).toList();
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// Marks an item as consumed.
  ///
  /// - [itemId]: The ID of the item to consume.
  Future<void> consumeItem(String itemId) async {
    _setLoading(true);
    try {
      final index = _items.indexWhere((item) => item.id == itemId);
      if (index == -1) {
        throw Exception('Item not found');
      }

      final updatedItem = _items[index].copyWith(
        isConsumed: true,
        consumedAt: DateTime.now(),
      );

      _updateItemLocally(itemId, updatedItem, isConsumed: true);
      await _databaseService.updateItem(updatedItem);
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// Reverts a consumed item back to available.
  ///
  /// - [itemId]: The ID of the consumed item.
  Future<void> undoConsumedItem(String itemId) async {
    _setLoading(true);
    try {
      final index = _consumedItems.indexWhere((item) => item.id == itemId);
      if (index == -1) throw Exception('Item not found in consumed list');

      final updatedItem = _consumedItems[index].copyWith(
        isConsumed: false,
        consumedAt: null,
      );

      _updateItemLocally(itemId, updatedItem, isConsumed: false);
      await _databaseService.updateItem(updatedItem);
    } catch (e) {
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// Updates the local state when an item is consumed or reverted.
  ///
  /// - [itemId]: The ID of the item to update.
  /// - [updatedItem]: The updated item data.
  /// - [isConsumed]: Whether the item is consumed or not.
  void _updateItemLocally(String itemId, ItemData updatedItem,
      {required bool isConsumed}) {
    if (isConsumed) {
      _items.removeWhere((item) => item.id == itemId);
      _consumedItems.add(updatedItem);
    } else {
      _consumedItems.removeWhere((item) => item.id == itemId);
      _items.add(updatedItem);
    }
    notifyListeners();
  }

  /// Handles errors and stores them in [_error].
  void _handleError(Object e) {
    _error = e.toString();
    debugPrint('Error: $e');
  }

  /// Updates the loading state and notifies listeners.
  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
