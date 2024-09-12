# Architecture 🌳

## La racine du système - Le disque C:

L'arborescence entière de l'écosystème Windows est hébergé sur un disque dur. On a attribué la lettre «­C:» à ce stockage. Peu importe le fichier ou le dossier que vous désirez récupérer, s'il a été créé ou enregistré sous Windows, il est quelque part dans le disque dur «C:» (À quelques exceptions près).

 :::tip[Le saviez-vous ?]

Pourquoi ne pas avoir utilisé la lettre «A:» comme lettre pour le disque dur principal ? Pour comprendre, il faut reculer jusqu'à l'époque de [MS-DOS](https://fr.wikipedia.org/wiki/MS-DOS). Les lettres «A:» et «B:» étaient réservés aux lecteurs de [disquettes](https://fr.wikipedia.org/wiki/Disquette). On a donc attribué la lettre «C:» au disque dur du système. Même si les lecteurs de disquettes appartiennent désormais au passé, l'attribution de la lettre «C:» au disque dur principal est resté. C'est donc un héritage d'un passé lointain qui explique son utilisation.

:::

## Certains dossiers dignes de mention

Que retrouve-t-on donc sur ce disque principal ? Plusieurs dossiers importants, évidemment, dont certains cachés. Cela dit, attardons-nous à certains dossiers plus importants et qui nécessiteront tôt ou tard, des interventions.

:::caution

Certains des dossiers listés dans cette section peuvent avoir été traduit en français dans le cas où vous utiliseriez Windows dans cette langue. Ceci étant dit, il ne s'agit que **d'alias**. Le véritable nom des dossiers est bel et bien en anglais. C'est le cas du dossier **« C:\Users »** et du dossier **« C:\Program files »** à titre d'exemple.

:::

### C:\Users

C'est dans ce répertoire que sont stockés toutes les données des utilisateurs. Généralement, vous retrouverez un sous-dossier par utilisateur, correspondant au profil de ce dernier. Un profil utilisateur contient:

- Les données de l'utilisateur (images, musique, téléchargements, etc.)
- La configuration et les paramètres de l'utilisateur stockés dans le fichier **NTUser.dat**
- La configuration des paramètres et des préférences des applications dans le dossier **AppData**.

:::danger

Le fichier **NTUser.dat** contient une portion du registre de Windows. Le registre Windows est une base de données dans laquelle sont centralisé l'ensemble des paramètres du système, nous aurons l'occasion d'en parler un peu plus loin.

:::

**Exemple du contenu d'un profil:**

![ProfileWin](./Assets/03/profile.png)

### C:\Program files

C'est le répertoire par défaut où s'installeront les logiciels et applications que vous installerez sur votre PC. Lors de l'installation, si vous ne précisez pas de dossier d'installation particulier, un dossier au nom du logiciel y sera créé et les données de ce dernier stocké. D'ailleurs, lorsque vous cliquez sur l'icone d'un programme situé sur votre bureau, il s'agit, plus souvent qu'autrement, que d'un raccourci vers le fichier exécutable situé dans le dossier «C:\Program files». Dans l'image ci-dessous, on constate que le fichier exécutable de 7-zip, un utilitaire de compression, se retrouve dans un dossier à son nom sous « C:\Program files »:

![7zip](./Assets/03/7z.png)


### C:\Program files (x86)

C'est un répertoire pour les applications également. Cependant, ce répertoire est réservé aux applications moins modernes, s'exécutant en 32 bits. C'est logiciels sont distingués des autres puisqu'ils nécessitent un environnement un peu particulier que Windows mettra en place pour les exécuter.

### C:\ProgramData

Ce répertoire est utilisé pour stocker des données d'application partagées, c'est-à-dire des fichiers et des paramètres qui doivent être accessibles à tous les utilisateurs de l'ordinateur. Cela permet l'utilisation d'un logiciel et de ses données par plusieurs utilisateurs sans avoir a en dupliquer les données dans plusieurs profiles.

### C:\Windows

Le dossier Windows est l'un des dossiers les plus critiques du système Windows et il joue un rôle essentiel dans le fonctionnement du système d'exploitation. Ce répertoire contient une panoplie d'éléments. Je ne pourrais pas tous les énumérer ici, mais nous pouvons certainemment en analyser quelques-uns:

1. **Noyau Windows:** Les fichiers principaux du noyau (le coeur de Windows) sont répertoriés dans ce dossier. Ces fichiers assurent la gestion des ressources matérielles et la communication entre le matériel et les logiciels.

2. **Fichiers de démarrage:** Des fichiers nécessaires au bon démarrage du système sont également présents dans ce répertoire. Le fichier *bootmgr* et le sous-dossier *System32\Boot* en sont deux exemples.

3. **Sous-dossier: System32**: Le sous-dossier *System32* contient de nombreux fichiers cruciaux tels que certains exécutables essentiels comme *cmd.exe* ou *explorer.exe* ([l'explorateur Windows](www.tonprof.ca/OS/Windows/Interfaces%20graphiques#lexplorateur-windows)). Ce dossier contient également des pilotes et des [bibliothèques dynamiques (DLL)](https://fr.wikipedia.org/wiki/Dynamic_Link_Library) au bon fonctionnement de Windows.