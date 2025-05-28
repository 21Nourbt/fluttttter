class TableModel {
  final String id; // MongoDB ObjectId
  final int numTable;
  final String qrCode;
  final String? status;
  final String name;
  final int? capacity;
  final List<String>? description;
  final String? type;
  final List<PriceEntry> prices;

  TableModel({
    required this.id,
    required this.numTable,
    required this.qrCode,
    this.status,
    required this.name,
    this.capacity,
    this.description,
    this.type,
    required this.prices,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['_id'],
      numTable: json['numTable'],
      qrCode: json['QrCode'],
      status: json['status'],
      name: json['Name'],
      capacity: json['capacity'],
      description: (json['description'] != null) 
          ? List<String>.from(json['description']) 
          : null,
      type: json['type'],
      prices: (json['prices'] as List)
          .map((price) => PriceEntry.fromJson(price))
          .toList(),
    );
  }
}

class PriceEntry {
  final String duration;
  final double price;

  PriceEntry({
    required this.duration,
    required this.price,
  });

  factory PriceEntry.fromJson(Map<String, dynamic> json) {
    return PriceEntry(
      duration: json['duration'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
