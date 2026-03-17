# Script de vérification pour l'exercice 05
# Gabriel Gaudreault

# Élévation de privilèges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Le script nécessite des droits d'administration. Relancement..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Fonction de nettoyage de texte
function Normalize-Text {
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$InputString
    )

    process {
    #On passe en minuscules
    $text = $InputString.ToLower()
    #On déconstruit les lettres et les accents
    $normalized = $text.Normalize([System.Text.NormalizationForm]::FormD)
    #Suppression des accents seuls
    $noAccent = [System.Text.RegularExpressions.Regex]::Replace($normalized, '\p{M}', '')
    #Suppression de tout ce qui ne correspond pas à une lettre ou un chiffre
    $cleanText = $noAccent -replace '[^a-z0-9]', ''

    return $cleanText
    }

}

#Fonction pour valider les dossiers
# Fonction pour valider les dossiers
function Test-DossierExercice{
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [hashtable]$PermissionsAttendues
    )

    $Resultat = [PSCustomObject]@{
        Dossier = $Path
        Existe = $false
        HeritageBloque = $false
        PermissionsConformes = $false
        Remarques = ""
    }

    # Vérification de l'existence du dossier
    if(-not (Test-Path -Path $Path)) {
        $Resultat.Remarques = "Le dossier n'existe pas ou n'a pas été trouvé."
        return $Resultat
    }
    $Resultat.Existe = $true

    # Récupération de l'ACL du dossier
    $acl = Get-Acl -Path $Path

    # Vérification de l'héritage des droits
    $Resultat.HeritageBloque = $acl.AreAccessRulesProtected

    if(-not $Resultat.HeritageBloque){
        $Resultat.Remarques += "Attention: l'héritage des droits semble toujours actif. "
    }

    # Vérification des permissions
    $ReglesActuelles = $acl.Access | Where-Object { $_.IsInherited -eq $false }
    $PermissionsValides = $true
    $ErreursPerms = @()

    foreach($User in $PermissionsAttendues.Keys){
        $DroitsAttendus = $PermissionsAttendues[$User]
        
        # 1. Normalisation du nom d'utilisateur/groupe attendu
        $UserNormalise = $User | Normalize-Text

        # 2. Trouver la règle correspondante en normalisant l'identité trouvée dans l'ACL
        $RegleTrouve = $ReglesActuelles | Where-Object { 
            $IdentiteSansDomaine = $_.IdentityReference.Value.Split('\')[-1]
            $IdentiteNormalisee = $IdentiteSansDomaine | Normalize-Text
            $IdentiteNormalisee -eq $UserNormalise
        }

        if(-not $RegleTrouve){
            $PermissionsValides = $false
            $ErreursPerms += "Permissions invalides ou manquantes pour $User."
        } else {
            $DroitsActuels = $RegleTrouve.FileSystemRights -join ", "
            if($DroitsActuels -notmatch $DroitsAttendus){
                $PermissionsValides = $false
                $ErreursPerms += "$User a [$DroitsActuels] au lieu de [$DroitsAttendus]."
            }
        }
    }

    # Vérifier les permissions en trop
    if($ReglesActuelles.Count -gt $PermissionsAttendues.Count){
        $PermissionsValides = $false
        $ErreursPerms += "Il y a des permissions superflues assignées."
    }

    $Resultat.PermissionsConformes = $PermissionsValides
    if($ErreursPerms.Count -gt 0) {
        $Resultat.Remarques += ($ErreursPerms -join " | ")
    } elseif ($Resultat.HeritageBloque){
        $Resultat.Remarques = "Parfait."
    }

    return $Resultat
}


Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "SCRIPT DE CORRECTION : EXERCICE 05" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# Vérification des utilisateurs
Write-Host "`nVérification des utilisateurs et des groupes...`n" -ForegroundColor Yellow

#Définition des utilisateurs et des groupes...
$users = @{
    "professeurs" = "vincent", "eric", "gabriel"
    "etudiants" = "paul", "brice", "jean"
    "communaute academique" = "vincent", "eric", "gabriel", "paul", "brice", "jean"
}

#Récupération des groupes, normalisation du texte
$localGroups = $(Get-LocalGroup).Name
$localGroupsNormalized = @()
foreach($localGroup in $localGroups){
    $localGroupsNormalized += $localGroup | Normalize-Text
}

#Vérification de l'existence des groupes concernés
foreach ($key in $users.Keys){
    $keyNormalized = $key | Normalize-Text
    if($localGroupsNormalized -contains $keyNormalized){
        Write-Host "============================================================" -ForegroundColor DarkGray
        Write-Host "[✓] Groupe $($key) repéré" -ForegroundColor Green -NoNewline
        Write-Host "→[vérification des membres ci-dessous]" -ForegroundColor DarkGray
        #Récupération des membres du groupe
        foreach($member in $($users[$key])){
            $memberNormalized = $member | Normalize-Text
            $checkLocalGroupMember = Get-LocalGroupMember -Member $memberNormalized -Group $key -ErrorAction SilentlyContinue
            if($checkLocalGroupMember){
                Write-Host ".....[✓] Utilisateur $memberNormalized repéré dans le groupe $key" -ForegroundColor Green
            } else {
                $checkLocalUser = Get-LocalUser -Name $memberNormalized -ErrorAction SilentlyContinue
                if($checkLocalUser){
                    Write-Host ".....[X] L'utilisateur $memberNormalized ne semble pas être membre du groupe $key" -ForegroundColor Red
                } else {
                    Write-Host ".....[X] L'utilisateur $memberNormalized ne semble pas avoir été créé..." -ForegroundColor Red
                }
            }
        }
    } else {
        Write-Host "[X] Groupe $key introuvable, vérification des membres impossible." -ForegroundColor Red
    }
}

Write-Host "`nVérification des dossiers et des permissions`n" -ForegroundColor Yellow

$StructureCorrection = @(
    @{
        Chemin = "C:\Établissement"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Communauté Académique" = "ReadAndExecute"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Professeurs"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Professeurs" = "ReadAndExecute"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Professeurs\Vincent Carrier"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Vincent" = "Modify"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Professeurs\Éric Gendron"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Éric" = "Modify"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Professeurs\Gabriel Gaudreault"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Gabriel" = "Modify"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Professeurs\Commun"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Professeurs" = "Write, ReadAndExecute, Synchronize"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Élèves"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Étudiants" = "ReadAndExecute"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Élèves\Paul Meilleur"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Paul" = "Modify"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Élèves\Brice DeNice"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Brice" = "Modify"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Élèves\Jean Peuplu"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Jean" = "Modify"
            "Système" = "FullControl"
        }
    },
    @{
        Chemin = "C:\Établissement\Élèves\Commun"
        Permissions = @{
            "Administrateurs" = "FullControl"
            "Étudiants" = "Write, ReadAndExecute, Synchronize"
            "Système" = "FullControl"
        }
    }
)

$ResultaFinaux = @()

foreach($Test in $StructureCorrection){
    $ResultaFinaux += Test-DossierExercice -Path $Test.Chemin -PermissionsAttendues $Test.Permissions
}

$ResultaFinaux | Select-Object `
    @{ Name = 'Dossier évalué'; Expression = { $_.Dossier } },
    @{ Name = 'Présent ?'; Expression = { if ($_.Existe) { 'Oui' } else { 'Non' } } },
    @{ Name = 'Héritage désactivé ?'; Expression = { if ($_.HeritageBloque) { 'Oui' } else { 'Non' } } },
    @{ Name = 'Permissions conformes'; Expression = { if ($_.PermissionsConformes) { 'Oui' } else { 'Non' } } },
    @{ Name = 'Remarques du correcteur'; Expression = { $_.Remarques } } |
Out-GridView -Title "Correction Exercice 05 - Permissions NTFS"

Pause