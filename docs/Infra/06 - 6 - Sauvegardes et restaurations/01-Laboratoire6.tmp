# Laboratoire 6

* * *

## Configuration de votre environnement virtuel

## Préalables ✅

- Avoir consulté la théorie en lien avec ce cours.
- Avoir complété l'installation de Proxmox 8.4.1 sur l'un de vos *Workstations*.

## Objectifs 🎯

1. Procéder à l'initialisation du système Proxmox.
2. Mettre en place une stratégie de gestion des utilisateurs.
3. Déployez les machines virtuelles demandées.
4. Mettre en place une stratégie de gestion des ressources.
5. Mettre en place une stratégie de sauvegarde.

## Étapes de réalisation 🔢

### Initialisation du système

Une fois votre système Proxmox bien installé et relié au réseau **<mark>RISQ-NAT</mark>** à l'aide de l'une de vos *IPs*, il vous faudra effectuer quelques manipulations de base:

- Créez 2 comptes par *admin-sys*. C'est vous ça les *admins-sys* 😉
    
    - Un compte d'administration du système (exemple: gabriel_adm).
        
        - Domaine d'authentification Proxmox
        - Groupe: *Senior-Admins*
        - Rôle: Administrator
        - Objets concernés: /
        - Accès au *shell* du noeud et à la commande **sudo**
    
    - Un compte d'administration des *VMs* (exemple: gabriel).

        - Domaine d'authentification Proxmox
        - Groupe: *Admins*
        - Rôle: PVEVMAdmin
        - Objets concernés: **/vms**
        - Pas d'accès au shell du noeud
        - Pas d'accès au système hôte

Désactivez les dépôts dont nous n'avons pas besoin pour l'instant et activez le dépôt *pve-no-subscription*. Effectuez les mises à jour sur le noeud.

### Stratégie de gestion des utilisateurs et de ressources

Créez les utilisateurs et les groupes suivants dans votre infrastructure:

|Groupe|Utilisateurs|Pool|Privilèges|
|------|------------|----|----------------------|
|Senior-Admins|Membres de votre équipe| N/A | Tous |
|Admins|Membres de votre équipe| N/A | Tous à l'exception de `Sys.PowerMgmt`, `Sys.Modify`, `Realm.Allocate` et `Permissions.Modify`|
|Dev-Ops|<ul><li>Julien Tassé</li><li>Arielle Côté</li><li>Émilie Bégin</li></ul>| DevOps | <ul><li>PVEVMAdmin sur leur pool</li><li>Gestion complète des VMs de production</li><li>Accès aux snapshots et backups</li></ul>
|Développement|<ul><li>Marc Messier</li><li>Paul Desgagnés</li><li>Sasha Riopel</li></ul>| Dev | <ul><li>PVEVMUser sur leur pool</li><li>Créer/modifier/supprimer leurs VMs</li><li>Pas d'accès aux VMs des autres</li></ul>|
|QA|<ul><li>Vincent Dubé</li><li>Marianne Trudelle</li></ul>|QA|<ul><li>PVEVMUser sur leur pool</li><li>Accès lecture aux pools Développement</li><li>Gestion des environnements de test</li></ul>|
|Formation|<ul><li>Sophie Dulude</li><li>Nathalie Poulin</li></ul>|Formation|<ul><li>PVEVMUser sur leur pool</li><li>Réinitialiser les VMs étudiants</li><li>Créer des templates</li></ul>|

*Au besoin: [Consultez la documentation](https://pve.proxmox.com/wiki/User_Management) officielle de Proxmox*

### Déploiement de Machines Virtuelles

:::caution
Vérifiez les ressources physiques à votre disposition avant de déployer les machines virtuelles. Sélectionnez les options pertinentes que nous avons étudiés en classe: *ballonning*, *cpu units*, etc.
:::

#### DevOps - Production

<span class="green-text">Créez les machines ci-dessous et assignez les au pool de ressources correspondant</span>

- **ID**: 201 - Nom: web-production
- **OS**: Ubuntu Server 24.04 LTS - **RAM**: 4Go - **CPU:** 4vCores
- **Stockage**: 40Go
<br/>
- **ID**: 202 | Nom: api-production
- **OS**: Ubuntu Server 24.04 LTS | **RAM**: 4Go | **CPU:** 4vCores
- **Stockage**: 30Go

#### Dev - Environnement de développement

<span class="green-text">Créez les machines ci-dessous et assignez les au pool de ressources correspondant</span>

- **ID**: 301 - Nom: dev-team
- **OS**: Ubuntu Server 24.04 LTS - **RAM**: 3Go - **CPU:** 2vCores
- **Stockage**: 30Go
<br/>
- **ID**: 302 | Nom: integration-staging
- **OS**: Ubuntu Server 24.04 LTS | **RAM**: 4Go | **CPU:** 4vCores
- **Stockage**: 80Go

#### QA - Assurance qualité et tests

<span class="green-text">Créez les machines ci-dessous et assignez les au pool de ressources correspondant</span>

- **ID**: 401 - Nom: staging-test
- **OS**: Ubuntu Server 24.04 LTS - **RAM**: 3Go - **CPU:** 4vCores
- **Stockage**: 60Go
<br/>
- **ID**: 402 | Nom: security-testing
- **OS**: Ubuntu Server 24.04 LTS | **RAM**: 4Go | **CPU:** 2vCores
- **Stockage**: 40Go

#### Lab - Formation

<span class="green-text">Créez les machines ci-dessous et assignez les au pool de ressources correspondant</span>

- **ID**: 501 - Nom: win-etu
- **OS**: Windows 10 - **RAM**: 4Go - **CPU:** 2vCores
- **Stockage**: 40Go
<br/>
- **ID**: 502 | Nom: win-formateur
- **OS**: Windows 10 | **RAM**: 4Go | **CPU:** 2vCores
- **Stockage**: 60Go

### Stratégies de sauvegarde

- Pool DevOps:
    - Fréquence: Quotidienne
    - Rétention: 14 quotidiennes + 12 mensuelles + 2 annuelles
- Pool Dev:
    - Fréquence: Hebdomadaire
    - Rétention: 8 hebdomadaires + 3 mensuelles
- Pool QA:
    - Fréquence: Bi-hebdomadaire
    - Rétention: 6 sauvegardes + 2 mensuelles
- Pool Formation:
    - Fréquence: Mensuelle
    - Rétention: 3 mensuelles