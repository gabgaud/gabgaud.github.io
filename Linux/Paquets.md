---
layout: default
---

## La gestion des paquets 🗃

Tant sur Linux que sur Windows, il est possible d'installer divers logiciels. Les deux systèmes d'exploitation partagent des méthodes communes d'installation. Analysons les ensemble.

### L'installation manuelle

Tant sur Windows que sur Linux, l'installation manuelle était une chose assez commune avant les années 2000. Il suffisait de naviguer sur le web ou de posséder l'`url` d'un fichier, on téléchargeait l'installateur et puis on le lançait tout simplement. Cette méthodologie est encore très populaire. Cela dit, elle comporte certains enjeux:

* Le téléchargement d'exécutables sur le web comporte des risques liés à la sécurité surtout lorsque l'utilisateur s'y connait peu en informatique.

* En mode terminal, sous Linux ou Windows, il faut connaitre l'`url` de l'exécutable à télécharger et utiliser des commandes telles que `wget` ou `curl` pour effectuer le téléchargement. Cette méthodologie n'est pas intutitive pour un simple utilisateur.

Heureusement, le marché des technologies de l'information a vu naître un nouveau joueur.

### Le magasin

Vers la fin de la première décennie des années 2000, on apercoit un nouveau concept prendre d'assaut le marché de l'informatique: Les magasins de logiciel. Ces magasins permettent de centraliser et de sécuriser les logiciels ou les applications qui sont régulièrement téléchargés par les utilisateurs finaux. Ce nouveau concept vient donc pallier aux problèmes qu'apportaient l'installation manuelle:

* On réduit à quasiment zéro les risques reliés à la sécurité en centralisant les applications dans un endroit géré par une entreprise telle que Microsoft, Apple ou même Canonical\(Ubuntu\)

* On simplifit grandemment la vie de l'utilisateur qui n'a plus besoin de rechercher son logiciel sur internet puisqu'il n'a qu'à regarder dans le magasin.

Or, même si l'idée des magasins d'applications semble génial pour les utilisateurs, celle-ci n'est pas parfaite pour les administrateurs. En effet, les magasins n'offrent pas la possibilité de sélectionner une version donnée d'un logiciel. Qui plus est, ces magasins nécessitent presque toujours une interface graphique pour fonctionner. C'est donc içi qu'entre en jeu la notion de paquet.

### Le gestionnaire de paquet

Un gestionnaire de paquet est un système qui permet d'installer des paquets de contenu informatiques, de les maintenir à jour et de les désinstaller. Ces paquets peuvent être des logiciels, du contenu multimédia, des typographies, etc. \(source:https://doc.ubuntu-fr.org/gestionnaire_de_paquets\)

Ces paquets proviennent d'où ?