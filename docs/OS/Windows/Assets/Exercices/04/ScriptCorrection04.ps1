# Script de correction pour l'exercice 04

$studentFile = "$env:USERPROFILE\Desktop\ex3.txt"

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " DÉBUT DE LA VALIDATION : EXERCICE 04" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

# ---------------------------------------------------------
# PARTIE 1 & 2 & 3 : Vérification du fichier ex3.txt
# ---------------------------------------------------------
if (Test-Path $studentFile) {
    Write-Host "[✓] Fichier ex3.txt trouvé sur le bureau." -ForegroundColor Green
    
    # Lecture des lignes (en ignorant les lignes vides)
    $lines = Get-Content $studentFile | Where-Object { $_.Trim() -ne '' }

    # Ligne 1 : Propriétaire et PID de l'explorateur (ex: DOMAIN\User;1234)
    if ($lines.Count -ge 1 -and $lines[0] -match "^.+;\d+$") {
        Write-Host "[✓] Ligne 1 (Propriétaire;PID) : Format valide ($($lines[0]))." -ForegroundColor Green
    } else {
        Write-Host "[X] Ligne 1 (Propriétaire;PID) : Format invalide ou manquante." -ForegroundColor Red
    }

    # Ligne 2 : RAM de Notepad (chiffre/décimal)
    if ($lines.Count -ge 2 -and $lines[1] -match "^\d+([.,]\d+)?$") {
        Write-Host "[✓] Ligne 2 (RAM Notepad) : Format valide ($($lines[1]) Mo)." -ForegroundColor Green
    } else {
        Write-Host "[X] Ligne 2 (RAM Notepad) : Format invalide ou manquante." -ForegroundColor Red
    }

    # Ligne 3 : PID du Spouleur (entier)
    if ($lines.Count -ge 3 -and $lines[2] -match "^\d+$") {
        Write-Host "[✓] Ligne 3 (PID Spouleur) : Format valide ($($lines[2]))." -ForegroundColor Green
    } else {
        Write-Host "[X] Ligne 3 (PID Spouleur) : Format invalide ou manquante." -ForegroundColor Red
    }

    # Ligne 4 : Résultat de la commande Get-Service (entier)
    if ($lines.Count -ge 4 -and $lines[3] -match "^\d+$") {
        Write-Host "[✓] Ligne 4 (Nb services Manual) : Format valide ($($lines[3]))." -ForegroundColor Green
    } else {
        Write-Host "[X] Ligne 4 (Nb services Manual) : Format invalide ou manquante." -ForegroundColor Red
    }

    # Ligne 5 : ID Événement d'ouverture de session (généralement 4624, 4648 ou 7001)
    if ($lines.Count -ge 5 -and $lines[4] -match "^(4624|4648|7001)$") {
        Write-Host "[✓] Ligne 5 (ID Ouverture session) : Réponse attendue trouvée ($($lines[4]))." -ForegroundColor Green
    } elseif ($lines.Count -ge 5 -and $lines[4] -match "^\d+$") {
        Write-Host "[!] Ligne 5 (ID Ouverture session) : Format valide mais ID inhabituel ($($lines[4])). À valider manuellement." -ForegroundColor Yellow
    } else {
        Write-Host "[X] Ligne 5 (ID Ouverture session) : Invalide ou manquante." -ForegroundColor Red
    }

    # Ligne 6 : ID Événement Dhcp-Client (généralement 7036)
    if ($lines.Count -ge 6 -and $lines[5] -match "^7036$") {
        Write-Host "[✓] Ligne 6 (ID DHCP-Client) : Réponse exacte (7036)." -ForegroundColor Green
    } elseif ($lines.Count -ge 6 -and $lines[5] -match "^\d+$") {
        Write-Host "[!] Ligne 6 (ID DHCP-Client) : Format valide mais ID incorrect ($($lines[5]) au lieu de 7036)." -ForegroundColor Yellow
    } else {
        Write-Host "[X] Ligne 6 (ID DHCP-Client) : Invalide ou manquante." -ForegroundColor Red
    }

} else {
    Write-Host "[X] Fichier ex3.txt introuvable sur le bureau." -ForegroundColor Red
}

# ---------------------------------------------------------
# PARTIE 2 : Vérification du service (Spouleur)
# ---------------------------------------------------------
Write-Host "`n--- Vérification du système ---" -ForegroundColor Cyan
$spooler = Get-Service -Name Spooler -ErrorAction SilentlyContinue
if ($spooler.StartType -eq 'Manual') {
    Write-Host "[✓] Service Spouleur d'impression : Type de démarrage configuré à 'Manual'." -ForegroundColor Green
} else {
    Write-Host "[X] Service Spouleur d'impression : Type de démarrage incorrect ($($spooler.StartType))." -ForegroundColor Red
}

# ---------------------------------------------------------
# PARTIE 3 : Vérification de la journalisation
# ---------------------------------------------------------
$eventLog = Get-EventLog -LogName MonJournal -Newest 1 -ErrorAction SilentlyContinue
if ($eventLog -and $eventLog.EventID -eq 1001 -and $eventLog.Source -eq "LogPerso.") {
    Write-Host "[✓] Journal 'MonJournal' : Événement 1001 trouvé avec la source 'LogPerso.'." -ForegroundColor Green
} else {
    Write-Host "[X] Journal 'MonJournal' : Journal ou événement test introuvable." -ForegroundColor Red
}

# Vérification de la vue personnalisée (Filtre XML stocké dans ProgramData)
$customViewsPath = "$env:ProgramData\Microsoft\Event Viewer\Views\*.xml"
if (Test-Path $customViewsPath) {
    Write-Host "[✓] Vues personnalisées : Au moins un filtre XML trouvé." -ForegroundColor Green
} else {
    Write-Host "[X] Vues personnalisées : Aucune vue personnalisée trouvée." -ForegroundColor Red
}

Write-Host "`n=====================================================" -ForegroundColor Cyan
Write-Host " FIN DE LA VALIDATION " -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan