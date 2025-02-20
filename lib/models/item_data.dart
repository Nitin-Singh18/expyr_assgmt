import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_data.freezed.dart';

part 'item_data.g.dart';

@freezed
class ItemData with _$ItemData {
  const factory ItemData({
    String? id,
    required String name,
    required String expiry,
    required String location,
    @Default(1) int quantity,
    @Default(false) bool isPackaged,
    String? imagePath,
    @Default(false) bool isExpiryAssumed,
    @Default(false) bool isConsumed,
    DateTime? consumedAt,
  }) = _ItemData;

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);
}

extension ItemDataExtension on ItemData {
  /// Converts the expiry string to a `DateTime` object
  DateTime get expiryDate {
    final parts = expiry.split('-');
    final year = 2000 + int.parse(parts[2]);
    return DateTime(year, int.parse(parts[1]), int.parse(parts[0]));
  }

  /// Calculates the number of days until the item expires
  int get daysUntilExpiry {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final expiryEndOfDay =
        DateTime(expiryDate.year, expiryDate.month, expiryDate.day, 23, 59, 59);
    return expiryEndOfDay.difference(todayStart).inDays;
  }

  /// Checks if the item is expired
  bool get isExpired {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final expiryStart =
        DateTime(expiryDate.year, expiryDate.month, expiryDate.day);
    return expiryStart.isBefore(todayStart);
  }
}
