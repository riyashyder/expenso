class AccountModel {
  final String name;
  final double balance;
  final String icon;
  final String colorHex;

  AccountModel({
    required this.name,
    required this.balance,
    required this.icon,
    required this.colorHex,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'balance': balance,
    'icon': icon,
    'colorHex': colorHex,
  };

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    name: json['name'],
    balance: json['balance'],
    icon: json['icon'],
    colorHex: json['colorHex'],
  );
}
