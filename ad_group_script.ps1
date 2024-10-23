param (
    [string]$GroupName,
    [string]$UserName,
    [string]$ManagerName,
    [string]$ActionType
)

if ($ActionType -eq "Add") {
    # Add the user to the group
    Add-ADGroupMember -Identity $GroupName -Members $UserName
    $subject = "User $UserName added to group $GroupName"
    $body = "User $UserName has been added to the group $GroupName."
} elseif ($ActionType -eq "Remove") {
    # Remove the user from the group
    Remove-ADGroupMember -Identity $GroupName -Members $UserName
    $subject = "User $UserName removed from group $GroupName"
    $body = "User $UserName has been removed from the group $GroupName."
}

# Send email to manager for approval
Send-MailMessage -To "$ManagerName@yourcompany.com" -From "no-reply@yourcompany.com" -Subject $subject -Body $body -SmtpServer "smtp.yourcompany.com"

# Optional: Notify user
Send-MailMessage -To "$UserName@yourcompany.com" -From "no-reply@yourcompany.com" -Subject "Action completed" -Body $body -SmtpServer "smtp.yourcompany.com"
