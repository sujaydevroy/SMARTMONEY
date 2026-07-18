using SmartMoney.Domain.Common;
using SmartMoney.Domain.Enums;

namespace SmartMoney.Domain.Entities;

public class User : BaseEntity
{
    public string FullName { get; private set; } = string.Empty;

    public string Email { get; private set; } = string.Empty;

    public string MobileNumber { get; private set; } = string.Empty;

    public string PasswordHash { get; private set; } = string.Empty;

    public UserStatus Status { get; private set; } = UserStatus.Pending;

    public Guid RoleId { get; private set; }

    public Role? Role { get; private set; }

    public bool IsEmailVerified { get; private set; }

    public bool IsMobileVerified { get; private set; }

    public bool IsActive { get; private set; } = true;

    private User()
    {
    }

    public User(
        string fullName,
        string email,
        string mobileNumber,
        string passwordHash,
        Guid roleId)
    {
        if (string.IsNullOrWhiteSpace(fullName))
            throw new ArgumentException(
                "Full name is required.",
                nameof(fullName));

        if (string.IsNullOrWhiteSpace(email))
            throw new ArgumentException(
                "Email is required.",
                nameof(email));

        if (string.IsNullOrWhiteSpace(mobileNumber))
            throw new ArgumentException(
                "Mobile number is required.",
                nameof(mobileNumber));

        if (string.IsNullOrWhiteSpace(passwordHash))
            throw new ArgumentException(
                "Password hash is required.",
                nameof(passwordHash));

        if (roleId == Guid.Empty)
            throw new ArgumentException(
                "Role is required.",
                nameof(roleId));

        FullName = fullName.Trim();
        Email = email.Trim().ToLowerInvariant();
        MobileNumber = mobileNumber.Trim();
        PasswordHash = passwordHash;
        RoleId = roleId;
    }

    public void VerifyEmail()
    {
        IsEmailVerified = true;
        MarkAsUpdated();
    }

    public void VerifyMobile()
    {
        IsMobileVerified = true;
        MarkAsUpdated();
    }

    public void Deactivate()
    {
        IsActive = false;
        MarkAsUpdated();
    }

    public void ActivateAccount()
    {
        Status = UserStatus.Active;
        MarkAsUpdated();
    }

    public void SuspendAccount()
    {
        Status = UserStatus.Suspended;
        MarkAsUpdated();
    }

    public void BlockAccount()
    {
        Status = UserStatus.Blocked;
        MarkAsUpdated();
    }

    public void DeleteAccount()
    {
        Status = UserStatus.Deleted;
        MarkAsUpdated();
    }

    public void ChangeRole(Guid roleId)
    {
        RoleId = roleId;
        MarkAsUpdated();
    }
}