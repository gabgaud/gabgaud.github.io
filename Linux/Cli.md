---
layout: default
---

## Menu des commandes

|:--------|:--------|:--------|:--------|
| [cd](./Cli.html#cd-change-directory) | [ls](./Cli.html#ls-list) | [man](./Cli.html#man-manuel) | [mkdir](./Cli.html#mkdir-make-directory) |

## Ligne de commande \(CLI\) Linux
La ligne de commande et l'utilisation du terminal Linux permettent d'outrepasser l'interface graphique. Tout bon technicien se doit de posséder une base minimale avec les commandes du terminal. Évidemment, il n'y a rien comme la pratique. Essayez les diverses commandes qui vous sont présentées et mettez-les en contexte autant que possible. Cela dit, il faut d'abord comprendre ce qui se passe lorsque vous ouvrez un terminal. Observez l'image du terminal présenté ci-dessus. Vous y retrouverez une ligne de texte semblable à celle-ci:

gabriel @ ubgab : ~ $

Chacun de ces éléments a une signification:

* `gabriel` : C'est le nom de l'utilisateur qui s'apprête à utiliser la ligne de commande.

* `@` : C'est un délimitateur ici. Il sépare l'utilisateur de l'ordinateur.

* `ubgab`: C'est le nom de l'ordinateur sur lequel nous travaillons actuellement.

* `:` : Un autre délimitateur. Il sépare le nom de l'ordinateur du répertoire au courant.

* `~` : Ici vous retrouverez l'endroit où vous êtes dans l'ordinateur. Le caractère ici présent \(le tilde\) représente votre répertoire personnel \(/home/_utilisateur_\)

* `$` : Ce dernier caractère représente votre niveau de droit actuel. `$` signifie que vous avez les droits d'un simple utilisateur. Alors que le symbole `#` signifie que vous êtes en mode superutilisateur.

* * *

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

* * *

### LS \(List\)
La commande `ls` permet d'afficher le contenu d'un répertoire. C'est très pratique, qu'on se le dise. Pour afficher le contenu de mon dossier Documents, je pourrais taper la commande suivante:

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

### MAN \(Manuel\)
La commande `man` vous permet de consulter le manuel d'instructions d'une commande donnée. Vous y retrouverez une description de la commande passée en paramètre, les commutateurs disponibles ainsi que les paramètres obligatoires et facultatifs pour son utilisation. Par exemple, si je désirais consulter le manuel d'instructions de la command `ls`, je taperais la commande suivante:

```bash
man ls
```
### MKDIR \(Make Directory\)
La commande `mkdir` permet de créer des répertoires. Elle prendra nécessairement un emplacement et un nom pour le nouveau répertoire en paramètres. Exemple:

```bash
mkdir ./monrepertoire/
```
Avez-vous remarqué le `./` au début de ma dernière commande ? Sous Linux, le `./` signifie le répertoire courant. Autrement dit, dans ma dernière commande, je lui demande de créer un dossier nommé "monrepertoire" dans le répertoire courant, c'est-à-dire où je me trouve présentement.

### RM \(Remove\)
Comme son nom l'indique, la commande `rm` permet de supprimer un élément. Il peut s'agir d'un fichier ou même d'un dossier en utilisant le ou les bons commutateurs. La commande `rmdir` permet également de supprimer des répertoires, mais elle ne prend pas en charge les fichiers. Je vous recommande donc de ne retenir que la commande `rm` qui saura répondre à tous vos besoins. Pour supprimer un fichier, il suffit de passer son chemin et son nom en paramètres:

```bash
rm ./fichier1
```

### ECHO
La commande `echo` se contente tout simplement de renvoyer ce que vous lui demandez à l'écran. Ce n'est pas très pratique à première vue. Cela dit, dans le cadre de script ou même de programme, cela peut s'avérer très pratique de transmettre de l'information à l'utilisateur. La commande echo s'utilise comme suit:

```bash
echo "Hello world!"
```

### CAT \(Concatenate\)
L'utilité principal de la commande `cat` est de faire la concaténation de plusieurs fichiers, c'est-à-dire de les fusionner, dans un autre fichier de sortie ou tout simplement à l'écran. Or, les linuxiens 🤓 en ont fait une commande pour afficher le contenu d'un fichier. `cat` peut donc être utilisé à plusieurs escients. D'abord, pour afficher le contenu d'un fichier, on utilisera la commande de cette façon:

```bash
cat ./fichier1
```
Pour fusionner le contenu de plusieurs fichiers et en afficher le résultat à l'écran, on procèdera ainsi:

```bash
cat ./fichier1 ./fichier2
```

Finalement, si je désirais fusionner le contenu de plusieurs fichiers pour en renvoyer le résultat dans un autre fichier, j'utiliserais la commande comme suit:

```bash
cat ./fichier1 ./fichier2 > fichiersortie
```

L'opérande `>` joue un rôle bien particulier. En effet, cet opérande renvoie le texte qui serait normalement généré par une commande dans un fichier indiqué par l'utilisateur. Dans la commande précédente, le texte qui serait normalement affiché à l'écran par la commande `cat` est renvoyé dans le fichier "fichiersortie". Si le fichier n'existe pas déjà, il sera tout simplement créé automatiquement.

Dans le cas où le fichier indiqué existerait déjà, l'opérande `>` effacera son contenu pour y inscrire le résultat de la commande qui la précède. Pour éviter cette suppression, il est possible de doubler l'opérande comme dans l'exemple suivant:

```bash
cat ./fichier1 ./fichier2 >> fichiersortie
```
Le texte sera alors tout simplement ajouté à la fin du fichier.

### MV \(Move\)
La commande `move` permet non seulement de déplacer des éléments dans le système, mais elle offre en plus, la possibilité de renommer. Plus intéressant encore, la commande est capable de réaliser les deux actions en une seule commande. Pour renommer un fichier, il suffira d'entrer le nom actuel du fichier et le nouveau nom en paramètres:

```bash
mv ./vieuxNom ./nouveauNom
```

Pour déplacer un fichier, la commande s'utilise sensiblement de la même façon. Il faudra cependant indiquer le nouveau chemin du fichier à déplacer:

```bash
mv ~/fichierX /var/www/fichierX
```

Finalement, pour déplacer un fichier et le renommer dans une seule et même commande, il faudra tout simplement utiliser une fusion des deux commandes précédentes:

```bash
mv ~/fichierX /var/www/fichierY
```

### PWD \(Print Working Directory\)
La commande `pwd` permet d'afficher où nous nous trouvons actuellement dans l'arborescence de l'ordinateur. Même si à première vue cela semble évident, certaines configurations d'interpréteur de commande peuvent ne pas vous afficher l'endroit où vous vous trouvez. Cette commande devient alors essentielle.

```bash
pwd
```

### CP \(Copy\)
Tôt ou tard, vous aurez sans doute besoin de copier des fichiers, voir même des dossiers. La command `cp` vous permettra donc d'y arriver. Pour l'utiliser, il suffit d'entrer la source et la destination en paramètres de commande:

```bash
cp /home/utilisateur/Desktop/monTexte.txt ~/copieMonTexte.txt
```

### HEAD et TAIL
J'ai décidé d'aborder les commandes `head` et `tail` ensembles puisqu'elles ont sensiblement le même objectif, à une différence près. Ces commandes permettent à l'utilisateur d'afficher une partie d'un fichier seulement. Sans entrer dans des exemples trop avancés, elles permettent de lire les lignes qui débutent \(`head`\) un fichier ou les lignes qui le termine \(`tail`\). Par défaut, les deux commandes afficheront 10 lignes. Sachez qu'il est possible d'indiquer le nombre de lignes souhaitées à l'écran. Je vous invite à consulter le manuel à cet effet. 

```bash
head ~/monFichier.txt
```

```bash
tail ~/monFichier.txt
```

### SUDO \(Super user do\)
La commande `sudo` permet d'exécuter une commande en tant que superutilisateur. Les actions qui peuvent avoir un impact considérable sur le système \(MAJ, Suppression de certains fichiers, redémarrage du système\) nécessitent d'être lancées par un superutilisateur. Afin d'utiliser `sudo`, l'utilisateur doit d'abord avoir été ajouté au groupe des sudoers. Sous Ubuntu, le premier utilisateur créé lors de l'installation du système y est automatiquement ajouté. Une fois la commande lancée avec `sudo` terminée, l'utilisateur repasse immédiatement en mode utilisateur. Voici un exemple d'utilisation de `sudo`:

```bash
sudo rm /etc/dhcp/dhcpd.conf
```

### SHUTDOWN `sudo`
La commande `shutdown` permet d'éteindre l'ordinateur convenablement. Les arguments passés à la commande peuvent permettre un délais avant la fermeture ou non et demander un redémarrage. Cette commande doit être exécuté en mode superutilisateur.

```bash
sudo shutdown -r now
```
