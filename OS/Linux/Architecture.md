---
layout: OS
---

## Architecture 🌳

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