---
draft: false
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Laboratoire 15
* * *

## Mise en place d'un serveur DHCP avec Linux

## Préalable(s)

- Avoir complété le laboratoire # 13
- Lire la page [« Cours 15 »](../16%20-%2015%20-%20DHCP%20sous%20Linux/00-cours15.md) du site du cours


## Objectif(s)
- Déployer un premier serveur DHCP sous Linux

* * *
## Schéma

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/Laboratoire14_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/Laboratoire14_D.svg'),
        }}
    />
</div>

* * *

## Étapes de réalisation

Pour compléter ce laboratoire, vous devez obligatoirement utiliser une passerelle qui n'offre pas de service DHCP, puisque nous en mettrons un en place. Vous pouvez réutiliser la passerelle que vous avez utiliser dans les laboratoires 11 & 12 sans problème. Une fois votre passerelle bien en place, concentrons-nous sur notre serveur Linux.

## Mise en place du serveur

Utilisez le modèle de machine virtuelle sous Ubuntu Serveur 24.04 mis à votre disposition pour éviter l'installation complète du serveur. Une fois la machine fonctionnelle, **vous devrez évidemment vous configurer une adresse IP manuellement puisqu'au serveur DHCP ne fonctionne sur le réseau.** Configurez donc l'adresse <mark> 192.168.21.30 </mark>sur votre serveur.

## Installation et configuration du DHCP

Nous y voici. Lors des prochaines étapes, nous allons mettre en place notre service DHCP.

### Téléchargement des paquets

Lancez la commande suivante pour amorcer le téléchargement des paquets:

```bash
sudo apt install kea-dhcp4-server -y
```

Une fois les paquets nécessaires téléchargés et installés, votre service devrait démarré automatiquement. Vous pouvez valider cela en entrant la commande suivante:

```bash
sudo systemctl status kea-dhcp4-server.service
```

### Configuration du serveur DHCP

Le fichier de configuration initial du service DHCP comporte beaucoup d'informations dont nous n'aurons pas besoin. Nous allons repartir depuis un fichier vide. Renommez donc le fichier initial comme suit:

```bash
sudo mv /etc/kea/kea-dhcp4.conf /etc/kea/kea-dhcp4.conf.bkp
```

Créez un nouveau fichier de configuration avec votre éditeur de texte préféré.

:::tip
VIM supporte la syntaxe des fichiers JSON. Ça peut être très utile dans notre cas 😉. Pour activer la colorisation de la syntaxe, vous aurez deux commandes à entrer dans VIM:
1. :syntax on
2. :set filetype=json

Si vous avez besoin de rappel concernant VIM, consultez [cette section.](../06%20-%20Cours%205%20-%20Quiz,%20Vim%20et%20temps%20de%20complétion/00-cours5.md)
:::

```bash
sudo vim /etc/kea/kea-dhcp4.conf
```

Voici le contenu qu'il vous faut inscrire dans le fichier que vous venez de créer. Je vous explique par la suite chacune des lignes:

```json title='/etc/kea/kea-dhcp4.conf' showLineNumbers
{
 "Dhcp4": {

    "interfaces-config": {
        "interfaces": [ "ens192" ]
    },

    "valid-lifetime": 259200,
    "renew-timer": 129600,
    "rebind-timer": 220320,
    "authoritative": true,

    "lease-database": {
        "type": "memfile",
        "persist": true,
        "name": "/var/lib/kea/kea-leases4.csv",
        "lfc-interval": 3600
    },
            "subnet4": [
            {
                "subnet": "192.168.21.0/24",
                "pools": [ { "pool": "192.168.21.100 - 192.168.21.200" } ],
                "option-data": [
                    {
                        "name": "routers",
                        "data": "192.168.21.1"
                    },
                    {
                        "name": "domain-name-servers",
                        "data": "192.168.21.1"
                    },
                    {
                        "name": "domain-search",
                        "data": "gabriel.local"
                    }
                ]
            }
        ]
    }
}
```

Le fichier contient beaucoup d'éléments certes, mais il contient surtout beaucoup de ponctuation, soyez donc très vigilants! Décortiquons l'ensemble des informations présentées ici ensemble.

La syntaxe du fichier JSON demande à ce que tout soit entre accolades, c'est pourquoi nous retrouvons une accolade ouvrante dès la première ligne. Après quoi, nous retrouvons la déclaration d'un bloc nommé `"Dhcp4"` qui contiendra toute l'information relative à la configuration de notre service. Les deux accolades ouvertes ici sont refermées à la toute fin du fichier:

```json
{
    "Dhcp4": {
        ...
        ...
        ...
        ...
    }
}
```

La portion `"interfaces-config"` vous permettra de définir sur quelle(s) interface(s) vous désirez que le service DHCP soit actif. **Vous devez inscrire le nom de votre propre interface** et non le nom de mon interface 😉.

```json
...
    "interfaces-config": {
        "interfaces": [ "ens192" ]
    },
...
```

Ensuite, viennent les informations concernant les baux DHCP:

- **valid-lifetime:**<br/>
Il s'agit de la durée du bail, définit en secondes.

- **renew-timer:**<br/>
Il s'agit du temps, en secondes, que le client attendra avant d'entamer son processus de renouvèlement du bail. (généralement, 50% de la durée du bail.)

- **rebind-timer:**<br/>
Définit le moment où le client débute un processus de réengagement avec n'importe quel serveur DHCP. En d'autres mots, si le client n'arrive pas à renouveler son bail, il cherchera à communiquer avec n'importe quel serveur DHCP afin d'éviter de perdre sa connexion. (Cette valeur doit être définit au moins à 85% de la durée du bail.)

- **Authoritative:**<br/>
Précise qu'il s'agit du serveur DHCP principal sur le réseau.

**Exemple de bail:**
- Bail de **3 jours** (valid-lifetime à **259 200** secondes).
- Renouvèlement à **50%** (renew-timer à **129 600** secondes).
- Cherche un autre serveur à **90%** (rebind-timer à **233 280** secondes).

```json
...
    "valid-lifetime": 259200,
    "renew-timer": 129600,
    "rebind-timer": 220320,
    "authoritative": true,
...
```

La section suivante concerne la méthode avec laquelle nous allons conserver les baux DHCP:

```json
...
    "lease-database": {
        "type": "memfile",
        "persist": true,
        "name": "/var/lib/kea/kea-leases4.csv",
        "lfc-interval": 3600
    },
...
```

La base de données des baux DHCP sera stocké en mémoire et non pas dans une base de données (`"type": "memfile"`). Néanmoins, celle-ci sera tout de même persistante (`"persist": true`), c'est-à-dire que les baux ne seront pas perdus en cas de redémarrage du serveur car les données seront conservées dans le fichier */var/lib/kea/kea-leases4.csv* (`"name": "/var/lib/kea/kea-leases4.csv"`). Finalement, un nettoyage de ce fichier se fera toutes les heures (`"lfc-interval": 3600`) par le processur LFC (*Lease File Cleanup*).

Vous l'aurez sans doute deviné, il ne nous reste plus qu'à déclarer notre étendue DHCP:

```json
...
    ...
            "subnet4": [
            {
                "subnet": "192.168.21.0/24",
                "pools": [ { "pool": "192.168.21.100 - 192.168.21.200" } ],
                "option-data": [
                    {
                        "name": "routeurs",
                        "data": "192.168.21.1"
                    },
                    {
                        "name": "domain-name-servers",
                        "data": "192.168.21.1"
                    },
                    {
                        "name": "domain-search",
                        "data": "gabriel.local"
                    }
                ]
            }
        ]
    ...
...
```

Le bloc *Subnet4* (`"subnet4":`) permet de déclarer les étendues que devra gérer le serveur DHCP. Pour chaque étendue déclarée (`"subnet": "192.168.21.0/24"`), il vous faudra définir les ou le bassin d'adresses disponibles (`"pools": [ { "pool": "192.168.21.100 - 192.168.21.200" } ]`).

Enfin, vous serez amené à configurer les options à fournir à vos clients (`"option-data": [...]`) (passerelle, DNS, etc...).

Une fois vos configurations en place, redémarrez votre service DHCP à l'aide de la commande suivante:

```bash
sudo systemctl restart kea-dhcp4-server.service
```

## Déploiement des clients

Déployez vos deux clients sous Windows 10 en vous référant au schéma du laboratoire. Vous devriez recevoir les informations nécessaires à votre adressage IP automatiquement.