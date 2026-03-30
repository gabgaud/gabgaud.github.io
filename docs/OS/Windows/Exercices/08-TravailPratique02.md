---
draft: true
---
import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Travail Pratique 02

* * *

<div class="red-text" style={{ textAlign: 'center', fontWeight: 'bold', fontSize: '2.5em' }}>
 DATE DE REMISE: 30 AVRIL 2026
</div>

* * *

## Administration de Windows 11

### Objectif 🎯
Ce travail pratique vise à évaluer vos compétences dans l'administration d'un système Windows 11. Vous devez effectuer une série de tâches sur une machine virtuelle que vous me remettrez un fois complétée. <span class="red-text">Vous devez <u>obligatoirement</u> installer une nouvelle machine virtuelle à partir de l'iso que je vous ai fourni dans le cours.</span>

:::info[Expression \[matricule\]]
Dans ce TP, l'expression \[matricule\] doit toujours être remplacée par votre numéro de matricule étudiant. Par exemple, si on vous demande de créer le dossier `C:\Windows\[matricule]\` et que votre matricule correspond au numéro 1234567, vous devez créer le dossier `C:\Windows\1234567`.
:::

---

### Tâches à réaliser  ✅

:::tip
Avant de commencer votr TP, je vous recommande de faire ce que l'on appelle un *snapshot*. Les *snapshots*, ou les instantannés en francais, permettent de prendre une photo de votre machine virtuelle à un instant *t*. Ainsi, si vous faites une erreur, vous pourrez revenir à l'état où était votre machine virtuelle lorsque vous avez effectué ce *snapshot* sans devoir réinstaller Windows au complet. C'est très pratique, particulièrement en examen 😉.

Pour prendre un instantanné, cliquez sur le menu `VM` dans *Workstation*, sélectionnez *snapshot*, puis cliquez sur `Prendre un snapshot`. Donnez un nom à votre *snapshot*, ex: Machine neuve. Voilà.
:::

#### Préparation

Une fois votre machine virtuelle sous Windows 11 installée et fonctionnelle:

1. Créez un dossier, à la racine du disque dur `C:\` et nommez le `TP02_[matricule]`.
2. À l'intérieur de ce dernier dossier, créez un fichier texte nommé `réponses.txt`. Copiez-collez le modèle ci-dessous 👇 à l'intérieur et utilisez-le pour rédiger vos réponses théoriques tout au long du TP :

    ```text
    NOM: [Votre Nom]
    MATRICULE: [matricule]

    --- Section 3: Architecture ---

    Question 3a:
    [Réponse ici]

    Question 3b:
    Rôle de ce dossier:
    [Réponse ici]

    --- Section 4: Services ---
    PID actuel de wuauserv : [chiffre ici]

    Description de Lanmanserver :
    [Copier la description ici]
    ```

---

#### 1. Manipulations PowerShell

1. Ouvrez PowerShell en tant qu'administrateur.
2. Démarrez l'enregistrement de votre session (c'est ce qui me permettra de corriger) avec la commande :<br/> `Start-Transcript -Path C:\TP02_[matricule]\console.txt`
:::danger
Ne fermez pas la fenêtre PowerShell tant et aussi longtemps que vous n'avez pas exécuté l'ensemble des opérations de ce numéro. Si vous fermez la fenêtre PowerShell, la transcription se terminera et je ne pourrai pas valider les commandes que vous avez entrées et utilisées.
:::
3. Installez **LibreOffice** à l'aide de l'outil `winget`.
4. Installez **7-zip** à l'aide de l'outil `winget`.
5. Exécutez ensuite les commandes nécessaires pour exécuter les actions suivantes:
    - Créez un fichier `info.txt` dans `C:\TP02_[matricule]\`.
    - Ajoutez-y le texte : *Ceci a été fait via PowerShell*.
    - Copiez ce fichier dans `C:\Users\Public\`.
    - Supprimez le fichier original de `C:\TP02_[matricule]\`
6. Arrêtez l'enregistrement avec la commande `Stop-Transcript`

---

#### 2. Installations graphiques

1. Installez **Spotify** via le **Microsoft Store**.
2. Téléchargez et installez **Notepad++** depuis le site officiel de l'éditeur.

---

#### 3. Architecture du système

Répondez de façon concise aux questions suivantes dans votre fichier `C:\TP02_[matricule]\réponses.txt`

    a) Expliquez pourquoi Windows 11 possède deux dossiers *program files* distincts. Soit `C:\Program Files` et `C:\Program Files (x86)`

    b) Affichez les éléments masqués de Windows. Explorez `C:\ProgramData`. Quel semble être le rôle de ce dossier ?

---

#### 4. Services et processus

- **Désactivez** le service **Spouleur d'impression** (Il doit rester désactivé aux prochains démarrages.)
- Dans le fichier `C:\TP02_[matricule]\réponses.txt`, inscrivez le **PID** actuel du service **Windows Update** tel qu'il apparait sur votre machine.
- Dans le fichier `C:\TP02_[matricule]\réponses.txt`, copiez-collez la **description** exacte du service `Lanmanserver` telle qu'affichée dans la console des services.

---

#### 5. Gestion des utilisateurs et groupes

Créez les éléments suivants:
- Un utilisateur local nommé `user1_[matricule]` avec le mot de passe `Tp@2026`.
- Un deuxième utilisateur local nommé `user2_[matricule]` avec le mot de passe `Tp@2026`.
- Créez un groupe local nommé `groupe_[matricule]`.
- Ajoutez **les deux utilisateurs** au groupe `groupe_[matricule]`.

---

#### 6. Gestion des permissions (ACL)

:::caution[Groupe administrateurs et utilisateur system]
Le groupe `administrateurs` et l'utilisateur `system` doivent <u>toujours</u> posséder toutes les permissions sur les dossier ci-dessous.
:::

Dans `C:\TP02_[matricule]\`, créez trois sous-dossiers: `Confidentiel`, `Partage` et `Public`. Configurez ensuite les permissions comme suit:
- **Désactivez l'héritage des droits** pour les trois dossiers.
- Dossier `Confidentiel` : Accès complet (contrôle total) uniquement pour `user1_[matricule]`.
- Dossier `Partage` : Accès complet (contrôle total) pour `groupe_[matricule]`.
- Dossier `Public` : Accès en lecture seule pour le groupe prédéfini `Utilisateurs`.

---

#### 7. Gestion du stockage

- Dans les paramètres de votre hyperviseur, ajoutez un **disque dur virtuel** de 2Go à la VM.
- Dans Windows, **initialisez** le disque,
- **Créez une partition**, formatez-la en **NTFS** et assignez-lui la lettre `Z:\`.
- Créez un fichier vide nommé `stockage_[matricule].txt` à la racine de ce nouveau lecteur `Z:\`.

---

### Remise

1. Éteignez proprement votre machine virtuelle.
2. Exportez la machine virtuelle en format `.ova`
3. Nommez votre fichier `.ova` comme suit : `Nom_Prenom_TP02.ova`
4. Remettez **uniquement votre machine virtuelle** via le dépôt ci-dessous 👇

---

<div style={{ textAlign: 'center', fontWeight: 'bold', fontSize: '2em' }}>
 [LIEN POUR EFFECTUER LA REMISE](https://cloud.tonprof.ca/index.php/s/gCrxg7FEAg9dZRF)
</div>

---

### Barème détaillé (sur 40 points)

| **Critère** | **Points** | **Détails évalués** |
| :--- | :--- | :--- |
| **Installations et PowerShell** | 10 pts | - Présence du fichier `Console.txt` valide (2 pts)<br/>- Traces de `winget` pour LibreOffice et 7-Zip (4 pts)<br/>- Commandes de manipulation de fichiers réussies (2 pts)<br/>- Présence de Spotify et Notepad++ (2 pts) |
| **Architecture du système** | 4 pts | - Explication claire `Program Files` vs `(x86)` (2 pts)<br/>- Identification et rôle du dossier `ProgramData` (2 pts) |
| **Services et processus** | 4 pts | - Désactivation du spouleur d'impression confirmée (2 pts)<br/>- PID de `wuauserv` et description `LanmanServer` (2 pts) |
| **Gestion des utilisateurs/groupes** | 6 pts | - Création des deux utilisateurs avec `[matricule]` (2 pts)<br/>- Création du groupe avec `[matricule]` (2 pts)<br/>- Appartenance au groupe confirmée (2 pts) |
| **Permissions (ACL)** | 6 pts | - Héritage désactivé (2 pts)<br/>- Permissions correctes appliquées aux 3 dossiers (4 pts) |
| **Gestion du stockage** | 6 pts | - Présence du disque 2 Go initialisé (2 pts)<br/>- Partition NTFS avec lettre Z: (2 pts)<br/>- Présence du fichier `stockage_[matricule].txt` (2 pts) |
| **Respect des consignes globales** | 4 pts | - Utilisation stricte de la nomenclature `[matricule]` (2 pts)<br/>- Format respecté pour `Réponses.txt` (2 pts) |

---

