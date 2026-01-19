---
draft: true
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 20

## Les serveurs d'impression (suite) 🖨️

Au dernier cours, nous avons abordé ensemble les notions relatives aux serveurs d'impression. Nous avons abordé leurs différents composants, tel que les imprimantes physiques, les imprimantes logiques, les pilotes ainsi que la file d'attente. Dans le laboratoire que je vous ai fourni avec le cours, vous deviez faire un changement important dans votre infrastructure, soit celui de mettre en place un serveur de fichiers capable d'exploiter l'authentification d'Active Directory.

## Deux services, un serveur

Dans le cours d'aujourd'hui, vous mettrez en place un service supplémentaire sur votre serveur de fichiers, soit un service d'impression. Nous utiliserons le service [CUPS](https://www.cups.org/) dont nous avons discuté au cours précédent. Nous exploiterons également les logiciels de SAMBA qui sont déjà présents dans notre serveur de fichier.