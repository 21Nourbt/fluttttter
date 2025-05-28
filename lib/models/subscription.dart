class Subscription {
  final String id;
  final String subscriptionType;
  final double price;
  final List<String> description;
  final String Name;

  Subscription({
    required this.id,
    required this.subscriptionType,
    required this.price,
    required this.description,
    required this.Name
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    // Access table_id.description
    final tableId = json['table_id'];
    final List<String> desc = tableId != null && tableId['description'] != null
        ? List<String>.from(tableId['description'])
        : [];
    final String Name = tableId != null ? tableId['Name'] : 'openspace';
    
  


    return Subscription(
      id: json['_id'] ?? '',
      subscriptionType: json['subscriptionType'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: desc,
      Name: Name
    );
  }
}
