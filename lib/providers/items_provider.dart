import 'package:flutter/material.dart';
import '../models/item_data.dart';
import '../services/database_service.dart';

class ItemsProvider with ChangeNotifier {
  final DatabaseService _databaseService;

  ItemsProvider({required DatabaseService databaseService})
      : _databaseService = databaseService;

  /// App State
  List<ItemData> _items = [];
  List<ItemData> _consumedItems = [];
  String? _error;
  bool _loading = false;

  // State Getters
  List<ItemData> get items => _items;

  List<ItemData> get consumedItems => _consumedItems;

  String? get error => _error;

  bool get loading => _loading;

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

  Future<void> consumeItem(String itemId) async {
    _setLoading(true);
    try {
      final index = _items.indexWhere(
        (item) => item.id == itemId,
      );
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

  void _handleError(Object e) {
    _error = e.toString();
    debugPrint('Error consuming item: $e');
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
