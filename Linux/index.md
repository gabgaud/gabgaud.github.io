# Linux

Linux est avant tout un système d'exploitation, ou devrais-je dire plutôt une famille de systèmes d'exploitation ? Tout comme Windows d'ailleurs. Je ne dresserai pas l'historique de Linux sur cette page. Vous pouvez consulter [wikipédia](https://fr.wikipedia.org/wiki/Linux) à cet effet. J'aborderai plutôt la conception du système et son utilisation.

## Architecture

Pour la plupart du commun des mortels, la racine d'un disque dur est représenté par une lettre `C:`. C'est une notion qui a été inculqué dût à la manière dont fonctionne Windows. Or, chez Linux, on a plutôt opté pour le caractère `/`. En effet, la barre oblique représente le début de l'arborescence système chez Linux. Il s'en suit alors une arborescence complète, tout comme chez Windows d'ailleurs. Nous retrouvons donc les dossiers suivants:

* `/` C'est la racine du disque dur
* `/bin` C'est le diminutif de _binaries_. Ce dossier contient les essentiels du système pour les utilisateurs. Les commandes _ls_, _pwd_, et _cp_ y sont stockés par exemple.
* `/boot` Ce dossier contient les fichiers nécessaires au démarrage et le noyau du système. 
*  `/dev` C'est le diminutif de _devices_. C'est le point d'entrée de tous les périphériques. \(Clavier, webcam, Clé USB, etc.\)