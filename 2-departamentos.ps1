
Set-Location "F:\Ensayos 2"
$departamentos = Import-Csv ".\departamentos.csv"
foreach($ou in $departamentos){
    $path="OU="+($ou.seccion)+",OU=ASM2122,DC=AINARA,DC=ES"
    New-ADOrganizationalUnit -Name ($ou.departamento) -Path $path
    $path="OU="+($ou.departamento)+",OU="+$ou.seccion+",OU=ASM2122,DC=AINARA,DC=ES"

    New-ADGroup -Name $ou.departamento -GroupScope Global -Path $path
    $group = Get-ADGroup ("CN="+$ou.seccion+",OU="+$ou.seccion+",OU=ASM2122,DC=AINARA,DC=ES")
    $member="CN="+($ou.departamento)+","+$path
    Add-ADGroupMember $group -Members $member

}
