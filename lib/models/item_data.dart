class ItemData {
  final String? id;
  final String name;
  final String expiry;
  final String location;
  final int quantity;
  final bool isPackaged;
  final String? imagePath;
  final bool isExpiryAssumed;
  bool isConsumed;

  ItemData({
    this.id,
    required this.name,
    required this.expiry,
    required this.location,
    this.quantity = 1,
    this.isPackaged = false,
    this.imagePath,
    this.isExpiryAssumed = false,
    this.isConsumed = false,
  });

  ItemData copyWith({
    String? id,
    String? name,
    String? expiry,
    String? location,
    int? quantity,
    bool? isPackaged,
    String? imagePath,
    bool? isExpiryAssumed,
    bool? isConsumed,
  }) {
    return ItemData(
      id: id ?? this.id,
      name: name ?? this.name,
      expiry: expiry ?? this.expiry,
      location: location ?? this.location,
      quantity: quantity ?? this.quantity,
      isPackaged: isPackaged ?? this.isPackaged,
      imagePath: imagePath ?? this.imagePath,
      isExpiryAssumed: isExpiryAssumed ?? this.isExpiryAssumed,
      isConsumed: isConsumed ?? this.isConsumed,
    );
  }

  factory ItemData.fromMap(Map<String, dynamic> map) {
    return ItemData(
      id: map['id'] as String?,
      name: map['name'] as String,
      expiry: map['expiry'] as String,
      location: map['location'] as String,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      isPackaged: map['isPackaged'] as bool? ?? false,
      imagePath: map['imagePath'] as String?,
      isExpiryAssumed: map['isExpiryAssumed'] as bool? ?? false,
      isConsumed: map['isConsumed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'name': name,
    'expiry': expiry,
    'location': location,
    'quantity': quantity,
    'isPackaged': isPackaged,
    if (imagePath != null) 'imagePath': imagePath,
    'isExpiryAssumed': isExpiryAssumed,
    'isConsumed': isConsumed,
  };

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'name': name,
    'expiry': expiry,
    'location': location,
    'quantity': quantity,
    'isPackaged': isPackaged,
    if (imagePath != null) 'imagePath': imagePath,
    'isExpiryAssumed': isExpiryAssumed,
    'isConsumed': isConsumed,
    'createdAt': DateTime.now().toIso8601String(),
  };

  DateTime get expiryDate {
    final parts = expiry.split('-');
    final year = 2000 + int.parse(parts[2]);
    return DateTime(
      year,
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  int get daysUntilExpiry {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final expiryEndOfDay = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day,
      23,
      59,
      59,
    );
    return expiryEndOfDay.difference(todayStart).inDays;
  }

  bool get isExpired {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final expiryStart = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day,
    );
    return expiryStart.isBefore(todayStart);
  }
} 