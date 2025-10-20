import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Laboratoire 12

* * *

## Déploiement d'un cluster hyperconvergé Proxmox avec Ceph

## Préalables ✅

- 1 Passerelle de type PfSense (vous pouvez utiliser un modèle)
- 3 hyperviseurs Proxmox avec les caractéristiques suivantes:
    - Virtualisation matérielle activée
    - 4 coeurs
    - 16 Go de mémoire vive
    - 1 disque dur pour le système d'exploitation (Proxmox)
    - 2 disques durs de 500Go pour vos *OSDs*
    - 1 carte réseau reliée à votre passerelle
    - 1 carte réseau interne sans passerelle (pour Ceph)

## Objectifs 🎯

- Installer et initialiser un cluster Ceph (Quincy) sur Proxmox.
- Créer des *OSDs* à partir de vos disques virtuels.
- Créer un pool de stockage RBD pours les disques des *VMs*.
- Créer un pool de stockage CephFS pour les ISOs et les sauvegardes.
- Valider le fonctionnement de l'hyperconvergence.

## Schéma du laboratoire

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Virtu/Labo12_W.svg'),
            dark: useBaseUrl('/img/Virtu/Labo12_D.svg'),
        }}
    />
</div>

## Étapes de réalisation 🔢

### 1. Mise en place de votre passerelle

Dans `LabInfo`, clonez le modèle `_PASSERELLE` dans votre répertoire pour vous créer un réseau derrière un NAT. Cela évitera les différentes problématiques liées au fait que plusieurs étudiants ne renomment pas convenablement leur hyperviseur lors de l'installation.

### 2. Déploiement de vos hyperviseurs Proxmox

Comme je suis très gentil, je vous ai préparé un modèle Proxmox contenant déjà plusieurs `ISOs` à l'intérieur 🙂. Vous pouvez utiliser ce modèle, mais il sera important de faire quelques manipulations suite au clonage. Clonez donc le modèle `_ProxmoxVE_ModeleGG` qui se trouve dans `LabInfo` → `Modèles` → `420-5V6-5S6`. Lors du clonage, **<mark>n'oubliez pas de modifier le matériel de la machine (disques, cartes réseaux, etc.)</mark>** afin qu'il corresponde aux demandes dans la section préalables.

#### 2.1 Script pour rendre chaque hyperviseur unique

Une fois que votre machine Proxmox aura bien démarrée, vous trouverez un script nommé `new_node.sh` dans votre répertoire de travail. Ce script automatise les étapes que vous avez à faire pour rendre votre machine unique aux yeux des autres serveurs Proxmox que vous clonerez également. Exécutez donc le script en suivant les étapes. 

**Répétez ces étapes jusqu'à ce que vous ayez trois noeud parfaitement fonctionnels**

:::tip
Les *ISOs* de Ubuntu et Windows sont déjà présents dans le modèle Proxmox. De rien 😉.
:::

### 3. Création du réseau dédié pour Ceph

Dans chacun de vos hyperviseurs Proxmox, vous devrez créer un nouveau *bridge* Linux. Ce *bridge* devra être associé à votre seconde carte réseau (voir schéma ci-dessus). Définissez une adresse IP pour chaque hyperviseur manuellement.

Exemple:

- noeud 1 : 10.0.0.10
- noeud 2 : 10.0.0.20
- noeud 3 : 10.0.0.30

### 4. Clustering

Créez un cluster sur l'un des noeuds, et joignez-y les deux autres noeuds.

### 5. Mise en place du cluster Ceph

#### 5.1 Activation des dépôts pour Ceph

Pour installer Ceph, il nous faut activer certains *repositories* dans Proxmox. **Pour chacun des noeuds**, dirigez-vous dans *Updates*, puis *Repositories*. De là, sélectionnez `Add`, puis cliquez sur `Ceph Quincy No-Subscription`. Finaliser l'ajout en cliquant de nouveau sur `Add`.

Assurez-vous que tout est en ordre en entrant la commande suivante dans le *shell* de chaque noeud:

```bash
apt update
```

#### 5.2 Installation de Ceph

Dans l'interface web de votre cluster Proxmox, cliquez sur un premieur et dirigez-vous dans **Ceph**. Immédiatement, Proxmox vous mentionnera que Ceph n'est pas installé et vous proposera d'en faire l'installation. Cliquez donc sur *Install Ceph*.

Dans la fenêtre d'installation, vous devrez choisir la version à installer. Pour les environnements de tests ou de laboratoires, il est recommandé d'installer la version `quincy`. C'est donc ce que nous utiliserons. Sélectionnez donc `quincy (17.2)` et le *repository* `No-Subscription`.

Lancez l'installation.

Une fois les paquets installés, vous aurez accès à l'onglet *Configuration* où vous pourrez définir les réseaux à utiliser pour Ceph. Nous avons distinguer ces deux types de réseau dans la théorie, configurez-les donc conformément à ce dont nous avons discuté.

**Répétez l'étape 5.2 pour chaque noeud**.

#### 5.3 Création d'un pool Ceph

Un pool, c'est simplement un rassemblement d'*OSDs* auquel on applique une règle de réplication. C'est donc lorsqu'on crée un *pool* ceph qu'on peut déterminer si nous désirons 2,3 ou même 4 réplications distinctes.

Il est obligatoire de créer au moins un *pool* pour utiliser Ceph. Dans un de vos noeuds, dirigez-vous dans le menu `Ceph`, puis sélectionnez `Pools`. Enfin, cliquez sur `Create`.

Nommez votre *pool* vm_disks tout simplement. Une taille 3 (3 copies de chaque *PGs*) est la norme. Enfin, laissez l'*autoscaler* de Proxmox déterminer la taille des *PGs*. Proxmox est assez efficace pour ça.

Dès la création de votre *pool*, vous le verrez apparaitre dans chaque noeud...sauf que le pool est vide actuellement...

#### 5.4 Création des OSDs

**Souvenez-vous:**

**1 disque = 1 OSD**

Nous avons ajouté 2 disques de 500Go dans chacun de nos noeuds Proxmox. Nous avons donc 6 *OSDs* à créer.<br/> **<u>Dans chacun des noeuds:</u>**

Dirigez-vous dans le menu `Ceph`, puis dans `OSD`. Dans cette fenêtre, cliquez sur `Create: OSD`. Créez un OSD pour `/dev/sdb` et `/dev/sdc`.

### 6. Création d'une machine virtuelle

Dans le noeud de votre choix, créez une machine virtuelle (linux, windows, peu importe) en utilisant votre pool Ceph comme stockage.<br/>

Répondez aux questions suivantes:

- Où est stocké le disque de votre machine virtuelle ?
- Combien de *downtime* il y a lors d'une migration à chaud de votre machine virtuelle de test ?
- Pouvez-vous stocker des sauvegardes sur votre pool Ceph ?