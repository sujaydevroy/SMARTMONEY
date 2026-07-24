class RegisterRequest {
  const RegisterRequest({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.referralCode,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? referralCode;

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName.trim(),
      'email': email.trim(),
      'phoneNumber': phoneNumber.trim(),
      'password': password,
      'referralCode': referralCode?.trim().isEmpty == true
          ? null
          : referralCode?.trim(),
    };
  }
}
