import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Laboratoire 13

## Ajout d'un stockage CephFS pour vos fichiers ISOs et sauvegardes

## Préalables ✅
  - Avoir complété et testé l'infrastructure du laboratoire 12

## Objectifs 🎯
  - Ajouter un stockage CEPH supplémentaire pour vos Sauvegardes (et ISOs)

## Étapes de réalisation 🔢

Lors de votre laboratoire précédent, vous avez mis en place un cluster Proxmox/Ceph, capable de d'étalonner des données en blocs entre plusieurs serveurs. Vous avez pu créer une première machine virtuelle et y stocker son disque dur. Or, qu'en est-il des fichiers ?

À l'heure actuelle, votre cluster Ceph est incapable d'héberger des fichiers pour plusieurs raisons:

    1. Il utilise le stockage `RBD` et non un système de fichiers standard.

    2. `RBD` utilise l'algorithme **CRUSH** pour déterminer où sont stockés les *Placement Groups*.

    3. **CRUSH** est incapable de gérer un grand nombre de métadonnées. Or, les fichiers en ont beaucoup (permissions, date de création, taille, etc.)

Voyons donc comment nous pouvons utiliser Ceph pour accueillir **aussi** des fichiers.

### 1. Création de serveurs de métadonnées

C'est primordial! Comme je l'ai mentionné ci-dessus, **CRUSH** est incapable de gérer toutes les métadonnées qu'utilise un système de fichiers standard tel que *ntfs* par exemple. Il nous faut donc mettre un élément en place qui saura gérer ces métadonnées.

Sélectionnez l'un de vos noeuds Proxmox et dirigez-vous dans le sous-menu `Ceph`, puis sélectionnez `CephFS`. Dans la section *Metadata Servers*, cliques sur `Create`:

![CreateMDS](../Assets/15/CreateMDS.png)

Vous pouvez choisir un *ID* personnalisé si vous le souhaitez, mais je ne vous le recommande pas. Oui, nous mettrons plus d'un *MDS* en place, mais sur différent noeud Proxmox afin d'augmenter la résilience du *cluster*. Ce n'est pas très utile d'avoir plus d'un *MDS* sur un même noeud.

Ensuite créez au moins un autre *MDS* dans un second noeud. Vous pouvez aussi en créer un troisième si vous désirez en avoir un dans chacun de noeuds Proxmox.

### 2. Création du stockage pour les fichiers

Une fois vos serveurs de métadonnées en place, vous aurez accès au bouton `Create CephFS`. Cliquez sur ce-dernier et donnez-lui un nom du type `FilesAndBackups`.

#### 2.1 Le nombre de *Placement Groups*

Dans la même fenêtre, vous aurez la possibilité de déterminer le nombre de *PGs (Placement Groups)*. C'est une valeur importante à ne pas négliger. **Rappelez-vous:** Les *PGs* sont le moyen par lequel Proxmox distribue les données de manière égale à travers tous vos *OSDs (disques)*. Le rôle de l'algorithme **CRUSH** est de déterminer l'ensemble des *OSDs* pour chaque *PG*.

**DONC:**

  - Pas assez de *PGs*:<br/>
  La distribution des données est inégale, et si un *OSD* tombe en panne, le processus de récupération est concentré sur un petit nombre d'*OSDs* restants, ce qui ralentit la reconstruction.

  - Trop de *PGs*:<br/>
  Chaque PG consomme de la mémoire et du CPU sur les moniteurs (*MON*) et les *OSDs*. Un nombre excessif peut dégrader les performances globales et consommer trop de ressources, surtout dans les petits clusters.

>*Oui mais Gabriel, comment peut-on s'assurer d'indiquer le bon nombre alors ?*
>
>*-Les étudiants*

Bonne question! On utilisera une petit formule mathématique pour ça. Les facteurs à considérer sont le nombre total d'*OSDs* ainsi que le nombre de réplicas (par défaut 3). La formule va comme suit:
<br/>
<div style={{textAlign: 'center'}}>
$$\LARGE \text{PGs} = \frac{\text{Nombre total d'OSDs} \times 100}{\text{Nombre de réplicas}}$$
</div>
<br/>
Le résultat doit être arrondi à la puissance de 2 **supérieure** la plus proche.

|Nombre d'*OSDs* total|Réplicas|Calcul|Puissance de 2 supérieure|
|:---------------------:|:--------:|------|:-------------------------:|
|3|3|(3 x 100)/3 = 100|**128**|
|6|3|(6 x 100)/3 = 200|**256**|
|12|3|(12 x 100)/3 = 400|**512**|
|20|3|(20 x 100)/3 = 667|**1024**|

:::tip
On a 6 *OSDs* au total dans notre laboratoire 😊
:::

### 3. Déplacement des fichiers ISOs

Une fois votre nouveau stockage CephFS en place. Il serait intéressant d'y déplacer nos fichiers *ISOs*. Si vous avez utilisé le modèle de Proxmox que je vous ai fourni, vos noeuds possèdent tous respectivement une copie des *ISOs*, ce qui n'est vraiment pas optimal.

Les *ISOs* sont accessible via `/var/lib/vz/template/iso` depuis le shell Proxmox. Votre stockage CephFS, quant à lui, se trouve dans `/mnt/pve/[NomDuStockage]`. Pour que Proxmox puisse détecter les *ISOs* convenablement, vous devez absolument les mettre dans les sous-dossiers `/template/iso`.

Déplacez donc vos *ISOs* dans votre stockage CephFS. Une fois que ce sera fait, supprimer les *ISOs* dans les stockages `local` de votre autres noeuds.