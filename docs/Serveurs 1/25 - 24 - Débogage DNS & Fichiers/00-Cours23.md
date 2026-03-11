---
draft: true
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 23

Tout comme nous avons procédé dans le dernier cours pour les problèmes liés au réseau sur les clients ainsi que les problématiques en lien avec le service DHCP, nous analyserons encore aujourd'hui, des schémas qui vous aideront dans la résolution de différents problèmes.

## Débogage du service DNS

Vous êtes bien aux faits que le service DNS est devenu est essentielle pour que nous puissions naviguer sur le réseau interne et externe aisément. De plus, le service DNS est prérequis dans certaines circonstances, notamment lorsque nous parlons de mettre un domaine *Active Directory* en place.

:::caution
Le schéma que je vous présente ici ne prend pas en compte les configurations avancées telles que les configurations de serveurs DNS multiples ou les transferts de zones. J'ai tenté de conserver une certaine simplicité dans le schéma car autrement, ce-dernier aurait pu prendre des proportions complètement démesurées.
:::

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/SchemaDNS_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/SchemaDNS_D.svg'),
        }}
    />
</div>

## Débogage du serveur de fichiers

Le serveur de fichiers peut paraître simple *a priori*, mais comme nous l'avons vu en classe, sa configuration peut rapidement prendre des allures plus complexes. Vous trouverez donc ici le schéma à suivre si vous rencontrez une impasse avec le serveur de fichiers Samba. Ne vous laissez pas impressionner par la taille du schéma, il comprend deux contextes distincts: le serveur samba en mode autonome et le serveur samba au sein d'une infrastructure *Active Directory*.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/SchemaSamba_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/SchemaSamba_D.svg'),
        }}
    />
</div>