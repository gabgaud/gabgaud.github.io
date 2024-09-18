# Lignes de commande 🤖

Sous Windows, plusieurs Shell (interface machine-personne) cohabitent côte-à-côte.

## L'invite de commande

L'invite de commande traditionnelle existe depuis la première version de Windows et s'inspire des commandes que l'on retrouvait sous MS-DOS. Évidemment, l'invite de commande à évoluer entre les différentes versions de Windows. Or, son évolution n'a pas toujours été de tout repos pour les utilisateurs. En effet, dans une version de Windows, on pouvait retrouver une commande, puis dans la version de Windows suivante, la commande avait disparu. Pire encore, dans la version de Windows qui suivait encore, la commande réapparaissait. Bref, cela pouvait être relativement dur à suivre. Pour lancer l'invite de commande, utilisez le raccourci clavier `win` + `r` et tapez l'expression `cmd` suivi de la touche « entrée ».

![InviteCMD](./Assets/04/cmd.png)

## Windows Subsystem for Linux (WSL)

Ce shell a fait sa première apparition avec la version 1607 de Windows 10. Il permet d'utiliser les commandes et certaines applications Linux sans avoir à passer par le biais d'un ordinateur virtuel. En mai 2020, WSL 2 fait son entrée et améliore grandemment ses performances et sa compatibilité avec plusieurs applications Linux. Cela dit, ce shell n'est pas orienté pour la gestion de Windows, mais plutôt pour utiliser des applications ou des logiciels Linux sous Windows.

![Wsl](./Assets/04/wsl.png)

## Powershell

Powershell a fait son apparition en 2006. L'objectif était de fournir un environnement de gestion plus puissant, flexible et moderne. Powershell est un langage de script orienté objet, permettant l'automatisation des tâches et la gestion de systèmes informatiques plus complexes. La dernière version de Powershell est la version 7 et c'est également le terminal par défaut sous Windows 11. Nous nous attarderons donc à ce shell pour interagir avec notre système Windows. Pour lancer Powershell sous Windows 11, vous n'avez qu'à cliquer sur le bouton de droite de votre souris et sélectionner « Ouvrir dans le terminal ».

![Powershell](./Assets/04/ps.png)

### Ligne active

La ligne active contient des informations pertinentes à connaître:

1. `PS` : Indique simplement que le « shell » en cours est Powershell.

2. `C:\Users\Utilisateur\Desktop>` : Il s'agit de l'endroit où vous vous trouvez dans l'arborescence du système.

### Cmdlet ( prononcé « command-lets » )

C'est ainsi que l'on nomme les commandes sous Powershell. Ces commandes sont toujours composés d'un verbe et d'un nom. Par exemple: 
- `set-location`
- `get-childitem`
- `copy-item`

etc.

### Set-Location

`Set-Location`