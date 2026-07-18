using Microsoft.EntityFrameworkCore;
using SmartMoney.Application.Abstractions.Persistence;
using SmartMoney.Domain.Entities;
using SmartMoney.Domain.Enums;
using SmartMoney.Infrastructure.Persistence.Context;

namespace SmartMoney.Infrastructure.Persistence.Repositories;

public sealed class RoleRepository : IRoleRepository
{
    private readonly SmartMoneyDbContext _context;

    public RoleRepository(SmartMoneyDbContext context)
    {
        _context = context;
    }

    public Task<Role?> GetByNameAsync(
        RoleType name,
        CancellationToken cancellationToken = default)
    {
        return _context.Roles.SingleOrDefaultAsync(
            role => role.Name == name,
            cancellationToken);
    }
}