import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 14

# Introduction à CEPH dans Proxmox

Pendant longtemps, l'informatique a reposé sur du stockage centralisé : les **SAN** (*Storage Area Network*) et les **NAS** (*Network Attached Storage*). Cette approche souffre de trois défauts majeurs :

1. **Coût élevé** : Matériel propriétaire et licences onéreuses.
2. **Point de défaillance unique** : Si le serveur de stockage tombe, TOUT s'arrête.
3. **Manque de flexibilité** : Ajouter de la capacité ou de la performance est coûteux et complexe.

## L'arrivée du stockage défini par logiciel (SDS)

L'idée nouvelle et puissante : **séparer le logiciel du matériel**. Au lieu d'utiliser du matériel propriétaire coûteux, utilisez des serveurs standards avec des disques classiques, et laissez le logiciel gérer le stockage.

C'est là que **Ceph** intervient.

## Qu'est-ce que Ceph ? 🤔

Ceph est un système de stockage distribué et open-source qui répond à trois exigences fondamentales :

- **Aucun point de défaillance unique** : Tout est redondant
- **Massivement scalable** : De quelques serveurs à des milliers
- **Auto-réparateur** : Se répare lui-même en cas de panne

**En pratique :** Ceph prend les disques de plusieurs serveurs standards et les fait fonctionner comme un seul énorme système de stockage résilient.

## Les composants de Ceph

Ceph peut sembler complexe, mais comprendre ses composants simplifie tout. Il y a **<mark>quatre</mark>** briques essentielles :

### OSD (Object Storage Daemon) : Les muscles 💪

Un OSD est un processus qui gère **un disque de stockage**. C'est simple : 1 disque = 1 OSD.

**Rôle de l'OSD :**
- Stocker les données
- Répliquer les données vers les autres OSDs
- Se rétablir après une panne
- Rééquilibrer les données si un OSD tombe

Les OSDs travaillent ensemble. Il n'y en a pas un qui commande les autres. Ils communiquent directement entre eux.

### MON (Monitor) : Le cerveau 🧠

Les Monitors sont les gardiens de la carte du cluster. Ils maintiennent des informations critiques :

- Quels OSDs sont actifs ou en panne
- Où les données doivent être répliquées (la "CRUSH map")
- L'état général du cluster

**Pourquoi plusieurs Monitors ?** Parce qu'un Monitor unique serait un point de défaillance. On déploie toujours un nombre **impair** de Monitors (3 ou 5) qui se surveillent mutuellement et établissent un quorum (la majorité décide)... Ça vous penser à quoi ? 😉

**Le quorum expliqué :**
- Avec 3 Monitors : Si 1 tombe, les 2 restants forment la majorité. Le cluster continue.
- Avec 2 Monitors : Aucun n'est majorité. Le cluster s'arrête.
- **Conclusion :** Vous avez besoin d'au minimum 3 nœuds pour un cluster Ceph fonctionnel...tout comme Proxmox d'ailleurs.

### MGR (Manager) : Le gestionnaire 🥸

Le Manager collecte des statistiques détaillées sur le cluster :
- Performance (IOPS, bande passante)
- Utilisation de la capacité
- État des pools

Il fournit aussi le tableau de bord web que Proxmox utilise pour afficher l'état de Ceph. C'est utile mais pas critique pour le fonctionnement.

### RADOS : La fondation 🧱

RADOS signifie "Reliable Autonomic Distributed Object Store". C'est crucial de bien comprendre ce que c'est.

**Ce que RADOS n'est PAS :**
- Ce n'est pas un système de fichiers (pas de répertoires, de permissions POSIX, etc.)
- Ce n'est pas un classement hiérarchique (pas de dossiers, pas de chemins)
- Ce n'est pas une base de données

**Ce que RADOS est :**
RADOS est un **système de stockage d'objets distribués et autonome**. C'est une couche très basique qui sait faire trois choses seulement :

1. **Stocker des objets** : Chaque objet a un identifiant unique (une clé) et des données
2. **Les répliquer** : Via CRUSH, les OSDs s'arrangent pour que chaque objet existe en plusieurs copies
3. **Se réparer** : Si un OSD tombe, RADOS redistribue automatiquement les données

**Exemple concret :**
Vous avez un disque de VM de 100 GB. Ceph le découpe en 25 000 petits objets de 4 MB. Chaque objet a un identifiant unique comme "vm-100-disk-0-object-0001". RADOS stocke ces 25 000 objets sur les OSDs, les réplique 3 fois, et s'assure qu'ils sont tous là.

**La clé :** RADOS ne sait rien des fichiers, des répertoires, des permissions. C'est un magasin de paires clé-valeur distribué et résilient. C'est tout.

**Couches au-dessus de RADOS :**
D'autres services de Ceph construisent des couches au-dessus de RADOS :

- **RBD (RADOS Block Device)** : Prend les objets RADOS et les présente comme un disque virtuel à une VM
- **CephFS (Ceph File System)** : Prend les objets RADOS et construit un système de fichiers complet dessus

Donc la hiérarchie est :

```
Application (VM)
       ↓
RBD (bloc) / CephFS (fichiers)
       ↓
RADOS (couche de base : stockage d'objets distribués)
       ↓
OSDs (disques physiques qui font le travail réel)
```

**Pourquoi cette abstraction est géniale :**
RADOS gère la distribution, la réplication, la détection de pannes. Les couches au-dessus (RBD, CephFS) n'ont pas besoin de se préoccuper de ça. Elles reçoivent juste un système de stockage fiable et répliqué.

## Comment gérer autant d'objets ? 🤯

Un cluster Ceph peut contenir des millions, voire des milliards d'objets (les morceaux de 4 Mo de vos disques de VM). Si les Moniteurs (MONs) devaient suivre l'emplacement de réplication de chaque petit objet, ils seraient instantanément surchargés.

Ceph résout ce problème en deux étapes:

### Les *Placement Groups* (PGs) 📦

Au lieu de gérer des millions d'objets, Ceph les regroupe dans des boîtes logiques, appelés **Placement Groups (PGs).** À titre de comparatif: imaginez si vous deviez suivre chaque vis d'une quincaillerie... mieux vaut les regrouper en paquet de quelques vis pour vous simplifier la vie.

Le PG devient l'unité de base pour la réplication, l'équilibrage et la récupération. Quand un disque tombe, Ceph déplace les PGs qui s'y trouvaient, pas des millions de petits objets un par un.

**Comment ça marche ?** Ceph prend l'identifiant de l'objet, le "hashe" (transformation mathématique), et détermine ainsi à quel PG il appartient.

### L'algorithme CRUSH

Maintenant que nous avons des PGs (nos "boîtes"), comment le système décide-t-il sur quels disques (OSDs) les placer ?

C'est le rôle de **CRUSH** (Controlled Replication Under Scalable Hashing).

CRUSH est un algorithme qui **calcule dynamiquement** où un PG doit être écrit et lu. Il n'a **pas besoin de consulter une table de métadonnées** (ce qui évite le goulot d'étranglement).

CRUSH utilise simplement deux choses :

    1. L'identifiant du Placement Group.
    2. La CRUSH map (la carte de votre infrastructure).

### Le processus de placement complet

Le flux complet est donc:

`Objet` → `PG` → `OSDs`

    1. Votre VM écrit une donnée. Ceph identifie l'**objet** correspondant (ex: un bloc de 4 Mo).
    2. Un hash de l'ID de l'objet détermine son **Placement Group (PG)**
    3. L'algorithme **CRUSH** prend l'ID de ce PG et la CRUSH map pour calculer sur quels **OSDs** ce PG (et ses 3 copies) doit être placé.

## La réplication pour plus de résilience

### Comment fonctionne la réplication

Quand vous écrivez un fichier de 100 MB sur Ceph :

1.  **Découpage :** Le fichier se divise en petits objets de 4 MB.
2.  **Distribution intelligente :** Chaque objet est assigné à un PG. Ce PG est ensuite écrit sur 3 disques différents (sur des serveurs différents grâce à CRUSH).
3.  **Confirmation :** L'écriture n'est validée que quand les 3 copies existent.

**Résultat :** Vous pouvez perdre 2 disques (ou 2 serveurs entiers, selon la règle CRUSH) sans rien perdre. La 3ème copie subsiste.

### L'équilibre des copies ⚖️

Vous choisissez le nombre de répliques (`size`) selon vos besoins :

  - **Réplication × 2 (`size=2`) :**
      - Espace utilisé : 50% de surcharge.
      - Résilience : Tolère 1 disque/nœud en panne.
      - Usage : Développement, données non critiques.
  - **Réplication × 3 (`size=3`) :**
      - Espace utilisé : 66% de surcharge.
      - Résilience : Tolère 2 disques/nœuds en panne.
      - Usage : **Production, données critiques. C'est la valeur par défaut recommandée.**
  - **Réplication × 4 (`size=4`) :**
      - Espace utilisé : 75% de surcharge.
      - Résilience : Tolère 3 disques/nœuds en panne.
      - Usage : Données ultra-critiques uniquement (rare).

:::caution[La réplication n'est pas une sauvegarde]
Attention : Si vous supprimez un fichier, il disparaît des 3 copies simultanément. Ceph protège contre les pannes **matérielles**, PAS contre les erreurs **humaines** ou les **malwares**.

Vous devez **TOUJOURS** avoir une stratégie de sauvegarde externe, indépendante de Ceph.
:::

### L'alternative à la réplication : L'Erasure Coding (EC) 

La réplication 3x est simple et rapide, mais elle est coûteuse : 1 To de données utilisables consomme 3 To d'espace brut (66% de surcharge).

L'**Erasure Coding (EC)** fonctionne comme un **RAID 5 ou 6 distribué**.

  - **Principe :** Au lieu de copier la donnée 3 fois, Ceph la découpe en "morceaux de données" (Data Chunks) et y ajoute des "morceaux de parité" (Parity Chunks).
  - **Exemple (k=4, m=2) :**
      - `k=4` : La donnée est coupée en 4 morceaux.
      - `m=2` : Ceph calcule 2 morceaux de parité.
      - Ces 6 morceaux sont écrits sur 6 OSDs différents.
      - **Résilience :** Le cluster peut perdre **2** OSDs (peu importe lesquels) et peut toujours reconstruire la donnée originale.
  - **Coût en espace :** Pour 1 To de données, vous n'utilisez que 1.5 To d'espace brut (33% de surcharge, contre 66% pour la réplication).
  - **Inconvénient :** Plus lent en écriture et en récupération (plus de calculs de parité).
  - **Usage idéal :** Parfait pour un pool de **backups** ou d'archivage (via CephFS), où l'économie d'espace est plus importante que la performance pure.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Virtu/CEPH_W.svg'),
            dark: useBaseUrl('/img/Virtu/CEPH_D.svg'),
        }}
    />
</div>

## CEPH + Proxmox = Synergie ♾️

Proxmox intègre Ceph nativement, ce qui crée une synergie puissante :

**1. Hyperconvergence**<br/>
Vos serveurs Proxmox sont à la fois serveurs de calcul (exécutent les VMs) **ET** serveurs de stockage (stockent les disques des VMs). Plus besoin de SAN séparé. Les ressources matérielles sont utilisées efficacement.

**2. Haute disponibilité**<br/>
Si un nœud Proxmox tombe, les VMs qui y tournaient redémarrent automatiquement sur un autre nœud car leurs disques existent sur le cluster Ceph, qui est toujours accessible.

**3. Migration transparente**<br/>
Vous pouvez déplacer une VM d'un nœud à un autre **SANS interruption de service**. Le disque est accessible depuis n'importe quel nœud grâce à Ceph.

**4. Scalabilité simple**<br/>
Besoin de plus de stockage ou de performance ? Ajoutez un disque (OSD) ou un serveur au cluster. Ceph rééquilibre automatiquement.

### Réseaux distincts 🌐

Pour que tout cela fonctionne sans latence, une configuration réseau dédiée est cruciale. Ceph utilise deux réseaux :

1.  **Réseau Public (Public Network) :**

      - **Utilisation :** Trafic d'administration, communication des hyperviseurs avec les MONs, et trafic des VMs.
      - **Exemple :** Le réseau de gestion de Proxmox suffit amplement.

2.  **Réseau Cluster (Cluster Network) :**

      - **Utilisation :** **Exclusivement** pour le trafic interne de Ceph. C'est là que transitent les réplications, le « healing » et les « heartbeats » des OSDs.
      - **Pourquoi ?** Ce trafic est massif et constant. Le séparer garantit que la réplication d'un disque ne va pas ralentir vos VMs.
      - **Requis :** Idéalement 10 Gbps ou plus. (Vous avez bien lu...)
      - **Exemple :** Un réseau dédié, sans passerelle.

### Types de stockage

Ceph propose plusieurs types de stockage. Proxmox en utilise deux principalement :

**1. RBD (RADOS Block Device)**

  * RBD présente un "périphérique bloc" à la VM, exactement comme un disque dur virtuel.
  * **Très performant.**
  * Idéal pour les disques de VMs et conteneurs.
  * C'est celui que vous utiliserez dans 99% des cas.

**2. CephFS (Ceph File System)**

  * CephFS est un système de fichiers distribué compatible POSIX.
  * Utile pour du stockage partagé (ISOs, backups).
  * Accessible par plusieurs VMs/conteneurs en même temps.

## Performances et limitations 

### Ce qui ralentit Ceph

La réplication a un coût. Pour écrire 1 MB :

  - Vous devez écrire 3 MB (3 copies).
  - Le réseau doit supporter ce trafic 3×.
  - Les disques doivent supporter cette charge.

C'est pourquoi la performance réelle est limitée par le composant le plus faible.

### La hiérarchie des performances

  - **NVMe PCIe 4.0 :** 500 000 IOPS, latence \< 0.1ms
  - **SSD SATA :** 80 000 IOPS, latence \~0.5ms
  - **HDD 7200rpm :** 200 IOPS, latence \~5ms
  - **Réseau 10Gbps :** 1 250 MB/s
  - **Réseau 1Gbps :** 125 MB/s

:::tip
Une chaîne n'est forte que de son maillon le plus faible.
Si votre réseau est 1Gbps et vos disques sont des SSD, la performance sera limitée par le réseau (125 MB/s au lieu de 550 MB/s possibles du SSD).
:::

## Point clés à retenir ✅

  - Ceph distribue les données sur plusieurs disques. Si un disque tombe, les données existent ailleurs.
  - La réplication se fait automatiquement. Via CRUSH, sans intervention manuelle.
  - CRUSH décide où placer les données via un algorithme. Pas de serveur central décisionnaire.
  - Rien n'est unique et critique. Monitors, Managers, disques - tout a des sauvegardes.
  - Le quorum des Monitors est essentiel. Vous avez besoin d'au minimum 3 nœuds.
  - La performance dépend du réseau **ET** des disques. Pas juste l'un ou l'autre.
  - **La réplication n'est pas une sauvegarde.** Faites des backups externes.
  - Ceph est complexe, mais Proxmox le simplifie. L'interface web automatise les complexités.

## Pièges à éviter 🚫

<span class="red-text">**Piège 1 : Confondre réplication et sauvegarde**<br/></span>
La réplication protège contre les pannes **matérielles**. La sauvegarde protège contre les erreurs **humaines** et les **attaques**. Vous avez besoin des deux.

<span class="red-text">**Piège 2 : Négliger le réseau**<br/></span>
Ceph est très gourmand en bande passante. Un réseau 1 Gbps tue les performances, même avec des SSD. **Le 10 Gbps est un prérequis** pour le réseau "cluster".

<span class="red-text">**Piège 3 : Moins de 3 nœuds**<br/></span>
Ceph a besoin d'un quorum. Moins de 3 nœuds = pas de quorum = cluster non fonctionnel en production.

<span class="red-text">**Piège 4 : Sous-estimer la RAM**<br/></span>
Chaque OSD consomme de la RAM (1-4 GB selon la charge). Avec 3 OSD par nœud, c'est 6-12 GB juste pour Ceph. Planifiez généreusement.

<span class="red-text">**Piège 5 : Utiliser du matériel hétérogène**<br/></span>
Un cluster Ceph fonctionne mieux quand tous les nœuds sont identiques. Mélanger vieux serveurs et neufs crée des déséquilibres de performance (le cluster ira à la vitesse du plus lent).