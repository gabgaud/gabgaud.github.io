# Cours 3

## Les serveurs Linux <FAIcon icon="fa-brands fa-linux" size="1x"/>

*« Pourquoi parle-t-on de Linux en classe Monsieur ? Personne n'utilise Linux »<br/>-Les étudiants*

Cette phrase, j'ai dû l'entendre des dizaines de fois depuis que j'enseigne l'informatique. Je l'ai entendu, elle, et toutes ses dérivées. Malheureusement elle est mal fondée. La plupart des étudiants qui me disent cela se fit uniquement à ce qu'il voit. Chez eux, chez leurs amis, la plupart des ordinateurs qu'ils croisent fonctionnent sous Windows ou Mac. Basé sur ce qu'ils voient, leur réflexion est légitime: Pourquoi apprendre Linux alors que le marché semble vide de toute présence de Linux ?

### Les héros de l'ombre

<u>En 2024, 70% à 80% des serveurs web dans le monde utilisent un système basé sur Linux.</u> Vous avez bien lu! Aujourd'hui l'accès au web est devenu un service essentiel. Tous les jours, vous utilisez des services sur le plus grand réseau informatique à notre portée: le web. Sans le savoir, vous communiquez avec des serveurs Linux en moyenne 75% du temps lorsque vous surfez 🏄.

Si Microsoft Windows domine le marché des postes de travail, Linux domine le marché des serveurs avec la même vigueur. Vous ne les voyez pas, vous ne saviez peut-être même pas qu'ils existaient, mais sans les serveurs Linux, le web ne serait pas ce qu'il est aujourd'hui.

*Tout les héros ne portent pas de caps, certains ne font qu'utiliser Linux.* 😉

### Pourquoi opter pour un serveur Linux ?

1. **Gratuité et ouverture du code:**
    Contrairement à des systèmes d'exploitation propriétaires comme Windows, Linux est totalement gratuit. Cela permet aux entreprises et aux utilisateurs d'éviter des coûts élevés en licences. Quant au code source, il est entièrement ouvert et les entreprises peuvent donc le personnaliser d'un bout à l'autre. En comparaison, c'est comme si vous pouviez changer le caractère et les fonctions du menu démarrer dans Windows. On ne parle pas d'une simple personnalisation, mais d'une réécriture du code comme bon vous semblerait.

2. **Stabilité et fiabilité:**
    Linux est reconnu pour sa stabilité. Il n'est pas rare de repérer des serveurs qui tournent depuis des mois, voire des années sans nécessiter de redémarrage. Au fil des années, Linux a aussi su se faire reconnaitre pour sa capacité à résister à de lourdes charges de travail.

3. **Sécurité renforcée:**
    Bien qu'il ne soit pas invulnérable, les systèmes Linux ont tendance à être moins ciblé par les attaques de malware. De plus, la communauté Linux étant composé de spécialistes informatiques en tout genre ayant un accès au code source du système, les mises à jour de sécurité sont fréquentes et laissent peu de place aux vulnérabilités.

4. **Performances:**
    Linux est passé maître dans l'optimisation de ses ressources avec une gestion efficace de la mémoire et du processeur. Cela permet de faire tourner des services avec des exigences minimales tout en offrant d'excellentes performances.

5. **Grande communauté et documentation abondante:**
    Le code ouvert de Linux a créé un effet très intéressant: une collaboration entre utilisateurs tout autour du globe. Dès qu'un bogue est repéré, les *linuxiens* de la planète collabore entre eux pour corriger le code à la source du problème. La documentation en ligne est donc très abondante et couvre la grande majorité des sujets. Le tout, gratuitement.

## Ubuntu <FAIcon icon="fa-brands fa-ubuntu" size="1x"/>

Ubuntu est sans contredit l'une des versions les plus populaires sur les serveurs Linux. Selon W3Techs, environ 30% des serveurs web sous Linux utilisent Ubuntu. L'entreprise Canonical, quant à eux, estiment que près de 40% des entreprises qui utilisent des solutions cloud choisissent Ubuntu en raison de stabilité et de sa compatibilité.

*\*\*\* En classe, nous utiliserons la version [24.04 LTS d'Ubuntu Serveur](https://ubuntu.com/download/server) \*\*\**

Voici quelques caractéristiques de la version serveur d'Ubuntu:

- Elle ne possède aucune interface graphique 😨

- La version LTS (Long Term Support) est supportée par Canonical pendant 5 ans (10 ans avec Ubuntu Pro).

- Il est possible de configurer votre dépôt APT principal lors de l'installation.

- Permet l'utilisation de [LVM (Logical Volume Manager)](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux))

- Un service SSH est disponible dès l'installation.

### Configuration du réseau <FAIcon icon="fa-solid fa-network-wired" size="1x"/>

La configuration du réseau pour Ubuntu Server se fait via deux méthodes:

- **À l'installation**<br/>
Vous serez amené à compléter des champs dans un formulaire. C'est la méthode la plus simple, mais elle vient avec beaucoup d'inconvénients. Pour commencer, elle nécessite que vous installiez le système, ce qui n'est pas toujours le cas. Ensuite, vous ne pourrez plus changer votre configuration IP par la suite, à moins d'utiliser la seconde méthode de configuration, soit *Netplan*.

- **Avec Netplan**<br/>
Netplan est le gestionnaire de réseau par défaut de la version serveur d'Ubuntu. Ce dernier utilise des fichiers de configurations YAML pour fonctionner. Les fichiers YAML ne sont en fait que des fichiers textes devant respecter une structure particulière pour être interprété par le serveur. La configuration par défaut du serveur se situe dans le fichier `/etc/netplan/50-cloud-init.yaml`. Elle devrait ressembler à ceci:

    ```bash
    # This file is generated from information provided by te datasource. Changes
    # to it will not persist across an instance reboot. To disable cloud-init's
    # network configuration capabilities, write a file
    # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
    # network: {config: disabled}
    network:
        ethernets:
            ens192:
                dhcp4: true
        version: 2
    ```
    :::danger
    Ne modifiez pas ce fichier! Celui-ci constitue votre porte de secours dans le cas où vous bousilleriez votre configuration réseau.
    :::

#### Créer votre config YAML
Les fichiers YAML qui sont dans `/etc/netplan` sont appliqués en ordre de priorité, c'est pourquoi les fichiers débutent généralement par un numéro. Un fichier dont le nom débute par le chiffre 10 sera donc appliqué avant un fichier dont le nom commence par le chiffre 50. C'est une information dont il faut tenir compte surtout si les fichiers modifient la même interface réseau.

:::note
Le fichier par
:::