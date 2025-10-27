import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Laboratoire 14

# Installation d'un premier hyperviseur ESXi

* * *

## Préalables ✅
  - Aucun

## Objectifs 🎯
  - Mettre en place un hyperviseur ESXi
  - Découvrir l'interface de gestion basique
  - Installer une première machine virtuelle

## Étapes de réalisation 🔢

Afin d'éviter tout conflit avec les machines virtuelles de vos collègues, faites ce laboratoire derrière une passerelle tel que nous avons procédé dans les laboratoires précédents.

### Création d'une machine virtuelle dans Labinfo

Dans LabInfo, créez une machine virtuelle avec les spécifications suivantes:

    - **CPU:** 4 (Coeurs par socket: 4, Activez la virtualisation matérielle)
    - **Mémoire:** 16Go
    - **Disque 1:** 120Go (installer ESXi sur ce disque)
    - **Disque 2:** 250Go
    - **Réseau:** *Derrière votre passerelle*
    - **CD/DVD:** VMware-VMvisor-Installer-8.0U3e-24677879.x86_64.iso

### Installation

L'installation démarrera automatiquement à l'alimentation de la VM. Suivez les étapes de l'installation.

Vous aurez un avertissement concernant le *CPU*. Les serveurs de LabInfo sont relativement vieux et les *CPUs* qui s'y trouvent ne sont pas supportés dans les nouvelles versions d'ESXi. En production, nous devrions prendre cet avertissement au sérieux, mais comme il ne s'agit que d'un laboratoire, nous pouvons l'ignorer.

![ErreurCPU](../Assets/16/ErreurCPU.png)

### Configuration initiale

Une fois l'installation d'ESXi terminée, vous aurez un écran semblable à celui-ci:

![Bootup](../Assets/16/Bootup.png)

Sur un client du même réseau, ouvrez un navigateur web et entrez l'adresse IP du serveur ESXi. Vous devrez évidemment vous identifier avant d'atteindre l'interface de gestion basique d'ESXi:

![WebGUI](../Assets/16/WebGUI.png)

Prenez le temps d'explorer l'interface et repérez les éléments suivants:

- Où pouvez-vous modifier l'adresse IP de l'hôte ESXi dans <u>**l'interface Web**</u> ? Une fois que vous aurez repéré cette information, définissez une adresse IP statique à votre hyperviseur.

- Où pouvez-vous modifier le *hostname* de votre hôte ESXi dans <u>**l'interface Web**</u> ? Une fois que vous aurez repéré cette information, donnez un nom d'hôte cohérent à votre serveur ESXi. Ex: *ESXi.votreprenom.local*

### Création d'une première banque de données

Dans le menu de stockage, créez une nouvelle banque de données sur votre disque dur de 250Go que vous nommerez `DataStore` tout simplement. Une fois cette banque de données créée, trouvez comment:

- Créer un répertoire nommé `ISOs`.
- Déposer un fichier iso de Windows 10.

### Création d'une première machine virtuelle

À l'aide de l'ISO que vous avez stocké sur votre hyperviseur. Créez une machine virtuelle pour y installer Windows 10.

