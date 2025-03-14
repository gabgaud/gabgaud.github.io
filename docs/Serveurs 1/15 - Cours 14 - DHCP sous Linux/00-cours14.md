import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 14

## Similarités et différences

Les principes du DHCP restent exactement les mêmes, peu importe le système d'exploitation. Tout comme dans le cas du service DNS, ce qui changera, ce sera la méthode de configuration. Sous Linux, vous n'aurez pas le luxe de l'interface graphique, mais ça, vous le saviez déjà 😉

## DHCP avec KEA

KEA DHCP est le service que nous utiliserons pour notre serveur sous Ubuntu. L'une des particularités intéressantes de KEA, c'est que sa configuration est stocké dans un fichier JSON. Dans un fichier JSON, il est possible de décrire des objets ainsi que leurs propriétés. C'est un type de fichier que l'on utilise particulièrement dans les scripts et la programmation. Vous en apprendrez davantage à ce sujet lors de cours « 420-3T5 Automatisation de tâches ».

### Installation

L'installation de KEA se fait via le gestionnaire de paquet `APT` en utilisant la commande suivante:

```bash
sudo apt install kea-dhcp4-server -y
```

### Configuration via JSON

La configuration du serveur DHCP KEA sous Linux passe par la mise en place d'un fichier JSON. Ce format de fichier est souvent utilisé dans le cadre de langage de programmation orienté objet. En effet il permet, grâce à sa syntaxe minutieuse de décrire différents objets et attributs. Néanmoins, la syntaxe de JSON n'est pas parfaite. Elle comporte énormément de ponctuation et ne prend pas en compte les commentaires. Il vous faudra donc être rigoureux lors de votre configuration.

Exemple de syntaxe JSON:
```json
    "subnet4": [
        {
            "subnet": "192.168.14.0/24",
            "pools": [ { "pool": "192.168.14.100 - 192.168.14.120" } ],
            "option-data": [
                {
                    "name": "domain-name-servers",
                    "data": "192.168.14.201"
                },
                {
                    "name": "domain-search",
                    "data": "it-connect.local"
                },
                {
                    "name": "routers",
                    "data": "192.168.14.2"
                }
            ]
        }
    ]
```