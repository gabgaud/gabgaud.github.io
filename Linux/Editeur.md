---
layout: default
---

## Les éditeurs de texte
Ce n'est pas parce que nous travaillons dans le terminal de Linux qu'il est impossible d'éditer des fichiers. En effet, lorsque vient le temps d'éditer des fichiers dans le terminal, Linux vous offre deux possibilités: VIM et NANO.

Dans cette page, nous nous attarderons aux deux. Commençons d'abord par Nano, il est plus simple d'utilisation et donc plus apprécié chez ceux et celles qui apprennent Linux.

## Nano

Pour lancer l'éditeur de texte Nano, vous n'avez qu'à entrer le nom de l'éditeur suivi du fichier à éditer. Si le fichier n'existe pas, Nano le créera automatiquement:

```bash
nano informatique
```
Voici à quoi ressemble l'éditeur de texte Nano¸:
![Nano](../Images/Nano.png)

Une fois dans cette fenêtre, vous pourrez dès lors, taper du texte. Évidemment, taper du texte ou l'effacer, ca n'a rien d'impressionnant et ca ne relève pas de la sorcellerie. Cela dit, Nano est équipé de quelques fonctions intéressantes. Remarquez au bas de l'écran le menu des actions disponibles.

![MenuNano](../Images/MenuNano.png)

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