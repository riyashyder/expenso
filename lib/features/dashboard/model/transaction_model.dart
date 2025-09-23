class TransactionModel {
  final String id;
  final String name; // ✅ NEW
  final double amount;
  final String type;
  final String category;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.name, // ✅ NEW
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '', // ✅ NEW
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] ?? '',
      category: json['category'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name, // ✅ NEW
      'amount': amount,
      'type': type,
      'category': category,
      'date': date.toIso8601String(),
    };
  }
}
