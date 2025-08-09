class User {
  final String email;
  final String fullName;
  final String? companyName;
  final String? phoneNumber;

  User({
    required this.email,
    required this.fullName,
    this.companyName,
    this.phoneNumber,
  });
}