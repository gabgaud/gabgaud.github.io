import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Travail Pratique 02

* * *

## 🧪 Administration de Windows 11

### 🎯 Objectif
Ce travail pratique vise à évaluer vos compétences dans l’administration d’un système Windows 11. Vous devez effectuer une série de tâches sur une **machine virtuelle** que vous me remettrez une fois complétée. Chaque action doit être rigoureusement exécutée et **documentée dans un fichier `rapport.odt`** (créé avec LibreOffice) situé sur le **Bureau** de l’**administrateur**.

---

### ✅ Tâches à réaliser

#### 🔧 1. Installation et désinstallation de logiciels

Effectuez les actions suivantes **dans l’ordre indiqué**, et **documentez-les dans `rapport.odt`** :

1. **Installez LibreOffice** à l’aide de `winget` (outil de documentation principal).
2. Installez **7-Zip** à l’aide de `winget`.
3. Installez **Spotify** via le **Microsoft Store**.
4. Téléchargez et installez **Notepad++** depuis **le site officiel**.

*Pour chaque logiciel, indiquez la méthode utilisée et ajoutez une preuve de provenance (commande PowerShell, capture d’écran, etc.).*

---

#### 🔍 2. Architecture du système de fichiers Windows

Dans le fichier `rapport.odt`, répondez aux questions suivantes :

**a) `C:\Windows`**  
Quel est le rôle principal du dossier `C:\Windows`?

**b) `C:\Program Files` et `C:\Program Files (x86)`**  
Quelle est la différence entre ces deux dossiers?  
Pourquoi cette séparation est-elle importante?

**c) `C:\Users`**  
Pourquoi chaque utilisateur possède-t-il un dossier dans `C:\Users`?  
Nommez deux sous-dossiers importants qui s’y trouvent et expliquez leur utilité.

**d) `C:\ProgramData`**  
Ce dossier est caché par défaut. Pourquoi?  
Quel est son rôle dans le fonctionnement des applications installées?

---

#### ⚙️ 3. Services et processus

- **Désactivez** le service **spouleur d'impression**.
- Trouvez le **numéro de processus** du service **Windows Update** (`wuauserv`) et inscrivez-le dans le rapport.
- Recherchez la **description** du service `LanmanServer` et ajoutez-la dans le rapport.

---

#### 💻 4. Utilisation de PowerShell

Avec PowerShell, effectuez les actions suivantes :

- Créez un fichier `info.txt` dans `C:\AdminTP`.
- Ajoutez **un élément que vous avez appris durant ce cours**.
- Copiez ce fichier dans `C:\Users\Public`.
- Supprimez le fichier original.
- Créez un dossier `Archives` dans `C:\AdminTP` et déplacez-y `info.txt`.

---

#### 👤 5. Gestion des utilisateurs et groupes

- Créez un utilisateur local nommé `tp_utilisateur` avec le mot de passe `Tp@2025`.
- Créez un deuxième utilisateur local nommé `tp_utilisateur2` avec le mot de passe `Tp@2025`.
- Créez un groupe local nommé `Stagiaires`.
- Ajoutez **les deux utilisateurs** au groupe `Stagiaires`.

---

#### 🔐 6. Gestion des permissions (ACL)

- Dans `C:\AdminTP`, créez un dossier `DossiersTP`.
- À l’intérieur, créez trois sous-dossiers : `Confidentiel`, `Partagé`, `Public`.

Appliquez les permissions suivantes :

- **Désactivez l’héritage** dans les trois sous-dossiers.
- `Confidentiel` : Accès complet uniquement pour `tp_utilisateur`.
- `Partagé` : Accès complet pour le groupe `Stagiaires`.
- `Public` : Accès en lecture seule pour le groupe `Utilisateurs`.

Utilisez `Get-ACL` pour vérifier les permissions et copiez les résultats dans `rapport.odt`.

---

#### 📀 7. Gestion du stockage

- Ajoutez un **disque virtuel** de 2 Go à la machine.
- **Initialisez** le disque.
- **Créez une partition**, formatez-la en **NTFS** et assignez-lui la lettre `Z:`.
- Créez un fichier `stockage.txt` sur le disque `Z:`.

---

### 🗂️ Remise

Remettez les éléments suivants :

- La **machine virtuelle** avec toutes les modifications effectuées.
- Le fichier `rapport.odt` placé sur le **Bureau** de l’**administrateur**.
- Tous les fichiers créés (captures, fichiers de test, etc.) doivent rester en place dans le système.

📅 **La remise devra se faire via Microsoft Teams, dans le dépôt qui sera créé à cet effet.**

---

### 📜 Barème détaillé (sur 40 points)

| **Critère**                             | **Points** | **Détails évalués** |
|-----------------------------------------|------------|----------------------|
| **Installation/désinstallation de logiciels** | 6 pts | - Installation de LibreOffice avec `winget` (1 pt)<br/>- Installation de 7-Zip via `winget` (1 pt)<br/>- Installation de Spotify via le Microsoft Store (1 pt)<br/>- Installation de Notepad++ via internet (1 pt)<br/>- Preuves de provenance claires (2 pts) |
| **Architecture du système**             | 4 pts | - Réponses claires, précises et personnalisées aux questions (1 pt chacune) |
| **Services et processus**               | 4 pts | - Désactivation du spouleur d'impression (1 pt)<br/>- Numéro de processus `wuauserv` (1 pt)<br/>- Description du service `LanmanServer` (1 pt)<br/>- Bonne rédaction dans le rapport (1 pt) |
| **PowerShell (fichiers et dossiers)**   | 6 pts | - Création du fichier (1 pt)<br/>- Contenu pertinent (1 pt)<br/>- Copie/suppression (1 pt)<br/>- Création de dossier (1 pt)<br/>- Déplacement de fichier (1 pt)<br/>- Utilisation correcte de PowerShell (1 pt) |
| **Gestion des utilisateurs et groupes** | 6 pts | - Création des utilisateurs (2 pts)<br/>- Création du groupe `Stagiaires` (1 pt)<br/>- Ajout des utilisateurs au groupe (2 pts)<br/>- Cohérence générale (1 pt) |
| **Permissions (ACL)**                   | 6 pts | - Structure de dossiers correcte (1 pt)<br/>- Héritage désactivé (1 pt)<br/>- Permissions configurées (3 pts)<br/>- Sortie `Get-ACL` dans le rapport (1 pt) |
| **Gestion du stockage**                | 6 pts | - Ajout et initialisation du disque (1 pt)<br/>- Création et formatage de la partition (2 pts)<br/>- Attribution de lettre (1 pt)<br/>- Fichier `stockage.txt` présent (2 pts) |
| **Clarté et exactitude du rapport**     | 2 pts | - Organisation, grammaire, précision (1 pt)<br/>- Cohérence avec actions (1 pt) |

---

