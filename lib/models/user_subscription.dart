class UserSubscription {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String idUser;
  final String idSubscription;

  UserSubscription({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.idUser,
    required this.idSubscription,
  });

  // Create UserSubscription from JSON
  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      id: json['_id'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'] ?? 'active',
      idUser: json['id_user'] ?? '',
      idSubscription: json['id_subscription'] ?? '',
    );
  }

  // Convert UserSubscription to JSON
  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'id_user': idUser,
      'id_subscription': idSubscription,
    };
  }
}
