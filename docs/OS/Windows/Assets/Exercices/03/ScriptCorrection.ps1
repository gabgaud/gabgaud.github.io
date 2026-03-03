#Cours: Systèmes d'exploitation
#Script de correction - Exercice 03
#Auteur: Gabriel Gaudreault
#Dernière édition: 02 mars 2026

#Prérequis

#Mode administrateur
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if(-not $isAdmin){
    Write-Host "Droits insuffisants. Relance du script en mode Administrateur..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy ByPass -File `"$PSCommandPath`""
    exit
}
Write-Host "-----------------------------------------------" -ForegroundColor Green
Write-Host "| Exécution en mode Administrateur confirmée! |" -ForegroundColor Green
Write-Host "-----------------------------------------------" -ForegroundColor Green
Write-Host "`n"
Write-Host "=== DÉBUT DE LA CORRECTION ===" -ForegroundColor Cyan

#Validation de l'installation depuis Windows Store (Logiciel non-Microsoft)

Write-Host "`n[1/3] Vérification de l'installation Windows Store..." -ForegroundColor Yellow

$WinStoreApps = Get-AppxPackage | Where-Object { $_.Publisher -notmatch "CN=Microsoft" -and $_.SignatureKind -eq "Store" }
if($WinStoreApps){
    Write-Host "[OK] Application(s) tierce(s) trouvée(s) : " -ForegroundColor Green
    $WinStoreApps | ForEach-Object { Write-Host " - $($_.Name) (Éditeur: $($_.Publisher))" }
} else {
    Write-Host "[ÉCHEC] Aucune application tierce provenant du Store n'a été détectée" -ForegroundColor Red
}

#Validation de WinGet (Notepad++)

Write-Host "`n[2/3] Vérification de WinGet (Notepad++)..." -ForegroundColor Yellow

$wingetCheck = winget list --id Notepad++.Notepad++ --exact --source winget 2>$null
if ($wingetCheck -match "Notepad\+\+\.Notepad\+\+"){
    Write-Host "[OK] Notepad++ est installé correctement via la source 'winget'." -ForegroundColor Green
} else {
    Write-Host "[ÉCHEC] Notepad++ est introuvable ou n'a pas été installé via la source demandée." -ForegroundColor Red
}

#Validation de 7-zip (MSI)

Write-Host "`n[3/3] Vérification de 7-Zip (Installation MSI)..." -ForegroundColor Yellow

$regPaths = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$installedSoftware = Get-ItemProperty $regPaths | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue

if ($installedSoftware -match "7-Zip") {
    Write-Host "[OK] 7-Zip est bien installé via le package MSI." -ForegroundColor Green
} else {
    Write-Host "[ÉCHEC] 7-Zip est introuvable." -ForegroundColor Red
}

Write-Host "`n=== FIN DE LA CORRECTION ===" -ForegroundColor Cyan

pause