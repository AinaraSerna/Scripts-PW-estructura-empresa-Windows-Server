
Set-Location "F:\Ensayos 2"
New-ADOrganizationalUnit -Name "ASM2122" -Path "DC=AINARA2021,DC=ES" `
-ProtectedFromAccidentalDeletion $false -Description "OU de ASM2122"

New-ADGroup -Name "ASM2122" -GroupScope Global -Path "OU=ASM2122,DC=AINARA2021,DC=ES"
$group = Get-ADGroup "CN=ASM2122,OU=ASM2122,DC=AINARA2021,DC=ES"

$secciones= Import-Csv ".\secciones.csv"
foreach($ou in $secciones){
    New-ADOrganizationalUnit -name ($ou.seccion) -Description ($ou.descripcion) `
    -path "OU=ASM2122,DC=AINARA2021,DC=ES"
    $path="OU="+($ou.seccion)+",OU=ASM2122,DC=AINARA2021,DC=ES"

    New-ADGroup -Name ($ou.seccion) -GroupScope Global -Path $path
    $member="CN="+($ou.seccion)+","+$path
    Add-ADGroupMember $group -Members $member
}