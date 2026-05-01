---
draft: false
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 23

Il n'est pas rare, dans différents contextes de réseau, que vous vous retrouviez en situation de débogage. D'ailleurs, régler des problèmes de réseau sera fort probablement une grande partie de votre travail. Ceci étant dit, il est important d'effectuer des vérifications dans un ordre logique pour arriver à mettre le doigt sur ce qui ne fonctionne pas.
Ce cours vise à vous inculquer une logique de travail. Au fil du temps, à travers l'avancement de votre carrière, vous vous approprierez votre propre logique de travail. Pour l'instant, je vous recommande de suivre ces schémas.

:::caution
L'erreur la plus commune lorsqu'on parle de débogage en réseau est de **<u>prendre les choses pour acquises</u>**. Exemple: « Nul besoin de vérifier ma configuration IP, je suis certain qu'elle est bonne. »

Ne prenez rien pour acquis lorsque vous êtes en débogage. Prenez le temps de tout revérifier.
:::

## Débogage sur un client

Il existe une panoplie d'éléments qui peuvent faire en sorte qu'un client, comme un pc, n'arrive pas à rejoindre internet ou même le réseau interne. Le schéma ci-dessous vous offre une procédure à suivre qui vous permettra d'éliminer une grande majorité des causes probables d'un tel problème. Analysez-le et **surtout**: <span class='red-text'>NE SAUTEZ PAS D'ÉTAPE!</span>

:::tip[Pour une meilleure lisibilité]
Pour observer le schéma de manière efficace, je vous suggère de mettre le site en thème claire (en haut du site à droite 🌙). Ensuite, faite un clic à l'aide du bouton de droite de la souris et sélectionnez *Ouvrir l'image dans un nouvel onglet*.
:::

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/SchémaReseau_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/SchémaReseau_D.svg'),
        }}
    />
</div>


## Débogage du service DHCP Kea

À travers les différents cours de **Serveurs 1**, vous avez été en contact à de nombreuses reprises avec le service `DHCP` de Kea. Pour rappel, le dhcp est un service essentiel, voire critique, dans plusieurs réseaux locaux. Alors, comment réagir et que pouvons-nous faire lorsque le serveur `DHCP` ne semble pas fonctionner ?

Je vous montre ici la procédure à suivre avec Kea. Néanmoins, vous pouvez très bien adapté ce schéma à un service DHCP sous Windows. Encore une fois: <span class='red-text'>NE SAUTEZ PAS D'ÉTAPE!</span>

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/SchemaKeaDHCP_W.svg'),
            dark: useBaseUrl('/img/Serveurs1/SchemaKeaDHCP_D.svg'),
        }}
    />
</div>

:::tip[Augmenter la journalisation dans Kea]
Pour vérifier la bonne réception des requêtes *Discover* et l'envoi des requêtes *Offer* sur Kea, vous devrez augmenter le niveau de journalisation du service Kea-DHCP4. Pour ce faire, ajoutez cette section après le bloc *lease-database* dans votre fichier `kea-dhcp4.conf`:

```json
"loggers": [{
  "name": "kea-dhcp4",
  "output_options": [{
    "output": "stdout"
  }],
  "severity": "DEBUG",
  "debuglevel": 99
}]

```
:::