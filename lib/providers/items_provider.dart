import 'package:flutter/material.dart';
import '../models/item_data.dart';
import '../services/mock_firestore_service.dart';

class ItemsProvider with ChangeNotifier {
  final MockFirestoreService _firestoreService = MockFirestoreService();
  List<ItemData> _items = [];
  List<ItemData> _consumedItems = [];
  String? _error;
  bool _loading = false;

  List<ItemData> get items => _items;
  List<ItemData> get consumedItems => _consumedItems;
  String? get error => _error;
  bool get loading => _loading;

  Future<void> loadItems() async {
    _setLoading(true);
    try {
      final items = await _firestoreService.getItems();
      _items = items.map((itemMap) => ItemData.fromMap(itemMap)).toList();
      _consumedItems = [];
      _error = null;
      debugPrint('Loaded items: $_items');
    } catch (e) {
      _error = e.toString();
      _items = [];
      debugPrint('Error loading items: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> consumeItem(String itemId) async {
    _setLoading(true);
    try {
      final index = _items.indexWhere((item) => item.id == itemId);
      if (index == -1) {
        throw Exception('Item not found');
      }

      final updatedItem = _items[index].copyWith(isConsumed: true);
      _consumedItems.add(updatedItem);
      _items.removeAt(index);

      await _firestoreService.updateItem(
          updatedItem.id!, {'isConsumed': true});

      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error consuming item: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<List<ItemData>> addItems(List<Map<String, dynamic>> items) async {
    _setLoading(true);
    _error = null;
    final List<ItemData> addedItems = [];

    try {
      final newItems = await _firestoreService.batchCreateItems(items);
      addedItems.addAll(newItems.map((itemMap) => ItemData.fromMap(itemMap)));

      _items.addAll(addedItems);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error adding items: $e');
    } finally {
      _setLoading(false);
    }

    return addedItems;
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
} 