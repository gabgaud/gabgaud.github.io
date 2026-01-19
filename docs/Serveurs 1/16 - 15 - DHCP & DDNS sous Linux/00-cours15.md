---
draft: true
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 15

## Automatisation des services

Dans les derniers cours, nous avons exploré ensemble les concepts en lien avec les services DNS, DHCP et même avec Active Directory. En outre, vous avez appris qu'Active Directory facilitait grandemment le déploiement de services DNS grâce à sa gestion des objets dans son annuaire ainsi qu'à sa réplication. Cependant, il n'est pas possible d'offrir des services Active Directory sous Linux, ( *en théorie* 😉) comment peut-on automatiser ces services de base alors ?

## DDNS - Dynamic Domain Name System

Le DDNS est un principe selon lequel on peut mettre à jour les enregistrements d'une zone DNS presqu'en temps réel. Lorsque le serveur DHCP distribue les informations de connexion à un hôte, il en profite pour lui demander son nom d'hôte. Une fois cette information en poche, le serveur DHCP communique avec le serveur DNS primaire pour lui mentionner que l'hôte *patate* vient de recevoir l'adresse IP w.x.y.z. Cette façon de procéder assure des enregistrements constamment à jour.

### Sécuriser DDNS

Le service DDNS implique certaines notions de sécurité. En effet, comme il s'agit de mises à jour d'enregistrements, il pourrait être intéressant pour un pirate de s'attaquer à ce genre de service pour les mêmes raisons évoquées lors du [cours 10](../11%20-%2010%20-%20Serveurs%20DNS%20multiples/00-cours10.md#sécurité-des-serveurs-dns). C'est pourquoi, lors du laboratoire #15, vous utiliserez encore une fois la *transaction signature*, la même technologie avec laquelle nous avons sécurisé nos transferts de zones.