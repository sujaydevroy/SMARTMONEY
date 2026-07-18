using SmartMoney.Domain.Entities;

namespace SmartMoney.Application.Abstractions.Authentication;

public interface IJwtTokenGenerator
{
    JwtTokenResult GenerateToken(User user);
}