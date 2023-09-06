# Linux

Linux est avant tout un système d'exploitation, ou devrais-je plutôt dire une famille de systèmes d'exploitation ? Tout comme Windows d'ailleurs. Je ne dresserai pas l'historique de Linux sur cette page. Vous pouvez consulter [wikipédia](https://fr.wikipedia.org/wiki/Linux) à cet effet. J'aborderai plutôt la conception du système et son utilisation.

* * *

## Architecture

Pour la plupart du commun des mortels, la racine d'un disque dur est représentée par une lettre `C:`. C'est une notion qui a été inculquée dût à la manière dont fonctionne Windows. Or, chez Linux, on a plutôt opté pour le caractère `/`. En effet, la barre oblique représente le début de l'arborescence système chez Linux. Il s'en suit alors une arborescence complète, tout comme chez Windows d'ailleurs. Nous retrouvons donc les dossiers suivants:

* `/` C'est la racine du disque dur

* `/bin` C'est le diminutif de _binaries_. Ce dossier contient les essentiels du système pour les utilisateurs. Les commandes _ls_, _pwd_, et _cp_ y sont stockés par exemple.

* `/boot` Ce dossier contient les fichiers nécessaires au démarrage et le noyau du système. 

*  `/dev` C'est le diminutif de _devices_. C'est le point d'entrée de tous les périphériques. \(Clavier, webcam, Clé USB, etc.\)

* `/etc` C'est l'acronyme d'_Editing Text Config_. C'est là que sont la plupart des fichiers de configuration du système et des services.

* `/home` C'est ici que sont stockés les répertoires personnels des utilisateurs.

* `/lib` Diminutif de _libraries_. Contiens des bibliothèques partagées essentielles au système lors du démarrage.

* `/proc` Diminutif de _process_. Contiens des fichiers spéciaux dans lesquels nous retrouvons de l'information sur le système.

* `/root` Répertoire personnel du superutilisateur.

* `/usr` Acronyme de _Unix System Ressources_ contient diverses ressources qui sont partagées entre les utilisateurs du système.

* `/var/` Diminutif de _variable_ Contient des données variant en fonction des systèmes et des logiciels installés sur le système.

* * *

## Interfaces graphiques \(GUI\)

Une interface graphique est un environnement permettant aux humains de communiquer des instructions à une machine par l'entremise d'objets qui sont affichés sur un écran. On y retrouve généralement des fenêtres, des boutons, des icônes et un pointeur \(souris\). L'interface graphique de Windows est généralement bien connue.

![W10](../Images/Windows-10-Bureau.png)

Or, sous Linux, l'interface graphique est interchangeable. Nous pouvons donc opérer un système d'exploitation Linux donné, tout en exploitant l'une ou l'autre des interfaces qui nous intéressent le plus. Voici donc quelques-unes des interfaces graphiques les plus connues sous Linux:

* ### GNOME \(GNU Network Object Model\)
GNOME est sans doute l'une des interfaces graphiques les plus populaires chez Linux. Elle a d'ailleurs été longtemps l'interface graphique par défaut d'Ubuntu. 

![Gnome](../Images/Gnome.png)

* ### KDE \(Kool Desktop Environment\)
KDE est très souvent le petit préféré des nouveaux adeptes de Linux. C'est parce qu'il partage plusieurs similarités avec l'interface graphique de Windows. On y retrouve un menu en bas à gauche comprenanant les différents logiciels installés ainsi qu'une barre des tâches au bas de l'écran.

![Kubuntu](../Images/kubuntu.png)

* ### XFCE
Rapidité, économie de ressources et simplicité sont les trois prémices qui ont mené au développement de l'environnement graphique XFCE. Cette interface est effectivement très légère et peut facilement s'exécuter sur des ordinateurs qui ont peu de performances à offrir.

![XFCE](../Images/XFCE-Desktop.png)

* ### Le terminal \(Absence d'interface graphique\)
Même s'il peut vous refroidir aux premiers abords, le terminal Linux est un réel charme à utiliser lorsque nous nous y sommes habitués. Utiliser le terminal procure de réels avantages: l'économie de ressources, la rapidité d'exécution versus l'interface graphique et il est même possible d'automatiser certaines tâches. Nous nous attarderons longuement au terminal linux dans la prochaine section.

![Terminal](../Images/CLI-Linux.png)

Sachez qu'il existe encore d'autres interfaces graphiques. L'objectif était seulement de vous en présenter quelques-unes afin que vous pussiez vous en faire une idée et réaliser que cet aspect interchangeable de Linux diffère de Windows.

* * *

## Ligne de commande \(CLI\) Linux
La ligne de commande et l'utilisation du terminal Linux permettent d'outrepasser l'interface graphique. Tout bon technicien se doit de posséder une base minimale avec les commandes du terminal. Évidemment, il n'y a rien comme la pratique. Essayez les diverses commandes qui vous sont présentées et mettez-les en contexte autant que possible. Cela dit, il faut d'abord comprendre ce qui se passe lorsque vous ouvrez un terminal. Observez l'image du terminal présenté ci-dessus. Vous y retrouverez une ligne de texte semblable à celle-ci:

gabriel @ ubgab : ~ $

Chacun de ces éléments a une signification:

* `gabriel` : C'est le nom de l'utilisateur qui s'apprête à utiliser la ligne de commande.

* `@` : C'est un délimitateur ici. Il sépare l'utilisateur de l'ordinateur.

* `ubgab`: C'est le nom de l'ordinateur sur lequel nous travaillons actuellement.

* `:` : Un autre délimitateur. Il sépare le nom de l'ordinateur du répertoire au courant.

* `~` : Ici vous retrouverez l'endroit où vous êtes dans l'ordinateur. Le caractère ici présent \(le tilde\) représente votre répertoire personnel \(/home/_utilisateur_\)

* `$` : Ce dernier caractère représente votre niveau de droit actuel. `$` signifie que vous avez les droits d'un simple utilisateur. Alors que le sybole `#` signifie que vous êtes en mode superutilisateur.

### CD \(Change Directory\)
La commande CD permet de se déplacer à travers les différents dossiers du système d'exploitation. Par exemple, si je me trouve actuellement dans mon répertoire personnel et que je souhaite me rendre à la racine du disque, je pourrais taper la commande suivante:

```bash
cd /
```
Pour aller dans le dossier `/var/log/`, je pourrais taper la commande suivante:

```bash
cd /var/log/
```

Il est également possible de reculer en ligne de commande, soit l'équivalent du bouton "back" dans l'explorateur Windows. Pour cela, on utilise `..` de cette façon:

```bash
cd ..
```
Lorsque nous nous déplaçons ainsi dans l'ordinateur, il importe de différencier les notions de chemin relatif et absolu:

* **Chemin absolu:** Un chemin absolu est composé de tous les dossiers et sous-dossiers à traverser pour se rendre à une destination déterminé, et ce, depuis la racine du disque. Sous Windows, on dirait que c'est le chemin complet vers un fichier en partant de la racine du disque dur C:. Par exemple, si je souhaite me rendre dans mon dossier Documents avec un chemin absolu, je devrais entrer cette commande:

```bash
cd /home/gabriel/Documents/
```

* **Chemin relatif:** Un chemin relatif s'adaptera en fonction de l'endroit où vous vous trouvez dans l'arborescence du système. Reprenons l'exemple de mon dossier Documents, mais cette fois, nous assumerons que je suis présentemment dans mon répertoire personnel \(/home/gabriel/\). Je pourrais alors taper la commande suivante:

```bash
cd Documents/
```
Lequel des deux types devez-vous privilégier ? Il n'y a malheureusement pas de bonne réponse à cette question. Parfois un chemin relatif sera plus court à taper et d'autres fois, ce sera le contraire. Tout dépend de ce que vous faites et d'où vous êtes dans l'ordinateur. Ne vous faites pas, vous créerez vos propres habitudes sur le terminal bien assez vite. Allez-y comme vous le sentez.

### LS \(List\)
La commande LS permet d'afficher le contenu d'un répertoire. C'est très pratique, qu'on se le dise. Pour afficher le contenu de mon dossier Documents, je pourrais taper la commande suivante:

```bash
ls /home/gabriel/Documents/
```
Par défaut, vous verrez les dossiers apparaitrent en bleu et les fichiers en blanc. Un jour ou l'autre, vous verrez d'autres couleurs également. Nous aurons l'occasion d'en reparler.

Certaines commandes permettent l'utilisation de commutateurs et de paramètres. Les paramètres d'une commande indique généralement un préalable à l'utilisation de la commande elle-même. Par exemple, pour utiliser la commande `ls`, il importe d'indiquer le répertoire dont nous désirons lister le contenu. Dans le cas où aucun paramètre n'indiquerait un répertoire concerné, la commande considèrera le répertoire courant comme celui dont vous désirez lister le contenu.

Un commutateur permet d'adapter, voir modifier le comportement d'une commande. Dans le cas de la commande `ls`, il existe deux principaux commutateurs:
1. `-l` Ce commutateur indique à la commande qu'elle doit afficher plus de détails.
1. `-a` Ce commutateur indique à la commande qu'elle doit afficher tout les éléments, même ceux qui serait cachés.

On inscrit généralement les commutateurs entre la commande et ses paramètres. Par exemple:

```bash
ls -l /home/gabriel/Documents/
```

Il est également possible de jumeler les commutateurs entre-eux:

```bash
ls -la /home/gabriel/Documents/
```

Certains commutateurs sont des mots entiers. Il faut alors les indiquer à l'aide du préfixe `--`:

```bash
ls --all /home/gabriel/Documents/
```

Finalement, il faut considérer que Linux est un système **sensible à la casse**. C'est donc dire qu'un commutateur `-l` avec une commande donnée n'aura pas le même rôle que le commutateur `-L` avec la même commande donnée.