import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 16

# Introduction à la virtualisation VMware

* * *

## Vue d'ensemble : VMware versus Proxmox

**<span class="fonttaller">Rappel Proxmox (Ce que vous connaissez déjà)</span>**

Avec Proxmox, vous avez travaillé avec une solution **tout-en-un**:

- Interface web unique
- Gestion de *VMs* et de conteneurs
- Clustering intégré
- Stockage distribué (Ceph)
- Sauvegarde incluse
- Solution *open-source* 🥳

**<span class="fonttaller">L'approche VMware : la modularité 🧩</span>**

VMware fonctionne différemment avec une approche **modulaire et stratifiée (par couche):**

- Plusieurs produits spécialisés
- Architecture en couches (hyperviseur + gestion + services)
- Chaque produit à un rôle précis (et un coût 😒...)
- Écosystème propriétaire avec licences distinctes 💰

On pourrait voir Proxmox comme un petit couteau suisse. Il comporte plusieurs outils pratiques et nous permet de se débrouiller très très bien. VMware est plutôt comme une véritable boîte à outils professionnelle. Chaque outil excelle dans sa fonction, mais c'est un peu plus lourd comme infrastructure à mettre en place.

## L'Hyperviseur : ESXi (la fondation) 🧱

### Qu'est-ce que ESXI ?

C'est l'hyperviseur de type 1 (*bare-metal*) de VMware. C'est l'équivalent de l'hyperviseur intégré dans Proxmox (*KVM*).

**<span class="fonttaller">Caractéristiques clés:</span>**

- S'installe directement sur le serveur physique
- Interface web minimale
- Empreinte très légère (~300 MO)
- Gère les ressources matérielles (CPU,RAM,disques,réseau)
- Exécute les machines virtuelles

### Comparaison avec Proxmox

|Aspect|Proxmox|ESXi|
|------|-------|----|
|Base Linux|Oui (Debian)|Non (VMkernel propriétaire)|
|Conteneurs|Oui (LXC)|Non (VM seulement)|
|Gestion locale|Interface web complète|Interface basique|
|Clustering|Intégré|Nécessite vCenter 💵💵💵|

### Quand utiliser ESXi seul ?

- Laboratoire personnel: Pour vous amuser: *homelab, tests, etc*
- Petit environnement: 1-3 serveurs sans besoin de gestion centralisé
- Apprentissage: Comprendre la base avant d'utiliser vCenter

:::caution[Limitations importantes]
ESXi seul ne permet PAS le clustering, la migration à chaud (vMotion), ou la haute disponibilité. Pour ces fonctionnalités, vous avez besoin de vCenter. Tous ces beaux produits sont évidemment payants.
:::

## Le gestionnaire centralisé : vCenter Server 📊

### Qu'est-ce que vCenter

**vCenter Server** est le cerveau de l'infrastructure VMware. C'est la plateforme de gestion centralisée qui orchestre plusieurs hôtes ESXi. C'est un peu comme le cluster manager de Proxmox, mais bien plus puissant et séparé de l'hyperviseur.

### Architecture de déploiement

vCenter peut être déployé de deux façons:

1. **vCSA (vCenter Server Appliance)** - Recommandé
    - VM préconfigurée sous Linux (Photon OS)
    - Déploiement rapide (format OVA)
    - Base de données PostgreSQL intégrée
    - Pas de Windows requis


2. **vCenter sur Windows** - Déprécié
    - Installation sur Windows Serveur
    - Nécessite SQL Server ou Oracle
    - Plus complexe à maintenir
    - En voie de disparition

### Fonctionnalités principales de vCenter

**<span class="fonttaller green-text">Gestion centralisée</span>**

- **Interface unique** pour gérer des dizaines ou centaines d'hôtes ESXi
- **Inventaire hiérarchique** : Datacenter → Cluster → Hôte → VM
- **Recherche globale**: Trouver n'importe quelle ressource rapidement
- **Gestion par lots**: Opérations sur plusieurs *VMs* simultanément

**<span class="fonttaller green-text">Clustering et Haute-Disponibilité</span>**

- **vSphere HA**: Redémarrage automatique des *VMs* en cas de panne d'hôte
- **vSphere DRS**: Distribution automatique des la charge entre les hôtes
- **vMotion**: Migration à chaud des *VMs* sans interruption
- **Storage vMotion**: Migration du stockage sans arrêt

**<span class="fonttaller green-text">Fonctionnalités avancées</span>**

- **Templates**: Modèles de VM standardisés
- **Content Library**: Bibilothèque centralisée de *templates* et *ISOs*
- **Rôles et permissions**: Gestion fine des accès (RBAC)
- **Alarmes et monitoring**: Surveillance proactive
- **Update manager**: Gestin des MAJ ESXi

## Le stockage : Comprendre les options 💾

Contrairement à Proxmox qui intègre Ceph, VMware propose plusieurs approches:

**<span class="fonttaller">VMFS (VMware File System)</span>**

- **Type:** Système de fichiers propriétaire de VMware
- **Usage:** Stockage partagé classique (SAN,iSCSI)
- **Particularité:** Clustering des fichiers
- **Comparatif:** Ce serait l'équivalent d'un LVM sur un stockage partagé avec Proxmox

**<span class="fonttaller">NFS</span>**

- **Type:** Protocole standard et connu
- **Usage:** Connexion à des NAS
- **Particularité:** Simple, flexible, *thin provisionning* natif
- **Comparatif:** NFS est utilisable de la même façon avec Proxmox

**<span class="fonttaller">vSAN</span>**

- **Type:** Stockage distribué défini par logiciel
- **Usage:** Aggrégation des disques locaux de plusieurs hôtes
- **Particularité:** Créé un *datastore* partagé à partir de ressources locales
- **Comparatif:** C'est l'équivalent de Ceph!
- **Licence:** vSAN n'est pas inclus dans vCenter... évidemment 💵💵💵
- **Préalables:** 3 hôtes ESXi (comme Ceph)

**<span class="fonttaller">Local Datastore</span>**
- **Type:** Disques locaux sur un hôte ESXi
- **Usage:** VM non critiques, lab, pas de haute disponibilité
- **Limitation:** Pas de vMotion possible (migration)

### Quelle solution de stockage choisir ?

|Scénario|Solution recommandée|Pourquoi|
|--------|--------------------|--------|
|Infrastructure existante avec SAN|VMFS sur SAN|Utilise l'infra. en place. Performant.|
|NAS en place|NFS|Simple économique (mais lent)|
|Infrastructure moderne sans SAN|vSAN|Stockage distribué. Résilient.|
|Lab/Test sur un seul hôte|Local Datastore|Pas de coût additionnel.|

## Quelques produits complémentaires de VMware

### VMware Workstation

Workstation, que vous connaissez bien, fait également partie de la suite des produits de VMware. Il est toujours offert gratuitement (jusqu'à maintenant...). C'est donc un hyperviseur de type 2, que vous installez sur votre poste de travail Windows, Linux ou MacOS (VMware Fusion).

### vSphere Replication

Comme vous vous en doutez surement, il s'agit d'un produit permettant une réplication asynchrone des *VMs* entre différents sites. On utilisera ce produit dans le cadre de plans de reprise après sinistre et la protection des données critiques.

### NSX (Network Virtualization)

Produit permettant de la virtualisation du réseau (SDN). NSX permet entre autre de créer des réseaux virtuels complexes, micro-segmenter, faire du *load balancing* virtuel, etc. On l'utilise généralement dans des grandes entreprises avec des besoins de réseau complexes.

### Suite vRealize

Cette suite comprend plusieurs produits dont:

- vRealize Automation: Portail self-service pour déployer des *VMs*
- vRealize Operations: Monitoring et analytics avancés
- vRealize Log Insight: Gestion centralisée des logs

Cette suite de produits cible particulièrement les entreprises avec des immenses infrastrucutres (1000+ *VMs*).

## Architecture typique VMware ⚒️

### Petit environnement (5-10 serveurs pas plus)

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Virtu/ArchitectureType_W.svg'),
            dark: useBaseUrl('/img/Virtu/ArchitectureType_D.svg'),
        }}
    />
</div>

**<span class="fonttaller green-text">Caractéristiques:</span>**

- vCenter gère tous les hôtes
- Cluster unique pour garder l'infrastructure simple
- HA (Haute-Dispo.) et DRS (Distribution de la charge) activés
- Stockage partagé

### Environnement moderne avec vSAN

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Virtu/ArchitectureTypevSAN_W.svg'),
            dark: useBaseUrl('/img/Virtu/ArchitectureTypevSAN_D.svg'),
        }}
    />
</div>

**<span class="fonttaller green-text">Avantages:</span>**

- Pas de SAN/NAS externe à acheter
- Stockage distribué comme Ceph
- Performance locale + résilience

>*Si vCenter gère les hôtes ESXi, mais que vCenter tourne sur un hôte ESXi, qu'arrive-t-il si cet hôte tombe en panne ?*
>
>*Les étudiants*

**Bonne question!** ⚠️ C'est effectivement un point critique et souvent mal compris! ⚠️ Regardons ensemble ce qui adviendrait en cas de panne du noeud qui contient vCenter.

### Scénario: Panne de l'hôte hébergeant vCenter

**<span class="green-text">Ce qui continue de fonctionner: ✅</span>**

- Les hôtes ESXi fonctionnent de manière autonome
- Toutes les VM en cours d'exécution continuent normalement
- Le vSphere HA du cluster fonctionne ENCORE (les règles HA sont dans la base distribuée)
- Les VM critiques sur l'hôte en panne sont redémarrées automatiquement par HA

**<span class="red-text">Ce qui ne fonctionne plus: ❌</span>**

- Interface de gestion vCenter (inaccessible)
- Impossible de faire des vMotion
- Pas de monitoring centralisé
- Pas de DRS automatique
- **CRITIQUE** : vCenter lui-même ne redémarre PAS automatiquement !

:::danger[Le piège]
**ATTENTION:** vCenter n'est pas protégé par défaut!
:::

## Haute-Disponibilité : Deux concepts à distinguer ♾️

VMware utilise deux fonctionnalités avec des noms similaires mais qui **sont complètement différentes!**

### vSphere HA et vCenter HA - Ne pas confondre 🔴

#### Protection des *VMs*

Pour protéger les *VMs* de votre *cluster*, c'est **vSphere HA** qu'il vous faudra activer.

|**Aspect**|**Détails**|
|----------|-----------|
|Protège quoi ?|Les machines virtuelles hébergées sur les hôtes ESXi|
|Configuré où ?|Dans vCenter, au niveau du cluster|
|Nécessite quoi ?|vCenter + minimum 2 hôtes ESXi|
|Comment ça marche ?|Si un hôte ESXi tombe, ses *VMs* redémarrent sur les autres hôtes|
|Type de protection|Redémarrage automatique (interruption de quelques minutes)|
|Portée (*Scope*)|Tout le *cluster* d'hôtes ESXi|
|Cas d'usage|Production standard|

**Exemple:**

Vous possédez un *cluster* composé de 3 hôtes ESXi avec 50 *VMs* réparties. Une panne survient sur l'hôte #2. vSphere HA redémarre automatiquement les 15 *VMs* de l'hôte en panne sur les hôtes #1 et #3. *Downtime* estimé à ~2 à 5 minutes.

La fonctionnalité HA de Proxmox est très similaire.

#### Protection de vCenter lui-même

Pour protéger spécifique vCenter, on utilisera **vCenter HA**, une protection spécifique et séparée pour la *VM* vCenter Server uniquement.

|**Aspect**|**Détails**|
|----------|-----------|
|Protège quoi ?|La machine virtuelle vCenter Server uniquement|
|Configuré où ?|Dans vCenter, via un assistant dédié (pas au niveau du cluster)|
|Nécessite quoi ?|3 adresses IP + stockage partagé + configuration spécifique|
|Comment ça marche ?|Crée 3 instances de vCenter en cluster (Actif/Passif/Témoin)|
|Type de protection|Basculement automatique vers nœud passif|
|Portée (*Scope*)|vCenter seulement|
|Cas d'usage|Production critique|

Proxmox n'a pas d'équivalent à ce produit puisque Proxmox possède une interface de gestion dans chacun de ces noeuds. Si un noeud tombe en panne, on consulte l'interface de gestion d'un autre noeud puis c'est tout. Or, VMware centralise sa gestion vCenter, il faut donc procéder autrement pour protéger l'interface de gestion.

## Comparaison directe: Proxmox vs VMware

|**Concept**|**Proxmox**|**VMware**|
|-----------|------------|-----------|
|**Hyperviseur**|KVM Intégré|ESXi|
|**Interface de gestion**|Interface web intégrée|ESXi Host Client (basique)|
|**Gestion centralisée**|Cluster intégré|vCenter Server (séparé)|
|**Clustering**|Intégré (corosync)|vCenter + HA/DRS|
|**Migration à chaud**|Live migration|vMotion|
|**Stockage distribué**|Ceph|vSAN|
|**Stockage partagé**|NFS, iSCSI, Ceph|VMFS, NFS, vSAN|
|**Haute-Disponibilité**|HA intégré|vSphere HA (via vCenter)|
|**Templates**|Templates intégrés|Templates + Content library|
|**Sauvegarde**|Proxmox Backup Server|vSphere Data Protection ou tiers|
|**Conteneurs**|LXC intégré|Non (VM uniquement)|
|**Licence**|Gratuit|Payant|