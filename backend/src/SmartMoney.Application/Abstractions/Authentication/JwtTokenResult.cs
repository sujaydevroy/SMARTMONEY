namespace SmartMoney.Application.Abstractions.Authentication;

public sealed record JwtTokenResult(
    string AccessToken,
    DateTime ExpiresAt);