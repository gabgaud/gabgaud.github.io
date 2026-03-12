
#Script de validation strict pour l'Exercice 04.
# ---------------------------------------------------------
# Élévation des privilèges (Administrateur)
# ---------------------------------------------------------
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Le script nécessite des droits d'administration. Relancement automatique..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " VALIDATION : EXERCICE 04" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

# ---------------------------------------------------------
# Validation du fichier ex3.txt
# ---------------------------------------------------------
$studentFile = "$env:USERPROFILE\Desktop\ex3.txt"
$lines = @()

if (Test-Path $studentFile) {
    Write-Host "[✓] Le fichier ex3.txt est présent sur le bureau." -ForegroundColor Green
    $lines = Get-Content $studentFile | Where-Object { $_.Trim() -ne '' }
} else {
    Write-Host "Erreur : Le fichier ex3.txt est introuvable au bon emplacement ($studentFile)." -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 1 (Ligne 1 : Processus explorer)
# ---------------------------------------------------------
try {
    if ($lines.Count -lt 1) { throw "La ligne 1 est manquante dans le fichier." }
    $repL1 = $lines[0].Trim()
    $parts = $repL1 -split ';'
    
    if ($parts.Count -ne 2) {
        Write-Host "erreur pour la question 1 : Le format attendu 'propriétaire;pid' n'est pas respecté." -ForegroundColor Red
    } elseif ($parts[1] -notmatch "^\d+$") {
        Write-Host "erreur pour la question 1 : Le PID fourni ('$($parts[1])') n'est pas un nombre valide." -ForegroundColor Red
    } elseif ($parts[0] -notmatch "(?i)administrateur") {
        Write-Host "erreur pour la question 1 : Le propriétaire fourni ('$($parts[0])') ne contient pas 'administrateur'." -ForegroundColor Red
    } else {
        Write-Host "Question 1 : OK (PID valide et propriétaire administrateur détecté)."
    }
} catch {
    Write-Host "erreur pour la question 1 : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 4 (Ligne 2 : RAM de Notepad avec marge de 15%)
# ---------------------------------------------------------
try {
    if ($lines.Count -lt 2) { throw "La ligne 2 est manquante dans le fichier." }
    $repL2 = [double]($lines[1].Trim().Replace(',', '.'))
    $npRamObj = Get-CimInstance Win32_PerfRawData_PerfProc_Process -Filter "Name = 'Notepad'" -ErrorAction SilentlyContinue | Select-Object -First 1
    
    if ($npRamObj) {
        $sysRAM = [Math]::Round($npRamObj.WorkingSetPrivate / 1MB, 1)
        $marge15 = $sysRAM * 0.15
        $minRAM = $sysRAM - $marge15
        $maxRAM = $sysRAM + $marge15
        
        if ($repL2 -ge $minRAM -and $repL2 -le $maxRAM) {
            Write-Host "Question 4 : OK ($repL2 Mo est dans la marge de 15% par rapport à $sysRAM Mo)."
        } else {
            Write-Host "erreur pour la question 4 : La valeur inscrite ($repL2) est hors de la marge de 15% (Le système indique environ $sysRAM Mo)." -ForegroundColor Red
        }
    } else {
        Write-Host "erreur pour la question 4 : Notepad est fermé. Impossible de comparer la RAM actuelle." -ForegroundColor Red
    }
} catch {
    Write-Host "erreur pour la question 4 : Impossible de lire la RAM. Assurez-vous d'avoir inscrit un chiffre valide. Détail : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 6 (Spouleur d'impression en Manual)
# ---------------------------------------------------------
try {
    $spooler = Get-Service -Name Spooler -ErrorAction SilentlyContinue
    if (-not $spooler) {
        Write-Host "erreur pour la question 6 : Le service 'Spooler' est introuvable sur cette machine." -ForegroundColor Red
    } elseif ($spooler.StartType -eq 'Manual') {
        Write-Host "Question 6 : OK (Spouleur d'impression configuré en 'Manual')."
    } else {
        Write-Host "erreur pour la question 6 : Le type de démarrage actuel est '$($spooler.StartType)', et non 'Manual'." -ForegroundColor Red
    }
} catch {
    Write-Host "erreur pour la question 6 : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 7 (Ligne 3 : PID du Spouleur)
# ---------------------------------------------------------
try {
    if ($lines.Count -lt 3) { throw "La ligne 3 est manquante dans le fichier." }
    $spoolsv = Get-Process -Name spoolsv -ErrorAction SilentlyContinue | Select-Object -First 1
    $sysSpoolerPID = if ($spoolsv) { $spoolsv.Id } else { "Inactif" }
    $repL3 = $lines[2].Trim()
    
    if ($repL3 -eq [string]$sysSpoolerPID) {
        Write-Host "Question 7 : OK (PID du spouleur correspond)."
    } else {
        Write-Host "Question 7 : Discordance. Le PID a changé depuis la réponse." -ForegroundColor Yellow
        Write-Host "    -> Fichier ex3.txt  : $repL3" -ForegroundColor Yellow
        Write-Host "    -> Système actuel   : $sysSpoolerPID" -ForegroundColor Yellow
    }
} catch {
    Write-Host "erreur pour la question 7 : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 8 (Ligne 4 : Commande Get-Service Manual count)
# ---------------------------------------------------------
try {
    if ($lines.Count -lt 4) { throw "La ligne 4 est manquante dans le fichier." }
    $sysManualCount = (Get-Service | Where-Object {$_.StartType -eq 'Manual'}).Count
    $repL4 = [int]$lines[3].Trim()
    
    $minCount = $sysManualCount - 3
    $maxCount = $sysManualCount + 3
    
    if ($repL4 -ge $minCount -and $repL4 -le $maxCount) {
        Write-Host "Question 8 : OK ($repL4 est dans la marge de +/- 3 par rapport au compte de $sysManualCount)."
    } else {
        Write-Host "erreur pour la question 8 : Le compte inscrit ($repL4) est trop éloigné de la valeur système ($sysManualCount)." -ForegroundColor Red
    }
} catch {
    Write-Host "erreur pour la question 8 : La valeur fournie n'est pas un nombre entier lisible. Détail : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 9 (Ligne 5 : ID 4624)
# ---------------------------------------------------------
try {
    if ($lines.Count -lt 5) { throw "La ligne 5 est manquante dans le fichier." }
    $repL5 = $lines[4].Trim()
    if ($repL5 -eq "4624") {
        Write-Host "Question 9 : OK (ID 4624 trouvé)."
    } else {
        Write-Host "erreur pour la question 9 : L'ID inscrit ($repL5) n'est pas 4624." -ForegroundColor Red
    }
} catch {
    Write-Host "erreur pour la question 9 : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 10 (Journal LogPerso et événement 1001)
# ---------------------------------------------------------
try {
	
    $evt = Get-EventLog -LogName MonJournal -Source "LogPerso" -InstanceId 1001 -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $evt) {
        $evt = Get-EventLog -LogName LogPerso -InstanceId 1001 -ErrorAction SilentlyContinue | Select-Object -First 1
    }
    
    if ($evt) {
        Write-Host "Question 10 : OK (Événement 1001 trouvé dans le journal LogPerso/MonJournal)."
    } else {
        Write-Host "erreur pour la question 10 : Aucun événement 1001 n'a été trouvé dans le journal personnel." -ForegroundColor Red
    }
} catch {
    Write-Host "erreur pour la question 10 : Le journal n'existe probablement pas encore. Détail : $_" -ForegroundColor Red
}

# ---------------------------------------------------------
# Question 12 (Ligne 6 : ID 50036)
# ---------------------------------------------------------
try {
    if ($lines.Count -lt 6) { throw "La ligne 6 est manquante dans le fichier." }
    $repL6 = $lines[5].Trim()
    if ($repL6 -eq "50036") {
        Write-Host "Question 12 : OK (ID 50036 trouvé)."
    } else {
        Write-Host "erreur pour la question 12 : L'ID inscrit ($repL6) n'est pas 50036." -ForegroundColor Red
    }
} catch {
    Write-Host "erreur pour la question 12 : $_" -ForegroundColor Red
}

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " FIN DE LA VALIDATION" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

Pause