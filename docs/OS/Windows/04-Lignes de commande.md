# Lignes de commande 🤖

Sous Windows, plusieurs Shell (interface machine-personne) cohabitent côte à côte.

## L'invite de commande

L'invite de commande traditionnelle existe depuis la première version de Windows et s'inspire des commandes que l'on retrouvait sous MS-DOS. Évidemment, l'invite de commande à évoluer entre les différentes versions de Windows. Or, son évolution n'a pas toujours été de tout repos pour les utilisateurs. En effet, dans une version de Windows, on pouvait retrouver une commande, puis dans la version de Windows suivante, la commande avait disparu. Pire encore, dans la version de Windows qui suivait encore, la commande réapparaissait. Bref, cela pouvait être relativement dur à suivre. Pour lancer l'invite de commande, utilisez le raccourci clavier `win` + `r` et tapez l'expression `cmd` suivie de la touche « entrée ».

![InviteCMD](./Assets/04/cmd.png)

## Windows Subsystem for Linux (WSL)

Ce shell a fait sa première apparition avec la version 1607 de Windows 10. Il permet d'utiliser les commandes et certaines applications Linux sans avoir à passer par le biais d'un ordinateur virtuel. En mai 2020, WSL 2 fait son entrée et améliore grandement ses performances et sa compatibilité avec plusieurs applications Linux. Cela dit, ce shell n'est pas orienté pour la gestion de Windows, mais plutôt pour utiliser des applications ou des logiciels Linux sous Windows.

![Wsl](./Assets/04/wsl.png)

## Powershell

Powershell a fait son apparition en 2006. L'objectif était de fournir un environnement de gestion plus puissant, flexible et moderne. Powershell est un langage de script orienté objet, permettant l'automatisation des tâches et la gestion de systèmes informatiques plus complexes. La dernière version de Powershell est la version 7 et c'est également le terminal par défaut sous Windows 11. Nous nous attarderons donc à ce shell pour interagir avec notre système Windows. Pour lancer Powershell sous Windows 11, vous n'avez qu'à cliquer sur le bouton de droite de votre souris et sélectionner « Ouvrir dans le terminal ».

![Powershell](./Assets/04/ps.png)

### Ligne active

La ligne active contient des informations pertinentes à connaître:

1. `PS` : Indique simplement que le « shell » en cours est Powershell.

2. `C:\Users\Utilisateur\Desktop>` : Il s'agit de l'endroit où vous vous trouvez dans l'arborescence du système.

### Cmdlet ( prononcé « command-lets » )

C'est ainsi que l'on nomme les commandes sous Powershell. Ces commandes sont toujours composées d'un verbe et d'un nom. Par exemple: 
- `set-location`
- `get-childitem`
- `copy-item`

etc.

## Anatomie d'une commande

Sous Powershell, tout comme au sein d'autres Shell, la commande est toujours la première chose à inscrire. Certaines commandes utiliseront des paramètres pour préciser ou altérer légèrement le comportement de la commande, sans jamais en modifier la nature.

![Cmdlet](./Assets/04/cmdlet.png)

:::caution
Il n'est pas toujours nécessaire de préciser le nom du paramètre. Dans l'exemple ci-dessus, le nom du paramètre (Path) est précisé. Néanmoins, lorsque l'on consulte l'aide en ligne sur le site de Microsoft, on constate que la position du paramètre est 0. Autrement dit, c'est le premier paramètre qu'attend la commande. Automatiquement, les données qui seront entrées immédiatement après la commande seront donc considérées comme le paramètre `path`.

![ParamPositionnel](./Assets/04/PositionParam.png)

:::

## Commandes de base

Nous allons aborder certaines cmdlets ensemble afin que vous puissiez vous débrouiller avec Powershell. Évidemment, il ne s'agit que d'une petite introduction à toutes les possibilités offertes par ce dernier. Rien ne vous empêche d'aller plus loin par vous-mêmes, cependant, en ce qui nous concerne, nous nous en tiendrons à l'essentiel.

### Set-Location

Cette cmdlet permet de se déplacer dans l'arborescence Windows. C'est l'équivalent de la commande `cd` sous Linux ou même dans l'invite de commande Windows standard.

**Exemple 1: Se déplacer à la racine du système (C:\\)**

```powershell
Set-Location C:\
```

**Exemple 2: Se déplacer dans le dossier C:\Program files**

```powershell
Set-Location 'C:\Program files'
```

### Get-ChildItem

Cette commande permet d'afficher le contenu d'un répertoire. Autrement dit, elle est l'équivalente de la commande `ls` sous Linux ou `dir` sous Windows.

**Exemple 1: Afficher le contenu du dossier C:\Windows**

```powershell
Get-ChildItem C:\Windows
```

![GetChildItemWindows](./Assets/04/ChildItemWindows.png)

**Exemple 2: Afficher le contenu du répertoire actuel**

```powershell
Get-ChildItem .\
```

![GetChildItemCurrent](./Assets/04/ChildItemCurrent.png)

:::info[Rappel]
Les répertoires représentés par un point `.\` et par deux points `..\` ont des significations particulières. En effet, le répertoire `.\` représente le dossier actuel, c'est-à-dire celui dans lequel vous vous trouvez présentemment. Quant au dossier `..\`, il représente le répertoire parent. Autrement dit, en entrant la commande `set-location ..\`, vous atteindrez le répertoire parent relativement à votre emplacement.
:::

### New-Item

Cette cmdlet permet de créer un nouvel item. Le terme item est assez large et c'est volontaire de la part de Microsoft, car cette commande peut créer des fichiers, des répertoires, des raccourcis et bien d'autres éléments. Comme il ne s'agit pas d'un cours de Powershell à strictement parler, nous nous contenterons de voir comment créer des dossiers et des fichiers.

**Exemple 1: Créer un dossier sur mon bureau**

```Powershell
New-Item -Path C:\Users\gabriel.gaudreault\Desktop -Name MonDossier -ItemType Directory
```

![NewItemDossier](./Assets/04/NewItemDossier.png)

**Exemple 2: Créer un fichier sur mon bureau**

```powershell
New-Item -Path C:\Users\gabriel.gaudreault\Desktop -Name HelloWorld.txt -ItemType File
```

![NewItemFichier](./Assets/04/NewItemFichier.png)

### Write-Host

La commande `Write-Host` permet d'afficher du texte à l'écran, tout simplement.

**Exemple 1: Afficher un message standard à l'écran**

```powershell
Write-Host "Powershell c'est génial!"
```

![WriteHostStandard](./Assets/04/WriteHostStandard.png)

**Exemple 2: Afficher un message de couleur jaune avec fond noir à l'écran**

```powershell
Write-Host "Powershell c'est génial!" -BackgroundColor Black -ForegroundColor Yellow
```

![WriteHostCustom](./Assets/04/WriteHostBlackNYellow.png)

### Get-Content

Cette cmdlet permet d'afficher le contenu d'un fichier. Elle est comparable à la commande `cat` sous linux ou même `type` en invite de commandes Windows.

**Exemple 1: Afficher le contenu d'un fichier sur mon bureau**

```powershell
Get-Content -Path C:\Users\gabriel.gaudreault\Desktop\HelloWorld.txt
```
![GetContentBureau](./Assets/04/GetContentBureau.png)

**Exemple 2: Afficher une ligne spécifique d'un fichier**

```powershell
(Get-Content -Path C:\Users\gabriel.gaudreault\Desktop\HelloWorld.txt)[1]
```

![GetContentLigne](./Assets/04/GetContentLigne.png)