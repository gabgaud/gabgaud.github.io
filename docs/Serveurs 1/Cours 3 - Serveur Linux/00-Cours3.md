# Cours 3

## Les serveurs Linux 🐧

*« Pourquoi parle-t-on de Linux en classe Monsieur ? Personne n'utilise Linux »<br/>-Les étudiants*

Cette phrase, j'ai dû l'entendre des dizaines de fois depuis que j'enseigne l'informatique. Je l'ai entendu, elle, et toutes ses dérivées. Malheureusement elle est mal fondée. La plupart des étudiants qui me disent cela se fit uniquement à ce qu'il voit. Chez eux, chez leurs amis, la plupart des ordinateurs qu'ils croisent fonctionnent sous Windows ou Mac. Basé sur ce qu'ils voient, leur réflexion est légitime: Pourquoi apprendre Linux alors que le marché semble vide de toute présence de Linux ?

### Les héros de l'ombre

<u>En 2024, 70% à 80% des serveurs web dans le monde utilisent un système basé sur Linux.</u> Vous avez bien lu! Aujourd'hui l'accès au web est devenu un service essentiel. Tous les jours, vous utilisez des services sur le plus grand réseau informatique à notre portée: le web. Sans le savoir, vous communiquez avec des serveurs Linux en moyenne 75% du temps lorsque vous surfez 🏄.

Si Microsoft Windows domine le marché des postes de travail, Linux domine le marché des serveurs avec la même vigueur. Vous ne les voyez pas, vous ne saviez peut-être même pas qu'ils existaient, mais sans les serveurs Linux, le web ne serait pas ce qu'il est aujourd'hui.

*Tout les héros ne portent pas de caps, certains ont plutôt des gros processeurs et beaucoup de ram* 😉

### Pourquoi opter pour un serveur Linux ?

1. **Gratuité et ouverture du code:**
    Contrairement à des systèmes d'exploitation propriétaires comme Windows, Linux est totalement gratuit. Cela permet aux entreprises et aux utilisateurs d'éviter des coûts élevés en licences. Quant au code source, il est entièrement ouvert et les entreprises peuvent donc le personnaliser d'un bout à l'autre. En comparaison, c'est comme si vous pouviez changer le caractère et les fonctions du menu démarrer dans Windows. On ne parle pas d'une simple personnalisation, mais d'une réécriture du code comme bon vous semblerait.

2. **Stabilité et fiabilité:**
    Linux est reconnu pour sa stabilité. Il n'est pas rare de repérer des serveurs qui tournent depuis des mois, voire des années sans nécessiter de redémarrage. Au fil des années, Linux a aussi su se faire reconnaitre pour sa capacité à résister à de lourdes charges de travail.

3. **Sécurité renforcée:**

## Ubuntu 24.04 LTS

Ubuntu possède bel et bien une version serveur de son système d'exploitation. Voici quelques caratéristiques de ce système d'exploitation:

- La version serveur d'Ubuntu ne possède aucune interface graphique 😨

- La version LTS (Long Term Support) est supportée par Canonical pendant 5 ans (10 ans avec Ubuntu Pro).

- Il est possible de configurer votre dépôt APT principal lors de l'installation.

- Permet l'utilisation de [LVM (Logical Volume Manager)](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux))

- Un service SSH est disponible dès l'installation.