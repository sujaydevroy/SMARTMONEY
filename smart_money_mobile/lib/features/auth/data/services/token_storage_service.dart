import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  const TokenStorageService({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _accessTokenExpiresAtKey = 'access_token_expires_at';

  final FlutterSecureStorage _storage;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime accessTokenExpiresAt,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(
        key: _accessTokenExpiresAtKey,
        value: accessTokenExpiresAt.toIso8601String(),
      ),
    ]);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<DateTime?> getAccessTokenExpiresAt() async {
    final value = await _storage.read(key: _accessTokenExpiresAtKey);

    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _accessTokenExpiresAtKey),
    ]);
  }
}
