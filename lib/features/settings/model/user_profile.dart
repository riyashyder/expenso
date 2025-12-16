class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String timeZone;
  final String preferredLanguage;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final int? avatar;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.timeZone,
    required this.preferredLanguage,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return UserProfile(
      id: data['_id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      timeZone: data['time_zone'],
      preferredLanguage: data['preferred_language'],
      currencyCode: data['currency']['code'],
      currencyName: data['currency']['name'],
      currencySymbol: data['currency']['symbol'],
      avatar: data['avatar'],
    );
  }
}
