import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';

# Laboratoire 6
* * *
## Configuration de pare-feu

## Préalable(s)

- Avoir complété le laboratoire # 4

## Objectif(s)
- Octroyer un accès SSH au serveur Ubuntu **seulement** au poste de travail Windows 10.
- Octroyer un accès SSH au serveur Windows **seulement** au poste de travail Windows 10.

* * *
## Schéma

<ThemedImage
    alt="Schéma"
    sources={{
        light: useBaseUrl('/img/Serveurs1/Laboratoire6_W.svg'),
        dark: useBaseUrl('/img/Serveurs1/Laboratoire6_D.svg'),
    }}
/>

* * *

## Étapes de réalisation

Dans ce laboratoire, nous prendrons pour acquis le poste de travail sous Windows 10 est celui de l'administrateur des serveurs. Ce poste de travail <mark>doit posséder une adresse IP fixe.</mark>

À titre d'exemple, voici les adresses IP que j'utiliserai pour mes exemples dans le cadre de ce laboratoire:

| Machine | Adresse IPv4 |
|:---------:|:--------------:|
| Windows Serveur 2022 | 192.168.21.20 |
| Ubuntu Serveur 24.04 LTS | 192.168.21.10 |
| Windows 10 | 192.168.21.110 (statique) |