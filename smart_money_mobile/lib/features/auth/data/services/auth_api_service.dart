import 'dart:convert';
import '../models/register_response.dart';
import 'package:http/http.dart' as http;
import '../models/register_request.dart';
import '../models/verify_email_otp_request.dart';
import '../models/resend_email_otp_request.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthApiService {
  AuthApiService({http.Client? client, this.baseUrl = 'http://localhost:5256'})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/api/identity/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Registration failed with status ${response.statusCode}: '
        '${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Invalid registration response.');
    }

    return RegisterResponse.fromJson(decodedBody);
  }

  void dispose() {
    _client.close();
  }

  Future<void> verifyEmailOtp(VerifyEmailOtpRequest request) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/api/identity/verify-email-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'OTP verification failed with status ${response.statusCode}: '
        '${response.body}',
      );
    }
  }

  Future<void> resendEmailOtp(ResendEmailOtpRequest request) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/api/identity/resend-email-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Resend OTP failed with status ${response.statusCode}: '
        '${response.body}',
      );
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/api/identity/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Login failed with status ${response.statusCode}: '
        '${response.body}',
      );
    }

    final decodedBody = jsonDecode(response.body);

    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Invalid login response.');
    }

    return LoginResponse.fromJson(decodedBody);
  }
}
