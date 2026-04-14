---
draft: false
---
import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Mise en réseau 🌐

## Introduction

Dans un monde interconnecté, la mise en réseau est au cœur du fonctionnement de nos systèmes informatiques. Comprendre comment les ordinateurs communiquent entre eux est essentiel pour toute personne évoluant dans le domaine des technologies de l’information.

Ce cours propose une introduction aux bases de la communication réseau sous Windows, incluant l’adressage IP, les serveurs DHCP et DNS, et quelques outils de diagnostic simples.

## Qu’est-ce qu’un réseau?

Un **réseau** est un regroupement d’ordinateurs, de périphériques et d’autres appareils interconnectés afin de :

- **Communiquer** (envoyer/recevoir des données)
- **Partager des ressources** (imprimantes, fichiers, connexions Internet)


## La communication réseau ☎️

Le langage utilisé par les ordinateurs pour communiquer est appelé un **protocole de communication**. Le protocole le plus fondamental est **IP (Internet Protocol)**.

Sans un langage commun, les appareils ne peuvent pas se comprendre. IP joue ce rôle de langage universel.

## Le protocole IP

Le protocole IP définit les règles permettant aux appareils de s’identifier et d’échanger de l’information.

Deux versions principales existent :

- **IPv4** : le plus répandu, basé sur des adresses en 4 octets
- **IPv6** : plus moderne, permet davantage d’adresses

> Dans le cadre de ce cours, nous nous concentrerons sur **IPv4** seulement.


## Les conditions pour communiquer sur un réseau IPv4

### Condition 1 — Une adresse IP unique

Chaque appareil sur un réseau doit posséder une **adresse IP unique**.  
Exemple : `192.168.1.100`

⚠️ Si deux machines partagent la même adresse, un **conflit d’adresses** empêchera toute communication correcte.

### Condition 2 — Être sur le même réseau

Pour que deux appareils puissent communiquer, ils doivent appartenir au **même réseau IP**.

Cela est défini par le **masque de sous-réseau**, qui sert à distinguer la partie réseau et la partie hôte d’une adresse IP.

Le réseau possède aussi une **adresse de réseau**, utilisée pour identifier le segment.

### Condition 3 — Utiliser une passerelle pour sortir du réseau

Lorsqu’un ordinateur souhaite joindre un appareil **hors de son réseau**, il doit passer par une **passerelle** (souvent le routeur domestique).

La passerelle agit comme un **intermédiaire entre réseaux**, à l’image d’un échangeur entre deux autoroutes.


## Configuration IP dans Windows

### DHCP : le héros de l’automatisation

Par défaut, Windows obtient son adresse IP via un **serveur DHCP (Dynamic Host Configuration Protocol)**.

Le DHCP permet :

- D’attribuer automatiquement une adresse IP unique
- De transmettre d’autres paramètres essentiels : masque, passerelle, DNS, etc.

## Quand le DHCP est absent : APIPA

Si aucun serveur DHCP ne répond, Windows s’attribue automatiquement une adresse dans le bloc `169.254.0.0/16`.

C’est le protocole **APIPA (Automatic Private IP Addressing)**, spécifique à Windows.

Ces adresses permettent une **communication locale** limitée, mais pas l’accès à Internet.

## Le service DNS 🧠

### Pourquoi le DNS?

Nous, les humains, retenons mieux les **noms** que les **adresses IP**.

> Exemples :
> - `google.com` → `142.251.41.78`
> - `youtube.com` → `172.217.1.14`

Le **DNS (Domain Name System)** se charge de faire la traduction **nom de domaine → adresse IP**.

> Votre routeur joue souvent ce rôle, mais il existe aussi des serveurs DNS publics comme ceux de Google (`8.8.8.8`).

## Outils de diagnostic réseau 🔧

### La commande `ping`

Permet de tester la **connectivité réseau** vers un hôte :

```bash
ping google.com
ping 192.168.1.1
```

> Attention : certains sites bloquent volontairement les pings.

### La commande `nslookup`

Permet d’interroger un serveur DNS pour vérifier la résolution de noms :

```bash
nslookup github.com
```

- Affiche l’adresse IP correspondante
- Permet d’identifier le serveur DNS utilisé

## En cas de problème réseau : que vérifier?

Voici quelques pistes de diagnostic :

1. **Adresse IP et masque** :
   - Est-ce une adresse valide?
   - Est-ce une adresse APIPA?

2. **Passerelle** :
   - Peut-on la joindre avec `ping`?
   - Est-elle dans le bon sous-réseau?

3. **Serveur DNS** :
   - Répond-il au `ping`?
   - La résolution de nom fonctionne-t-elle?


## Conclusion

La mise en réseau est un pilier fondamental de toute infrastructure informatique.  
Comprendre l’adressage IP, les rôles du DHCP et du DNS, ainsi que quelques outils de base comme `ping` et `nslookup`, permet déjà de résoudre une bonne partie des problèmes courants.

