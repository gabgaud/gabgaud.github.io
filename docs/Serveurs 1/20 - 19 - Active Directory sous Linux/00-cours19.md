---
draft: false
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 19

## Active Directory sous Linux ? 🤯

Oui, vous avez bien lu. Il est tout à fait possible de créer un contrôleur de domaine Active Directory sous Linux.

> *Oui, mais Gabriel, tu veux surement dire que c'est un équivalent d'Active Directory puisqu' Active Directory est un produit Microsoft?*
>
> *-Les étudiants*

Bon évidemment, ce n'est pas le produit **officiel** de Microsoft, mais la différence est pratiquement imperceptible. D'ailleurs, les outils [**RSAT**](https://learn.microsoft.com/fr-ca/troubleshoot/windows-server/system-management-components/remote-server-administration-tools) de Microsoft nous permettent d'administrer le tout, c'est pour vous dire à quel point la similarité est étonnante.

## Le rôle de Samba

Samba est un logiciel libre qui permet à un serveur Linux de remplir plusieurs rôles dans un environnement réseau, notamment celui de **contrôleur de domaine Active Directory**. 

### Comment Samba fonctionne-t-il en tant que contrôleur de domaine AD ?

Lorsqu'il est configuré comme contrôleur de domaine, Samba prend en charge de nombreuses fonctionnalités d'Active Directory, permettant ainsi aux systèmes Linux et Windows de coexister dans le même réseau. Voici les principales tâches remplies par Samba :

- **Gestion des utilisateurs et des groupes** : Samba utilise **LDAP** (Lightweight Directory Access Protocol) pour stocker et gérer les informations relatives aux utilisateurs et aux groupes dans un domaine.
  
- **Authentification Kerberos** : Samba gère l'authentification des utilisateurs via **Kerberos**, qui est également le protocole d'authentification utilisé par les contrôleurs de domaine Windows. Cela permet d'assurer une sécurité de niveau entreprise dans les environnements mixtes (Linux et Windows).

- **Partage de fichiers et d'imprimantes** : En plus de sa gestion des utilisateurs et des rôles de domaine, Samba fournit des services de **partage de fichiers** et d'**impression** via **SMB/CIFS**. Cela permet aux machines Windows (ou autres systèmes compatibles) de se connecter et d'accéder aux ressources partagées sur le réseau.

- **Group Policy Objects (GPO)** : Samba peut gérer l'application de **politiques de groupe** (GPOs), qui permettent de contrôler les paramètres de sécurité et de configuration des machines et des utilisateurs dans un domaine, bien que la prise en charge des GPOs dans Samba soit encore plus limitée que celle d'un contrôleur de domaine Windows.

### Pourquoi utiliser Samba comme contrôleur de domaine ?

- **Interopérabilité** : Samba permet aux systèmes Linux de s'intégrer de manière fluide dans un environnement Active Directory où cohabitent des machines Windows et Linux.
- **Réduction des coûts** : Pour les entreprises souhaitant éviter d'acheter des licences Windows Server, Samba permet de créer un contrôleur de domaine AD sans coût supplémentaire.
- **Flexibilité** : En plus des fonctionnalités d'AD, Samba permet de personnaliser son environnement selon les besoins spécifiques du réseau.

## Comparaison avec un contrôleur de domaine Windows

Bien que Samba soit une solution puissante, il existe certaines différences avec un contrôleur de domaine Windows classique. Voici un tableau de comparaison pour mieux comprendre ces différences.

| **Fonctionnalité**                   | **Samba (Linux)**                                           | **Contrôleur de Domaine Windows**                             |
|--------------------------------------|------------------------------------------------------------|------------------------------------------------------------|
| **Authentification**                 | Utilise **Kerberos** pour l'authentification sécurisée.     | Utilise **Kerberos** pour l'authentification sécurisée.      |
| **Gestion des utilisateurs et groupes** | Gère via **LDAP**, stocke les informations de domaine.     | Gère via **Active Directory** (AD), base de données propre à Windows. |
| **Protocole SMB/CIFS**               | Fournit des services SMB/CIFS pour le partage de fichiers et imprimantes. | Fournit des services SMB/CIFS, ainsi qu'une intégration native plus poussée avec les clients Windows. |
| **Group Policy (GPO)**               | Peut appliquer des politiques de sécurité via des GPOs, mais avec des limitations. | Supporte pleinement la gestion des GPOs, permettant un contrôle granulaire sur les politiques de sécurité et de configuration. |
| **Interopérabilité**                 | Permet l'intégration des systèmes Linux et Windows dans un même domaine. | Intégration native de Windows, avec une meilleure prise en charge des fonctionnalités et des outils AD. |
| **Répartition des rôles**            | Samba peut gérer un ou plusieurs rôles, mais son fonctionnement reste partiellement limité par rapport à Windows. | Windows Active Directory distribue et gère automatiquement les rôles à travers un environnement complexe de plusieurs serveurs. |

## Conclusion

Samba permet de créer un contrôleur de domaine Active Directory sous Linux, offrant ainsi une alternative libre et gratuite aux solutions Microsoft. Bien que certaines fonctionnalités (notamment les **GPOs**) soient limitées par rapport à un contrôleur de domaine Windows, Samba reste une option robuste pour les environnements mixtes, tout en étant plus économique et flexible. Grâce à sa compatibilité avec les outils Microsoft comme les **RSAT**, la gestion du domaine devient simple et accessible, même dans un environnement non-Windows.

Ainsi, Samba vous permet de gérer un domaine Active Directory sur Linux de manière transparente, ce qui peut être un atout dans des infrastructures de serveurs hétérogènes.
