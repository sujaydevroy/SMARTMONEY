class RegisterResponse {
  const RegisterResponse({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.referralCode,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? referralCode;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      userId: json['userId'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      referralCode: json['referralCode'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
    );
  }
}
