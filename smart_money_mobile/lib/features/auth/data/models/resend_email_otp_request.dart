class ResendEmailOtpRequest {
  const ResendEmailOtpRequest({required this.email});

  final String email;

  Map<String, dynamic> toJson() {
    return {'email': email.trim()};
  }
}
