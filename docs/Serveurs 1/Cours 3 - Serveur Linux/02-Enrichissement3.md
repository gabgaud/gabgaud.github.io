import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';

# Enrichissement

* * *
## Déport d'affichage via SSH
Vous savez désormais qu'Ubuntu Serveur n'offre pas d'interface graphique. Cela dit, il n'est pas rare que certaines applications fonctionnent à l'aide d'une interface graphique. C'est le cas par exemple d'un navigateur web qui a besoin d'une fenêtre pour vous retourner le résultat d'une page web. Il est tout à fait possible d'installer un navigateur web sur votre serveur et d'en déporter l'affichage sur un poste de travail.

## Préalable(s)

- Avoir complété le laboratoire # 3

## Objectif(s)
- Utiliser un navigateur web à distance.

* * *
## Schéma

<ThemedImage
    alt="Schéma"
    sources={{
        light: useBaseUrl('/img/Serveurs1/Laboratoire3_W.svg'),
        dark: useBaseUrl('/img/Serveurs1/Laboratoire3_D.svg'),
    }}
/>

* * *

## Étapes de réalisation

### Modification de la configuration SSH sur Linux

Nous devons apporter quelques modifications à la configuration SSH de votre serveur Linux.