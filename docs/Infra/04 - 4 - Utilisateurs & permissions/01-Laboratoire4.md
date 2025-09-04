# Laboratoire 4

* * *

## Administration d'utilisateurs, de permissions et de ressources avec Proxmox

## Préalables ✅

- Avoir un hyperviseur Proxmox prêt à être utilisé.
- Avoir consulté la théorie en lien avec ce cours.

## Objectifs 🎯

Mettre en place une architecture RBAC complète respectant le principe du moindre privilège et permettant une gestion efficace des permissions.

## Étapes de réalisation 🔢

L'entreprise TechSolutions Inc. utilise Proxmox VE pour virtualiser son infrastructure. Elle compte 3 départements :

- Développement (5 développeurs)
- Production/Ops (3 administrateurs système)
- Support technique (2 techniciens)

TechSolutions Inc. gère actuellement deux projets:

- Un projet E-Commerce (en production)
- Un projet CRM (en développement)

### Partie 1 - Création des groupes

À l'aide de **l'invite de commandes**, créez les groupes suivants avec la commande `pveum`:

1. **dev-team**: Équipe de développement
2. **ops-team**: Administrateurs système et production
3. **support-team**: Support technique
4. **project-managers**: Gestionnaires de projets

### Partie 2 - Création des utilisateurs

À l'aide de l'invite de commandes:

- Créez les utilisateurs ci-dessous en prenant soins de les assigner à leur groupe respectif.
- Définissez les mots de passe de manière sécurisée

<table>
    <tr>
        <th>Équipe</th>
        <th>Login</th>
        <th>Prénom</th>
        <th>Nom</th>
        <th>Courriel</th>
    </tr>
    <tr>
        <td rowspan="2">Équipe développement</td>
        <td>alice.dev</td>
        <td>Alice</td>
        <td>Martin</td>
        <td>alice.martin@techsolutions.com</td>
    </tr>
    <tr>
        <td>bob.dev</td>
        <td>Bob</td>
        <td>Tremblay</td>
        <td>bob.tremblay@techsolutions.com</td>
    </tr>
    <tr>
        <td rowspan="2">Équipe Ops</td>
        <td>charlie.ops</td>
        <td>Charlie</td>
        <td>Dubois</td>
        <td>charlie.dubois@techsolutions.com</td>
    </tr>
    <tr>
        <td>diane.ops</td>
        <td>Diane</td>
        <td>Roy</td>
        <td>diane.roy@techsolutions.com</td>
    </tr>
    <tr>
        <td>Équipe Support</td>
        <td>eve.support</td>
        <td>Eve</td>
        <td>Gagnon</td>
        <td>eve.gagnon@techsolutions.com</td>
    </tr>
    <tr>
        <td>Gestionnaire</td>
        <td>frank.pm</td>
        <td>Frank</td>
        <td>Pelletier</td>
        <td>frank.pelletier@techsolutions.com</td>
    </tr>
</table>

:::important[Bonus!]
Créez un script bash qui vous permettra de créer des utilisateurs en lot. Au besoin vous pourriez même vous aider à l'aide de l'IA (chatgpt, gemini, etc.)
:::

### Partie 3 - Création des pools de ressources

À l'aide de l'invite de commandes, créez les *pools* de ressources suivants:

1. **pool-ecommerce-prod**: Ressources production e-commerce
2. **pool-ecommerce-dev**: Ressources développement e-commerce
3. **pool-crm-dev**: Ressources développement CRM
4. **pool-shared-services**: Services partagés (monitoring, backup, etc.)

:::note
Vos *pools* de ressources peuvent très bien être vides pour l'instant. Ce n'est pas important.
:::

### Partie 4 - Attribution des permissions

Implémentez la matrice des permissions suivante:

|**Groupe**|**Pool/Ressource**|**Rôle**|**Justification**|
|----------|------------------|--------|-----------------|
|dev-team|pool-ecommerce-dev|PVEVMAdmin|Contrôle total de leur environnement de dev|
|dev-team|pool-crm-dev|PVEVMAdmin|Contrôle total de leur environnement de dev|
|ops-team|/(racine)|PVEAdmin|Administration générale|
|support-team|/vms|PVEVMUser|Accès console et power management|
|project-managers|pool-ecommerce-prod|PVEAuditor|Visualisation seule de la production|
|project-managers|pool-ecommerce-dev|PVEAuditor|Visualisation seule de la production|

#### Permissions spéciales

- **alice.dev@pve**: Accès `PVEAuditor` sur `pool-ecommerce-prod` (elle supervise les déploiements)
- **charlie.ops@pve**: Accès complet `Administrator` sur tout (c'est l'admin. senior)

### Partie 5 - Tests et validation

Voici une série de tests à effectuer pour valider que vous avez bien effectué ce qui était demandé dans ce laboratoire:

1. Connectez-vous avec **alice.dev** et vérifiez que:
    - Elle peut voir les *pools* de développement
    - Elle peut voir le *pool* e-commerce production (lecture seule)
    - Elle ne peut pas voir le *pool* `pool-shared-services`

2. Connectez-vous avec **eve.support** et vérifiez que:
    - Elle peut voir les *VMs*
    - Elle peut accéder aux consoles
    - Elle ne peut pas créer de nouvelles *VMs*

3. Connectez-vous avec **frank.pm** et vérifiez que:
    - Il peut voir les *pools* en lien avec le projet de e-commerce
    - Il ne peut pas effectuer aucune modification
    - Il ne peut pas voir les *pools* en lien avec le projet CRM

### Bonus

1. Activez l'authentification à double facteur pour **charlie.ops**

2. Configurez une expiration de compte pour **bob.dev** (3 mois)
