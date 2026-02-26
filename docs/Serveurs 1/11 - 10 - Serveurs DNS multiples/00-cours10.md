---
draft: false
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 10

## Retour sur différents concepts

- Un serveur DNS a pour objectif de traduire des noms de domaine en adresse IP et des adresses IP en noms de domaine.

- Il réalise cet exploit grâce aux enregistrements qu'il possède ou en transférant la requête vers d'autres serveurs DNS qui finiront par obtenir une réponse.

- Les enregistrements du serveur DNS sont stockés dans des zones de recherches. Ces zones constituent des base de données.

## Le service DNS est critique!

Le service de résolution de nom DNS est crucial. Sans ce service, l'accès internet d'une entreprise ou même ses différents services d'administration pourraient ne plus fonctionner convenablement. Dans cette optique, on mettra souvent plus d'un serveur DNS en place au sein du réseau local afin de profiter d'une redondance du service.

## Gestion de la charge de travail

Ensemble, nous avons abordé les redirecteurs. Pour rappel, il s'agit d'un serveur DNS vers lequel nous pourrons rediriger nos requêtes dans le cas ou notre propre serveur n'y arriverait pas. Sachez qu'il est possible de poser des conditions à nos redirecteurs. En présence de plusieurs serveurs DNS, cela nous permet de gérer le travail de chacun de ceux-ci.

À titre d'exemple, nous pourrions avoir deux serveurs DNS pour les requêtes au nom du domaine local et un serveur de cache DNS pour les requêtes externes:

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/DNS_Multi_W.gif'),
            dark: useBaseUrl('/img/Serveurs1/DNS_Multi_D.gif'),
        }}
    />
</div>

## Hiérarchie primaire-secondaire

Dans l'exemple ci-dessus, deux serveurs gèrent la zone « gabriel.local ». Même si les deux serveurs se partagent le travail de répondre aux requêtes concernant cette zone, un seul est autorisé à effectuer des modifications sur les enregistrements. Il s'agit du serveur primaire.

> *Mais Gabriel, comment le serveur secondaire pourra savoir si un enregistrement est changé dans le serveur primaire ?*
>
> *-Les étudiants*

Bonne question. Le serveur DNS primaire fera ce que l'on nomme des transferts de zone.

## Les transferts de zone

Les transferts de zone peuvent fonctionner de deux façons:

- En étant basé sur le temps.
- En étant basé sur les notifications.

### Basé sur le temps <FAIcon icon="fa-solid fa-clock" size="1x"/>

La valeur « refresh » définit dans l'enregistrement SOA indique aux serveurs secondaires combien de temps ils doivent laisser passer avant de demander au serveur primaire s'il y a eu des modifications sur la zone. Comment ? En vérifiant le numéro de série de leur zone respective.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/Transfert_Zone_Time_Notif_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/Transfert_Zone_Time_Notif_D.svg'),
        }}
    />
</div>

Dans l'exemple présenté ci-dessus, un transfert de zone s'effectuerait du serveur primaire vers le serveur secondaire car le numéro de zone a été incrémenté du côté du serveur primaire.

:::caution
**N'oubliez pas!** Seul le serveur primaire est autorisé à modifier les enregistrements.
:::

### Basé sur les notifications <FAIcon icon="fa-solid fa-bell" size="1x"/>

Il est possible de configurer le serveur DNS primaire pour qu'il avise tous les serveurs secondaires advenant une modification de la zone. Ainsi, en cas de modification des enregistrements, une notification sera envoyée aux serveurs secondaires et ceux-ci pourront alors demander une nouvelle copie de la zone.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/TransfertDeZone_Notifications_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/TransfertDeZone_Notifications_D.svg'),
        }}
    />
</div>

## Sélection du serveur DNS

Lorsque l'on indique plusieurs serveurs DNS à un client, comment ce dernier fait-il pour déterminer quel serveur interroger ? 

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/SelectionDNS_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/SelectionDNS_D.svg'),
        }}
    />
</div>

Pour répondre à cette question, il faut d'abord s'intéresser au système d'exploitation du client.

### Windows <FAIcon icon="fa-brands fa-windows" size="1x"/>

Comme le système d'exploitation Windows est propriétaire, l'algorithme de sélection du DNS est inconnu. Cela dit, on peut présumer que Windows sélectionnera le serveur DNS en fonction du temps de réponse d'une requête ainsi qu'en fonction de la disponibilité du serveur DNS.

### Linux <FAIcon icon="fa-brands fa-linux" size="1x"/>

Sur Linux, l'algorithme de sélection du serveur DNS peut être administré. Il est possible d'indiquer à Linux d'effectuer une rotation entre chaque requête DNS. Cela se traduira donc par un équilibre de la charge de travail entre les différents serveurs. Néanmoins, la configuration d'une telle alternance demeure difficile et pas très intuitive. Il est donc recommandé de conserver le mode « *fallback* » qui est le mode par défaut dans la plupart des systèmes d'exploitation.

## Sécurité des serveurs DNS

Il importe d'aborder convenablement la sécurité des serveurs DNS dans le cadre du cours. Comme il s'agit d'un service essentiel et critique sur le réseau, le service DNS peut être une cible attrayante pour les pirates informatiques. D'ailleurs une seule attaque réussit sur un service DNS peut mener à la corruption de plusieurs serveurs et ordinateurs.

### DNS Hijacking

Le DNS « *hijacking* » est un type d'attaque qui vise les clients, et non les serveurs DNS. À l'aide de différentes méthodes, les attaquants essaieront de mettre en place un faux serveur DNS qui répondra à des requêtes légitimes des clients afin de les rediriger vers des sites frauduleux.

#### Exemple #1 (*Man in the middle*)

Dans cet exemple, le pirate intercepte les requêtes DNS sur le réseau et répond à ces-dernières en prétendant être le serveur DNS interrogé. Ainsi, il peut rediriger un client vers un site web frauduleux comme le site d'une banque traffiqué pour intercepter les identifiants de l'utilisateur.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/DNS_Hijack1_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/DNS_Hijack1_D.svg'),
        }}
    />
</div>

#### Exemple 2 (*Free wifi trap*)

Dans cet exemple, le pirate met en place un point d'accès sans-fil gratuit, attirant ainsi les utilisateurs qui ne se méfient pas. Une fois que les utilisateurs se branchent, il leur fournit l'adresse d'un serveur DNS sous son contrôle. Il peut ainsi, envoyer les utilisateurs vers des sites frauduleux encore une fois.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/Free_Wifi_Trap_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/Free_Wifi_Trap_D.svg'),
        }}
    />
</div>

### DNS Poisonning

Le DNS « poisonning » est un type d'attaque qui vise la mémoire cache des serveurs DNS. À l'aide de différentes méthodes, les attaquants essaieront d'empoisonner la mémoire cache d'un serveur DNS pour que celui-ci puisse, à son tour, répondre faussement aux requêtes DNS légitimes qu'il reçoit. <span class="red-text">Lorsque ce type d'attaque réussit, elle fait plusieurs victimes d'un seul coup.</span>

#### Exemple (*Flooding*)

Dans l'exemple suivant, un ordinateur demande au serveur quelle est l'adresse de `www.mabanque.com`. Comme le serveur ne le sait pas et/ou n'a pas la réponse dans sa mémoire cache, il se tournera vers son redirecteur pour obtenir une réponse. Le pirate envoie une panoplie de réponses au serveur afin de se faire passer pour le redirecteur. Le serveur DNS stocke alors l'adresse dans sa cache et la distribue à tous les ordinateurs qui lui demande.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/DNS_Poison_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/DNS_Poison_D.svg'),
        }}
    />
</div>

## Sécuriser les serveurs DNS

Pour éviter les attaques abordées ci-dessus, plusieurs technologies ont vues le jour.

### DNSSEC

La technologie DNSSEC (*DNS Security Extension*) a été instaurée pour éviter certaines des attaques dont nous avons parlé précédemment. DNSSEC permet de « signer » numériquement les enregistrements DNS d'une zone. Cette façon de procéder empêchera toute tentative de mise à jour ou de modification des enregistrements de la zone sans d'abord y avoir expréssément autorisé.

### Signature des transactions

Les transferts de zones entre les serveurs DNS primaire et secondaire peuvent également être sécurisés grâce à une autre technologie de signature que l'on nomme « *transaction signature* ». Cette dernière technologie n'est pas intégrée à DNSSEC, cependant les deux technologies peuvent être complémentaires.

## Références

 - [Présentation du cours](../Assets/10/10-420-2X5-H26%20(DNS-Serveurs%20multiples).pdf)