---
draft: false
---
# Applications et logiciels 📦

## Qu'est-ce qu'un logiciel ?
Un logiciel ou une application, c'est d'abord un fichier ou un ensemble de fichier qu'un programmeur ou qu'une équipe de programmeurs auront conçu. Ces programmeurs utiliseront ce que l'on nomme un langage de programmation pour écrire et composer un ensemble d'instructions que l'ordinateur pourra traiter. Voici un exemple de fichier écrit par un programmeur:

![Programmation](./Assets/05/Source_code.png)

Dans certains cas, dépendamment des langages de programmation et de leur contexte respectif, une deuxième étape sera nécessaire avant que le programme puisse fonctionner. Il s'agit de l'étape de la compilation. Lorsqu'il y a compilation, le code utilisé par le programmeur sera alors transformé en instructions pour le processeur de l'ordinateur. Un code compilé est très peu lisible et compréhensible.

![Compilation](./Assets/05/compilation.jpg)

Une fois les instructions comprises et exécutées par le processeur, le logiciel s'exécutera. Lors de l'exécution, le système créera automatiquement un processus dans sa mémoire et chargera le logiciel à l'intérieur de celui-ci. Nous aborderons les processus très bientôt. Dans l'image ci-dessous, nous pouvons voir le logiciel FileZilla en exécution.

![ExempleLogiciel](./Assets/05/ExempleLogiciel.png)

### Différence entre un programme et une application

Le terme « programme » et le terme « application » semblent souvent interchangeables dans l'environnement Windows. C'est même relativement difficile de discerner des différences entre les deux appellations dans le système d'exploitation. Néanmoins, des nuances sont à apporter lorsque nous voulons distinguer un terme de l'autre.

- **Programme ou logiciel:** Un programme fait généralement référence à un ensemble d'instructions écrites dans un langage de programmation qui s'exécute sur un ordinateur. C'est un terme plus large qui englobe tout type de logiciel, qu'il s'agisse d'applications de bureau, de services système ou même de scripts. Par exemple, un programme peut inclure des systèmes d'exploitation, des utilitaires ou des logiciels de gestion.

- **Application:** Une application, en revanche, est souvent considérée comme un type spécifique de programme conçu pour accomplir une tâche particulière pour l'utilisateur. Cela inclut des logiciels comme Microsoft Word, Excel, ou des applications web comme Microsoft Teams. Les applications sont généralement plus centrées sur l'utilisateur et offrent des interfaces interactives pour répondre à des besoins spécifiques.

:::caution
Même si j'essaie tant bien que mal de distinguer les concepts de logiciel et d'application, les deux termes sont utilisés un peu à toutes les sauces dans Windows. Ajoutez à cela les traductions plutôt moyennes entre l'anglais et le français sous Windows et nous avons la recette parfaite pour ne plus distinguer les termes.
:::

## Installer un logiciel

Sous Windows 11, il y a plusieurs façons de procéder à l'installation d'un logiciel. Nous allons les examiner et les comparer ensemble. Cela dit, certains logiciels nécessiteront l'utilisation d'une méthode particulière. Tout dépend de l'éditeur du logiciel en question.

### Windows Store

L'utilisation du *Windows Store* est sans doute la méthode la plus facile pour installer une application ou un logiciel. Il suffit d'ouvrir l'application *Windows Store*, de lancer une recherche avec le nom de votre logiciel et de l'installer. 

Pour lancer *Windows Store*, utilisez votre barre de recherche juste à côté du menu démarrer et tapez *Windows Sotre*:

![LancerWindowsStore](./Assets/05/LancerWindowsStore.png)

Une fois dans *Windows Store*, utilisez la recherche pour repérer l'application ou le logiciel que vous désirez installer. Dans l'exemple ci-dessous, je recherche le logiciel *vlc*, un célèbre lecteur multimédia. Une fois votre logiciel repéré, vous pouvez cliquer sur celui-ci afin d'afficher les détails de celui-ci et d'obtenir la possibilité de l'installer.

![WindowsStoreVLC](./Assets/05/WindowsStoreVLC.png)

### WinGET

*WinGET* est le nouveau gestionnaire de paquets de Windows. Il permet de télécharger et d'installer des logiciels directement depuis le terminal PowerShell. Cette façon de procéder peut sembler plus complexe aux premiers abords, mais elle possède l'avantage d'être très pratique. Pas d'interface graphique à manœuvrer, pas de fenêtre ou de site web à consulter. On entre la bonne commande et le logiciel s'installe. Pour lancer le terminal *PowerShell*, faites un clic à l'aide du bouton de droite de votre souris sur le bureau, puis sélectionnez « Ouvrir dans le terminal ».

#### Chercher un logiciel avec *Winget*

Avant de tenter une installation de logiciel, il est bien de vérifier que ce dernier est bel et bien disponible via l'installation *Winget*. Pour ce faire, on utilisera le paramètre `search` comme dans l'exemple ci-dessous:

**Commande:**
```powershell
winget search vlc
```
**Résultat:**

![Recherche Winget](./Assets/05/WingetSearch.png)

#### Installer un logiciel avec *Winget*

Une fois que vous avez repéré le logiciel que vous voulez installer, il faut tout simplement utiliser le paramètre `install` suivi du nom du logiciel à installer. 

:::info
J'attire votre attention vers la colonne « Source », qui permet d'identifier d'où vous téléchargerez le logiciel. Vous remarquerez le terme « msstore » qui réfère au magasin Windows. Autrement dit, télécharger le logiciel depuis *WinGET* ou depuis le magasin revient exactement au même dans ces cas précisément. 
:::

**Commande:**
```powershell
winget install 'VLC Media Player'
```

**Résultat:**

![WingetInstall](./Assets/05/WingetInstall.png)

### Manuellement

Pour procéder à l'installation d'un logiciel manuellement, il faut d'abord télécharger un installateur. Généralement, ces installateurs possèdent une extension *.msi* ou *.exe* et sont téléchargeables depuis le site internet du développeur. Par exemple, voici le site officiel du lecteur multimédia VLC:

![LecteurVLC](./Assets/05/VLC.png)

:::danger
Assurez-vous de télécharger vos fichiers d'installation depuis un site de confiance. Le lancement d'un fichier exécutable téléchargé depuis un site suspect représente un réel risque pour votre ordinateur et les données qu'il contient.
:::

Une fois le logiciel téléchargé, celui-ci devrait se retrouver dans votre dossier de téléchargements:

(C:\\Users\\*Nom d'utilisateur*\\downloads\\*fichier.exe*)

Lancez le fichier, en double-cliquant sur celui-ci, et suivez les étapes de l'installation.

## Où se retrouvent les fichiers de programme ?

Tel que nous avons discuté dans [cette section](./03-Architecture.md#certains-dossiers-dignes-de-mention), les fichiers de programme se retrouvent principalement dans les dossiers `C:\Program Files\` et `C:\Program Files (x86)` dans un dossier au nom de l'application ou du logiciel. Cependant, les applications téléchargées depuis le *Microsoft Store* se retrouveront plutôt dans le dossier `C:\Program Files\WindowsApps\` qui est un dossier caché et protégé.

Lorsque vous cliquez sur une icône de votre bureau ou même sur le nom d'une application dans le menu démarrer, vous vous trouvez à cliquer sur un raccourci qui lance l'exécutable du logiciel se trouvant dans le dossier *Program Files*.

## Applications par défaut

Windows 11 vous offre la possibilité de créer une association entre certaines extensions de fichier et une application particulière. Par exemple, si vous désirez ouvrir vos fichiers *.mp3* (musique) toujours avec le même lecteur multimédia, il est possible de le faire. Dans les paramètres Windows (clic-droit sur le menu démarrer, puis paramètres), sélectionnez la section « Applications », puis cliquez sur « Applications par défaut »:

![AppliParDéfaut](./Assets/05/DefaultApp.png)

À cet endroit, vous aurez l'occasion d'entrer un type de fichier (extension) ainsi que le logiciel auquel vous désirez associer cette extension:

![MP3VLC](./Assets/05/Mp3VLC.png)

En aucun cas cela ne vous oblige à ouvrir les fichiers *mp3* avec VLC en permanence. Il ne s'agit que du comportement par défaut. Cela dit, à tout moment, vous pouvez effectuer un clic à l'aide du bouton de droite de la souris sur un fichier et sélectionner « Ouvrir avec... ». Cela vous permettra de sélectionner le logiciel de votre choix.

## Fonctionnalités facultatives

Microsoft rend certaines fonctionnalités de Windows disponibles mais désactivées par défaut. C'est le cas du serveur SSH à titre d'exemple. 

:::info
Un serveur SSH est un service permettant à des utilisateurs de se brancher sur le terminal du poste à distance.
:::

À tout moment vous pouvez activer l'une de ces fonctionnalités ou consulter la liste de celles-ci en vous dirigeant dans les paramètres, puis dans la section « Système » et « Fonctionnalités facultatives »:

![Fonctionnalités Facultatives](./Assets/05/fonctionnalitesfacultatives.png)

Cliquez simplement sur « Afficher les fonctionnalités » pour consulter la liste des fonctionnalités disponibles à l'installation. Vous pourrez également procéder à l'installation de l'une d'entre elles au besoin.

## Désinstaller un logiciel

Comme pour l'installation d'un logiciel, la désinstallation d'un logiciel et/ou d'une application peut se faire de plus d'une façon. Ce sera à vous de déterminer laquelle d'entre elles vous convient le mieux.

### Paramètres

Depuis les paramètres Windows (raccourci clavier: <kbd>&#8862; win</kbd>+<kbd>i</kbd>), cliquez sur « Applications installées ». Dans la liste affichée, trouvez l'application ou le logiciel que vous désirez désinstaller, puis cliquez sur `...` . Enfin, sélectionnez « Désinstaller »

![Désinstallation Param](./Assets/05/ParamDesinstaller.png)

### WinGET

Il est tout à fait possible de procéder à la désinstallation d'un logiciel ou d'une application avec *WinGET*. Il suffit d'utiliser le paramètre `uninstall` suivi du nom du logiciel concerné.

**Commande:**

```powershell
winget uninstall 'VLC Media Player'
```

**Résultat:**

![WingetUninstall](./Assets/05/WingetUninstall.png)

:::caution
Dans certains cas, WinGET ne fait que lancer l'exécutable responsable de la désinstallation du logiciel. Ce qui n'est pas une véritable désinstallation en soi puisque l'on doit poursuivre la désinstallation en suivant certaines étapes dans les fenêtres du programme de désinstallation. En d'autres mots, il y a encore matière à amélioration pour obtenir une v.ritable désinstallation automatique avec WinGET.
:::

### Le panneau de configuration

Le panneau de configuration est sans doute l'un des éléments emblématiques de Windows. Il faut dire que sa première apparition remonte à [Windows 3.0](01-Historique.md#windows-30). Même si certaines configurations sont désormais accessibles depuis l'application Paramètres dans Windows, le panneau de configuration est toujours présent et prêt à être utilisé. Pour ouvrir le panneau de configuration, vous pouvez tout simplement faire une recherche dans le menu démarrer ou taper *control panel* dans la fenêtre « Exécuter ». 

(raccourci clavier: <kbd>&#8862; win</kbd>+<kbd>r</kbd>).

![PanneauDeConfig](./Assets/05/ExecControlPanel.png)

Une fois le panneau de configuration ouvert, cliquez sur « Désinstaller un programme »:

![UninstallControlPanel](./Assets/05/UninstallControlPanel.png)

La liste de vos logiciels s'affichera et vous aurez alors la possibilité de les désinstaller. Ceci étant dit, vous verrez bien moins d'éléments affichés que lorsque vous passez par l'application paramètres. Pourquoi ? Il y a plusieurs raisons à cela:

1. **Type d'installation:** Certains logiciels, notamment ceux installés via le *Microsoft Store* ou des applications UWP (Universal Windows Platform), peuvent ne pas être visibles dans le panneau de configuration. Ils sont gérés différemment et apparaissent uniquement dans l'application Paramètres.

2. **Mise à jour des fonctionnalités:** Windows 11 met davantage l'accent sur l'application Paramètres pour la gestion des applications, et cela peut entraîner des différences dans la manière dont les logiciels sont listés et désinstallés.

En fin de compte, le panneau de configuration est vieillissant et tout porte à croire que Microsoft le fera éventuellement disparaitre. C'est pourquoi, lentement, Microsoft nous force légèrement la main afin que nous utilisions la nouvelle application Paramètres.