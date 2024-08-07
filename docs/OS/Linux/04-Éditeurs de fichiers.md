# Les éditeurs de texte ✍
Ce n'est pas parce que nous travaillons dans le terminal de Linux qu'il est impossible d'éditer des fichiers. En effet, lorsque vient le temps d'éditer des fichiers dans le terminal, Linux vous offre deux possibilités: VIM et NANO.

Dans cette page, nous nous attarderons aux deux. Commençons d'abord par Nano, il est plus simple d'utilisation et donc plus apprécié chez ceux et celles qui apprennent Linux.

## Nano

Pour lancer l'éditeur de texte Nano, vous n'avez qu'à entrer le nom de l'éditeur suivi du fichier à éditer. Si le fichier n'existe pas, Nano le créera automatiquement:

```bash
nano informatique
```
Voici à quoi ressemble l'éditeur de texte Nano¸:
![Nano](/img/Linux/Nano.png)

Une fois dans cette fenêtre, vous pourrez dès lors, taper du texte. Évidemment, taper du texte ou l'effacer, ca n'a rien d'impressionnant et ca ne relève pas de la sorcellerie. Cela dit, Nano est équipé de quelques fonctions intéressantes. Remarquez au bas de l'écran le menu des actions disponibles.

![MenuNano](/img/Linux/MenuNano.png)

Le caractère `^` représente la touche `ctrl` du clavier. Le caractère `M` qui précède certaines actions du menu, quant à lui, représente la touche `alt` du clavier.

Vous pouvez consulter l'aide de Nano à tout moment en appuyant simultanément sur les touches `ctrl` + `g`. Vous y trouverez de l'information pour vous aider dans l'utilisation de Nano.

### Sélectionner du texte (Nano)

Pour sélectionner du texte avec Nano, plusieurs possibilités s'Offrent à vous:
1. Utiliser la combinaison des touches `shift` et les flèches du clavier.
1. Utiliser la combinaison de touche `alt` + `a` pour marquer le début de la sélection, puis utilisez les flèches du clavier.
1. Utiliser la souris si une interface graphique est présente sur le système.

### Copier du texte (Nano)

Utilisez la combinaison de touches `alt` + `6` pour copier du texte préalablement sélectionné. En présence d'un GUI, vous pouvez utiliser la souris pour effectuer cette opération également.

### Couper du texte (Nano)

Couper du texte est la méthode la plus rapide pour en faire la suppression ou le déplacement dans Nano. Utilisez la combinaison des touches `ctrl` + `k` pour couper du texte que vous aurez préalablement sélectionné.

### Coller du texte (Nano)

Qu'il s'agisse de texte copié ou coupé, pour coller celui-ci, il suffit d'utiliser la combinaison des touches `ctrl` + `u` dans Nano.

### Rechercher et remplacer (Nano)

Il est possible de rechercher un mot précis \(Qu'il s'agisse d'une ou plusieurs occurences\) dans Nano. D'abord, inscrivez ce que vous recherchez en appuyant sur la combinaison de touches `ctrl` + `\`. Ensuite, Nano vous demandera d'indiquer par quoi vous voulez remplacer le terme recherché. Si Nano trouve le mot que vous tentez de remplacer, il vous demandera alors si vous désirez le remplacer une fois dans le texte ou partout dans le texte.

### Annuler "Undo" (Nano)

Pour annuler la dernière opération effectuée dans Nano, vous pouvez utiliser la combinaison de touches `alt` + `u`.

### Répéter "Redo" (Nano)

Si au contraire, vous désirez répéter une opération dans Nano, utilisez plutôt la combinaison `alt` + `e`.

### Enregistrer (Nano)

Pour enregistrer vos modifications ou votre fichier, vous devez entrer la combinaison de touches `ctrl` + `o`.

### Quitter

Finalement, lorsque vous voulez quitter Nano, il vous faudra appuyer sur les touches `ctrl` + `x`

* * *

## VIM 
`VIM` est un autre éditeur de texte disponible sous Linux. Même s'il est légèrement plus complexe, `VIM` est réellement plus flexible que `Nano` et il offre plus de fonctionnalités. Sous Ubuntu, nous retrouverons l'éditeur de texte `VI`. En fait, `VIM` est en quelques sorte l'évolution de l'éditeur `VI`. Cependant, en apprenant comment l'éditeur de texte `VIM` fonctionne, vous devriez arriver à vous débrouiller avec `VI` si vous n'en avez pas le choix. Vous aurez simplement moins de fonctionnalités.

Si, comme moi, vous travaillez avec Ubuntu. Il vous faudra installer `VIM` pour l'utiliser. Entrez donc la commande suivante:

```bash
sudo apt install vim -y
```

Nous aurons l'occasion de revenir sur l'installation de logiciels. Pour l'instant, concentrons-nous sur les éditeurs de texte.

Avant de vous apprendre toutes les commandes relatives à cet éditeur de texte, il faut d'abord comprendre que `VIM` comporte 3 modes:

* Le mode interactif : Le mode par défaut.

* Le mode insertion : Le mode pour entrer du texte.

* Le mode de commandes : Mode qui permet d'envoyer des commandes à `VIM` et au système.

## VIM : Mode Interactif

Lorsque vous ouvrez `vim`, de la même façon qu'avec `nano`, vous aurez accès au fichier en mode interactif. Dans ce mode, il vous sera impossible de taper du texte. Dans ce mode, vous pourrez effectuer des opérations de base sur le texte seulement:

### Se déplacer

Même si le fait de se déplacer dans un fichier texte peut paraitre évident, `vim` permet les déplacements avec les flèches du clavier mais aussi avec certaines touches du clavier:

* h : déplacement vers la gauche.

* j : déplacement vers le bas.

* k : déplacement vers le haut.

* l : déplacement vers la droite.

* 0 : placer le curseur au début de la ligne.

* $ : placer le curseur en fin de ligne.

* w : déplacement mot par mot

### Suppression de texte

`vim` vous offre la possibilité de supprimer du texte de plusieurs façon, contrairement à `nano` qui est relativement limité à ce sujet:

* x : permet de supprimer un nombre de lettres déterminé. Ajoutez simplement un chiffre devant `x` pour supprimer les lettres désirées.

* dd : permet de supprimer une ligne de texte complète. Il s'agit ni plus ni moins de la fonction couper.

* dw : permet de supprimer un mot.

* d0 : permet de supprimer tout ce qui se trouve entre le curseur et le début de la ligne.

* d$ : permet de supprimer tout ce qui se trouve entre le curseur et la fin de la ligne.

### Copier du texte

* yy : permet de copier une ligne de texte.

* yw : permet de copier un mot.

* y0 : permet de copier tout ce qui se trouve entre la position du curseur et le début de la ligne.

* y$ : permet de copier tout ce qui se trouve entre la position du curseur et la fin de la ligne.

### Coller du texte

Coller du texte est relativement simple avec `vim`, il suffit en fait d'appuyer sur la touche `p`. Sachez qu'il est possible d'inscrire un chiffre devant la lettre pour indiquer un nombre de copie désiré.

### Remplacer du texte

`vim` offre la possibilité de remplacer du texte. Prenez garde cependant, on ne parle pas ici d'insertion de texte mais bien de remplacement. La touche `r` vous permettra de remplacer une lettre. Placez le curseur sur la lettre à remplacer, appuyez sur `r` puis sur la nouvelle lettre désirée. En utilisant la touche `R` \(majuscule\), vous pourrez remplacer plusieurs lettres consécutivement.

### Annuler

Tout comme avec `nano`, il est possible d'annuler une ou plusieurs opérations. Pour y arriver, vous n'avez qu'à appuyer sur la touche `u`. De plus, en inscrivant un chiffre devant la lettre, vous indiquerez le nombre d'opérations à annuler. Si aucun chiffre n'est inscrit, seule une opération sera annulée.

### Rechercher du texte

Si vous êtes à la recherche d'un mot, vous pouvez appuyer sur la touche `/`, tapez votre mot et appuyez sur `enter`. Pour passer à la prochaine occurence de ce mot, appuyez sur la touche `n`.

## VIM : Mode Insertion

### Insérer du texte

C'est à peu près tout ce que vous pouvez faire dans ce mode. Pour entrer en mode "insertion de texte", appuyez sur la touche `i`. Vous verrez alors le mot --INSERTION-- au bas de l'écran à gauche:

![InsertionVim](/img/Linux/InsertionVim.png)

Cela veut donc dire que vous pouvez entrer du texte comme bon vous semble. Tôt ou tard, il vous faudra sortir du mode insertion afin de pouvoir enregistrer et même sortir de `vim`. Pour sortir du mode insertion et repasser en mode interactif, appuyez sur la touche `esc`.

## VIM : Mode Commande

Le mode commande vous permet d'entrer des commandes qui vont plus loin que la simple édition de texte. Par exemple, nous y retrouverons des commandes pour enregistrer, quitter ou même des commandes qui feront appel à des fonctions avancées telle que "substitute".

Pour entrer une commande, il faudra toujours commencer par le caractère `:`

### Enregistrer les modifications

Pour enregistrer les modifications effectuées dans un fichier, il vous faudra entrer la commande `:w`. Vous pouvez également enregistrer et quitter `vim` en une seule commande. Soit `:wq`

### Quitter

Il y a un nombre incroyable de blagues sur le web qui se moque de `vim` à ce sujet \(insinuant que `vim` est complexe et difficile à manipuler\). Pour quitter, il suffit d'entrer la commande `:q`. Dans le cas où vous auriez fait des modifications mais que vous ne souhaitez pas les enregistrer en quittant, vous pouvez utiliser la commande `:q!`.

### Fonction de recherche et remplacement

`vim` possède un outil de recherche et de remplacement assez puissant. En effet, celui-ci est capable de prendre en considération les recherches par expressions régulières. Nous n'aborderons pas les expressions régulières sur cette page. Cela dit, si cela vous intéresse, j'en parlerai dans la page accordée à la commande `grep`. Ceci étant dit, je peux tout de même vous montrer comment utiliser cette fonction dans sa méthodologie la plus simple. Voici donc quelques exemples pour vous guider:

1. `:s/mot_recherché/mot_à_inscrire`
L'exemple numéro 1 cherchera un mot et le remplacera la première occurence de ce mot par le mot à inscrire, et ce, seulement sur la ligne où se trouve le curseur.

1. `:s/mot_recherché/mot_à_inscrire/g`
L'exemple numéro 2 fera la même chose mais cette fois, la fonction remplacera toutes les occurences d'une même ligne par le mot à inscrire.

1. `:%s/mot_recherché/mot_à_inscrire/g`
L'exemple numéro 3 remplacera toutes les occurences du mot recherché par le mot à inscrire dans l'ensemble du fichier.

### Écran scindé

Oui, vous avez bien lu. Il est possible de scinder l'écran de `vim` et de travailler sur plusieurs fichiers à la fois. Pour ouvrir un deuxième fichier en écran scindé, il suffit d'utiliser la commande `:sp nom_du_fichier`. 

![SplitVim](/img/Linux/SPVim.png)

Une fois en mode écran scindé vous pouvez gérer le tout en utilisants les commandes suivantes :

* \(`ctrl` + `w`\) x 2 : permet de passer d'une écran à l'autre ou d'un fichier à l'autre si vous préférez.

* \(`ctrl` + `w`\) puis `+` : permet d'agrandir la fenêtre où le curseur se trouve.

* \(`ctrl` + `w`\) puis `-` : permet de rétrécir la fenêtre où le curseur se trouve.

* \(`ctrl` + `w`\) puis `=` : permet de remettre toutes les fenêtres à dimension égale.

* \(`ctrl` + `w`\) puis `r` : permet d'inverser la position des fenêtres.

* \(`ctrl` + `w`\) puis `q` : permet de fermer la fenêtre où le curseur se trouve.

Si vous préféreriez scinder l'écran à la verticale plutôt qu'à l'horizontale, il est possible de le faire avec la commande `:vsp`. Les commandes de contrôles sont exactement les mêmes qu'en horizontal.

### Commandes externes

Il est tout à fait possible d'envoyer des commandes au système d'exploitation sans sortir du logiciel `vim`. Il suffit de passer en mode commandes et de débuter vos commandes système par un point d'exclamation `!`. `vim` vous affichera alors temporairement le résultat de votre commande jusqu'à ce que vous appuyiez sur `enter` pour revenir en mode interactif dans `vim`.

### Options intéressantes

La commande `:set` permet de définir certains paramètres intéressants dans le logiciel. À titre d'exemple:

```bash
:syntax on
```

Cette commande activera la coloration de certaines balises de programmation. En effet, `vim` supporte toute une panoplie de langage de programmation. Il peut donc s'avérer utile d'activer le support de la syntaxe si vous l'utilisez pour programmer quoi que ce soit. Notez qu'il vous faudra remplace le terme "on" par "off" pour désactiver cette option.

```bash
:set number
```

Cette dernière commande vous affichera les numéros de ligne. C'est très pratique dans les fichiers assez chargé en texte.

Pour désactiver les numéros de ligne, il suffit d'entrer la même commande en terminant par un point d'exclamation `!`.