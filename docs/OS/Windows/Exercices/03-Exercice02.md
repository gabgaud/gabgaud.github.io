---
draft: false
---
import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Exercice 02

## Commandes PowerShell

L'objectif de cet exercice est de vous introduire au terminal PowerShell. Le mot introduire est important ici, on ne fera pas de vous des experts, du moins pas de tout de suite 😉. La raison pour laquelle nous faisons cette introduction c'est parce que nous utiliserons ce terminal à toutes sortes d'occasions durant le cours.

:::caution[Utilisation d'IA]
Encore une fois, je ne vous recommande pas l'utilisation de l'IA pour la réalisation de cet exercice. **Vous vous devez** de connaitre et de reconnaitre certaines commandes de base en PowerShell. Lorsque vous ferez des scripts d'automatisation nous reparlerons de l'IA. Pour l'instant, c'est à éviter.
:::

## Préalables

- Vous devez évidemment posséder une VM Windows 11 prête à être utilisée

## Étapes de réalisation

:::important
Pour réaliser l'exercice, vous devez utiliser les commandes PowerShell (cmdlet) et non pas les commandes de l'invite de commande classique. Par exemple, vous devez utiliser `Set-Location` plutôt que `cd`. 
:::

### Question 1

Débutez par ouvrir un terminal PowerShell en tant qu'Administrateur. À l'aide d'une commande, trouvez comment vous déplacer dans le dossier `C:\Windows` de votre système.

### Question 2

Dans le répertoire où vous vous trouvez présentement, trouvez la commande pour afficher le contenu du répertoire.

### Question 3

Dirigez-vous maintenant dans le répertoire parent d'où vous vous trouvez et créez un nouveau dossier à l'aide de la commande PowerShell appropriée. Nommez ce nouveau dossier « Exploitation ».

### Question 4

Dans le nouveau dossier que vous venez de créer, créez un fichier à l'aide la commande PowerShell appropriée. Ce nouveau fichier doit se nommer « Commandes.txt »

### Question 5

Trouvez la commande qui vous permettra de renommer le fichier « Commandes.txt » en « Powershell.txt ».

### Question 6

Trouvez la commande appropriée pour ajouter le texte **« Powershell, c'est fantastique! »** à l'intérieur de votre fichier « Powershell.txt ».

### Question 7

À l'aide de la commande Powershell apropriée, remplacez la ligne de texte écrite au numéro précédent par le texte **« Mon prof est incroyable! »**.

### Question 8

Toujours avec PowerShell, faites une copie du dossier `C:\Exploitation\` et de son contenu sur votre bureau (1 seule commande).

### Question 9

Renommez le dossier que vous venez tout juste de déplacer sur votre bureau par le nom « Exercice » à l'aide de la bonne commande Powershell.

### Question 10

Avec la bonne commande PowerShell, trouvez comment vous pouvez supprimer seulement le fichier `C:\Exploitation\Powershell.txt`. 

### Question 11

Trouvez la commande PowerShell pour afficher le message « Windows 11 possède une belle interface ! » à l'écran. Ce texte doit s'afficher en vert 🟢

### Question 12

Trouvez comment effacer tout ce qui est affiché dans le terminal PowerShell à l'aide la commande appropriée.

### Question 13

Dans l'objectif de pouvoir vous corriger, exécutez cette commande <mark>**avant**</mark> de fermer votre fenêtre PowerShell:

```Powershell
Get-History | ConvertTo-Json | Set-Content -Path $env:USERPROFILE\Desktop\Exercice02.json
```

## Correction

Voici un script de correction pour valider votre exercice. [Téléchargez-le](../Assets/Exercices/02/ScriptCorrection_Ex02.ps1) et utilisez-le de la même façon que vous avez procédé pour l'exercice #1.