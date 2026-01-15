
Set-Location "F:\Ensayos 2"
$personal = Import-Csv ".\personal.csv"
foreach($user in $personal){
    $login=$user.login
    $path = "OU="+($user.departamento)+",OU="+($user.seccion)+",OU=ASM2122,DC=AINARA,DC=ES"
    New-ADUser -Name $login -Path $path -SamAccountName $login -UserPrincipalName ($login+"@AINARA.ES") `
    -AccountPassword (ConvertTo-SecureString "AINARA.es" -AsPlainText -Force) `
    -GivenName $login -ChangePasswordAtLogon $false -Enabled $true

    $group = Get-ADGroup ("CN="+$user.departamento+",OU="+$user.departamento+",OU="+$user.seccion+",OU=ASM2122,DC=AINARA,DC=ES")
    $member = "CN="+$login+","+$path
    Add-ADGroupMember $group -Members $member

}
