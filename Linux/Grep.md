---
layout: default
---

## GREP et les expressions régulières 🧪

La commande `grep` est sans doute l'une des plus utiles du terminal et c'est pourquoi elle se mérite une section à elle seule. En fait, `grep` est l'aconyme de "Global Regular Expression Print". La commande vous permet donc de rechercher du texte sur la base d'un modèle. Quel genre de modèle me demanderez-vous ? Prenons un exemple simple, je cherche à trouver un numéro de téléphone dans un fichier. Cela dit, je ne connais pas le numéro de téléphone que je recherche. Par contre, je sais qu'un numéro de téléphone correspond au modèle suivant: XXX-XXX-XXXX. Je pourrais donc demander à `grep` de chercher le contenu d'un fichier qui correspond à ce modèle.

### REGEX

Ce modèle, c'est ce que l'on nomme une expression régulière. Il s'agit d'une expression permettant d'indiquer à `grep` le genre de texte que je recherche. La composition d'une expression régulière passe par l'utilisation de metacaractère et de texte. Nous étudierons le tout.

Pour les prochains exemples d'utilisation de `grep`, j'utiliserai le livre "Les 3 mousquetaires" que pouvez [télécharger](https://gutenberg.org/ebooks/13951.txt.utf-8) gratuitement sur le site du projet Gutenberg.

### Rechercher un mot

Dans son utilisation la plus simple, `grep` permet de rechercher un mot. Par exemple, si je recherchais le mot "officier" dans le texte des 3 mousquetaires, la commande ressemblerait à :

```bash
grep "officier" 3mousquetaires
```
Voici le résultat obtenu:

![GrepOfficier](../Images/Grep_Officier.png)

Chaque ligne du résultat représente une ligne de texte où l'expression recherchée a été repérée. Sur l'image, vous n'en voyez qu'une partie. Ce mot revient très souvent dans le texte. 

### Somme d'une expression

Combien de fois le mot "officier" apparait-il en fait ? Il est possible de demander à `grep` en utilisant le commutateur `-c`.

```bash
grep -c "officier" 3mousquetaires
```

![SommeOfficier](../Images/GrepSommeOfficier.png)

Le mot "officier" apparaitrait donc 83 fois...ou presque. En fait, il ne faut pas négliger le fait que Linux est un système "sensible à la casse". Pour Linux, le mot "officier" et le mot "Officier" sont différents. Pour ignorer cette différenciation que Linux fait entre majuscules et minuscules, nous ajouterons le commutateur `-i`.

```bash
grep -ci "officier" 3mousquetaires
```

![SommeOfficierInsensible](../Images/GrepSommeOfficierInsensible.png)

Cette fois ça y est! Nous avons toutes les occurences.

### Correspondance d'ancrage

Les ancres sont des caractères spéciaux me permettant de déterminer à quel endroit sur une ligne de texte un modèle est considéré comme valable. Reprenons notre exemple avec le mot ""officier". Je sais qu'il y a un total de 86 occurences du mot "officier" dans le texte concerné. Cela dit, j'aimerais retrouvé seulement les mots "officier" qui sont en début de ligne. Le metacaractère `^` permet donc ce genre de correspondance par ancrage. Nous l'utiliserons comme suit:

```bash
grep "^officier" 3mousquetaires
```
![OfficierDebut](../Images/GrepDebut.png)

Nous avons donc un total de 4 lignes dans le roman qui débutent par le mot "officier".