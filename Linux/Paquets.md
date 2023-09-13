---
layout: default
---

## La gestion des paquets 🗃

Tant sur Linux que sur Windows, il est possible d'installer divers logiciels. Les deux systèmes d'exploitation partagent des méthodes communes d'installation. Analysons les ensemble.

### L'installation manuelle

Tant sur Windows que sur Linux, l'installation manuelle était une chose assez commune avant les années 2000. Il suffisait de naviguer sur le web ou de posséder l'`url` d'un fichier, on téléchargeait l'installateur et puis on le lançait tout simplement. Cette méthodologie est encore très populaire. Cela dit, elle comporte certains enjeux:

* Le téléchargement d'exécutables sur le web comporte des risques liés à la sécurité surtout lorsque l'utilisateur s'y connait peu en informatique.

* En mode terminal, sous Linux ou Windows, il faut connaitre l'`url` de l'exécutable à télécharger et utiliser des commandes telles que `wget` ou `curl` pour effectuer le téléchargement. Cette méthodologie n'est pas intuitive pour un simple utilisateur.

Heureusement, le marché des technologies de l'information a vu naître un nouveau joueur.

### Le magasin

Vers la fin de la première décennie des années 2000, on aperçoit un nouveau concept prendre d'assaut le marché de l'informatique: Les magasins de logiciel. Ces magasins \(Microsoft Store, Google Play, Ubuntu Software, etc.\) permettent de centraliser et de sécuriser les logiciels ou les applications qui sont régulièrement téléchargés par les utilisateurs finaux. Ce nouveau concept vient donc pallier aux problèmes qu'apportait l'installation manuelle:

* On réduit à quasiment zéro les risques reliés à la sécurité en centralisant les applications dans un endroit géré par une entreprise telle que Microsoft, Apple ou même Canonical\(Ubuntu\)

* On simplifie grandement la vie de l'utilisateur qui n'a plus besoin de rechercher son logiciel sur internet puisqu'il n'a qu'à regarder dans le magasin.

Or, même si l'idée des magasins d'applications semble géniale pour les utilisateurs, celle-ci n'est pas parfaite pour les administrateurs. En effet, les magasins n'offrent pas la possibilité de sélectionner une version donnée d'un logiciel. Qui plus est, ces magasins nécessitent presque toujours une interface graphique pour fonctionner. C'est donc ici qu'entre en jeu la notion de paquet.

### Le gestionnaire de paquet

Un gestionnaire de paquet est un système qui permet d'installer des paquets de contenu informatiques, de les maintenir à jour et de les désinstaller. Ces paquets peuvent être des logiciels, du contenu multimédia, des typographies, etc. \(source:https://doc.ubuntu-fr.org/gestionnaire_de_paquets\)

Ces paquets proviennent d'où ? Ils proviennent de dépôts. Ces dépôts sont en fait des serveurs sur lesquels sont mis à disposition plusieurs logiciels et autres paquets pour les utilisateurs. Évidemment, lorsque vous installez Ubuntu, les dépôts dits officiels sont déjà configurés et vous pouvez donc installer vos logiciels favoris.

C'est aussi à partir de ces dépôts que sont effectuées les mises à jour du système. Nous verrons donc ensemble comment utiliser ce gestionnaire de paquet via le terminal d'Ubuntu. 

Le gestionnaire de paquet d'Ubuntu est APT \(Advanced Package Tool\). Sachez cependant que pour d'autres distributions de Linux, on utilise RPM ou encore YUM, deux autres gestionnaires de paquet. 

Aussi, sachez qu'à chaque fois que vous voudrez utiliser la commande `apt`, il faudra le faire en mode superutilisateur.

### Les mises à jour avec APT

D'abord, voyons comment mettre votre système à jour en utilisant le gestionnaire de paquet `apt` dans le terminal. Les mises à jour se feront en deux temps:

1. Vous devrez demander à Linux de comparer sa liste de logiciels installés à la liste trouvée dans les dépôts officiels. Dans le cas où Linux trouverait certaines disparités entre vos versions de logiciels ainsi que les versions trouvées dans les dépôts, il vous annoncera que des mises à jour sont disponibles.

1. Une fois la vérification des mises à jour compléter. Vous pouvez choisir de les télécharger et de les installer.

Donc dans l'ordre, nous vérifions l'état des mises à jour avec la commande:

```bash
sudo apt update
```

puis, nous les téléchargeons et les installons avec la commande:

```bash
sudo apt upgrade
```

### Installer des paquets

Pour installer des paquets avec `apt`, il faudra utiliser la commande `apt install`. Par exemple, pour installer audacity:

```bash
sudo apt install audacity
```
Voici donc ce que vous retournera Linux en résultat:

[!APTInstall](../Images/AptInstall.png)

* Encadré rouge: Il s'agit des dépendances nécessaires au logiciel que vous tentez d'installer. La plupart du temps, ces dépendances sont constituées de bibliothèques partagées. Elles peuvent servir à accéder à une base de données, à utiliser des protocoles réseau ou même à dessiner des éléments graphiques à l'écran.

* Encadré jaune: Il s'agit de paquets suggérés. S'ils ne sont pas installés, le logiciel fonctionnera tout de même. Ceci étant dit, vous pourriez avoir besoin de ces paquets supplémentaires si vous deviez utiliser une fonctionnalité très spécifique du logiciel que vous installez.

* Encadré vert: Vous retrouverez ici la totalité des paquets qui seront installés si vous acceptez l'installation. Le logiciel et ses dépendances y seront listés.

### Rechercher un paquet

Il est possible de rechercher des paquets sur les dépôts avec la commande `apt search`. Il suffit d'entrer le nom du paquet recherché en paramètre.

```bash
sudo apt search thunderbird
```

Tous les paquets contenants le terme "thunderbird" seront affichés. Or, si le logiciel a de nombreux modules complémentaires, vous pourriez vous retrouver avec une très longue liste à scruter. Pour trouver spécifiquement le logiciel "thunderbird", nous pourrions utiliser des méta-caractères \(expressions régulières\) comme dans l'exemple ci-dessous:

```bash
sudo apt search ^thunderbird$
```

### Supprimer un paquet et ses dépendances

Il est possible de supprimer un paquet avec la commande `apt remove`. Or, cette commande ne vérifiera pas si les dépendances installées avec le paquet concerné sont toujours utiles et si elles ne nécessiteraient pas d'être désinstallées. À la longue, n'utiliser que cette commande pour supprimer nos paquets pourraient embourber notre ordinateur de bibliothèques supplémentaires inutilisées.

C'est pourquoi je vous recommande plutôt la commande `apt autoremove`. Celle-ci prendra le temps de vérifier si des dépendances nécessitent d'être désinstallées en même temps que la suppression du logiciel concerné.

Pour supprimer un paquet, utilisez donc la commande comme suit:

```bash
sudo apt autoremove thunderbird
```

### Installer un paquet .deb téléchargé manuellement

Finalement, il est tout à fait possible d'utiliser `apt` pour installer un logiciel que vous auriez téléchargé depuis internet. Il faudra cependant faire bien attention d'indiquer le chemin local du paquet puisqu'autrement, `apt` tentera de télécharger le paquet lui-même. Exemple:

```bash
sudo apt install ~/Downloads/code.deb
```