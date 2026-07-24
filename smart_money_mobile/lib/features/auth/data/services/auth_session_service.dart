import 'token_storage_service.dart';

class AuthSessionService {
  const AuthSessionService({
    TokenStorageService tokenStorageService = const TokenStorageService(),
  }) : _tokenStorageService = tokenStorageService;

  final TokenStorageService _tokenStorageService;

  Future<bool> hasValidSession() async {
    try {
      final accessToken = await _tokenStorageService.getAccessToken();
      final expiresAt = await _tokenStorageService.getAccessTokenExpiresAt();

      if (accessToken == null || accessToken.isEmpty || expiresAt == null) {
        return false;
      }

      return expiresAt.isAfter(DateTime.now().toUtc());
    } catch (_) {
      await _tokenStorageService.clearTokens();
      return false;
    }
  }
}
