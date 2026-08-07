---
draft: true
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Introduction à Serveurs 2

## Le plan de cours 📋

Le plan de cours officiel est disponible dans teams, [ici même](../Assets/01/PC_2026A_420-3S6-EM_Département-Informatique.pdf), ou sur Léa (omnivox). Prenez le temps de le lire, pas juste de l'ouvrir et de le fermer. Il contient les informations qui répondent à 90% de vos questions administratives d'ici la fin de la session.

:::caution[Les points à retenir dès maintenant]
- **Pondération:**<br/>60% en évaluation supervisée (quiz + examens), 40% en évaluation non supervisée (projet + journal).
- **Double seuil:**<br/>Vous devez réussir les **deux** parties séparément. Un 95% sur le projet ne peut racheter un échec aux examens.
- **Qualité du français:**<br/>Évaluée dans le journal et le projet. Je n'attends pas des documents écrits en alexandrin de votre part, mais le vocabulaire technique doit être utilisé correctement.
:::

## Les règles de classe 🫡

1. **Présence et ponctualité:**<br/>
Les cours sont en présence obligatoire. Les quiz se donnent en début de période, si vous arrivez en retard, vous manquez le quiz. Il n'y a pas de reprise.

2. **Les retards de travaux:**<br/>
Une pénalité de retard de 10% par jour de retard s'applique sur les travaux non remis à temps. Passé 5 jours, la note est de zéro. Si vous avez une situation exceptionnelle, contactez-moi <span class="red-text">**AVANT**</span> la date de remise, pas après.

3. **L'utilisation de l'IA:**<br/>
L'intelligence artificielle est un outil, pas un technicien de remplacement. <span class="red-text">**Vous serez avisé très clairement lorsque son utilisation sera permise ou prohibée**</span>.

4. **Le respect du matériel et de l'infrastructure:**<br/>
Votre infrastructure Proxmox est partagée avec d'autres étudiants et d'autres groupes. Ne touchez pas aux conteneurs ou VMs qui ne vous appartiennent pas. Une erreur qui affecte l'infrastructure des autres est traitée sérieusement.

5. **Communication:**<br/>
Pour toute question, en dehors des heures de cours, passez par Teams. Je réponds généralement dans les 24 heures lors des journées ouvrables. Les courriels et Mio fonctionnent aussi, mais Teams est plus rapide. Pour prendre un rendez-vous avez moi durant mes périodes de disponibilité, vous n'avez qu'à suivre [ce lien.](https://calendar.app.google/r8cNy87mCCrjoPs78)

## C'est parti! 🏁

Dans le cours de `Serveurs 1`, vous avez appris à déployer des services dans un réseau **interne**, un réseau que l’on contrôle, que l’on connaît, dans lequel les erreurs restent entre nous. C'était votre terrain d'entraînement 😏.

Dans `Serveurs 2`, <u>on sort dehors!</u>

Vos serveurs seront exposés sur **Internet**, un espace public. Ça change pas mal de choses, ne serait-ce que du point de vue de la cybersécurité.

## Le projet de session : HébergePro inc. 🏢

Cette session, vous n'installerez pas des serveurs dans le vide. Vous êtes mandaté comme **technicien réseau junior** chez une entreprise fictive: **HébergePro inc.** HébergePro est une PME qui veut migrer toute son infrastructure vers des serveurs exposés sur Internet. Chaque semaine, vous recevrez un **bon de travail** (une demande formulée comme dans le vrai monde) par un client qui n'a pas nécessairement le vocabulaire technique pour décrire ce qu'il veut.

**Votre job:** <u>Décoder la demande, déployer la solution, et livrer quelque chose de fonctionnel.</u>

:::info
Ce qui rend ce projet intéressant, et ce pour quoi vous devez suivre le rythme du cours, c'est que chaque livrable s'appuie sur le précédent. Vous ne pourrez pas compléter le bon de travail \#3, sans avoir complété le \#2 préalablement. Et vous ne pourrez commencer le bon de travail \#2 sans avoir fait le premier.
:::

## Votre infrastructure 🖥️

Votre infrastructure de projet tourne sur un cluster Proxmox situé dans la salle des serveurs du département, connecté au **réseau RISQ** (Réseau d'informations scientifiques du Québec). Ça veut dire que vos serveurs sont **vraiment** accessibles depuis Internet, pas juste depuis le lab.

En conséquence:

- Vos certificats SSL (https) seront vrais
- Votre **DNS** sera public (résolvable depuis n'importe où)
- Vos erreurs de sécurité pourraient coûter très cher 🙃

## Votre architecture personnelle

Chaque étudiant dispose de sa propre infrastructure isolée, composée de plusieurs conteneurs et d'un pare-feu dédié:

|Composant|Type|Rôle|
|----------------|:---------------:|--------------|
|PfSense|VM|Pare-feu, routage, NAT, c'est votre frontière avec Internet|
|Serveur web|Conteneur LXC|Apache, PHP, WordPress, GLPI|
|Serveur de base de données|Conteneur LXC|MariaDB, séparé du serveur web|
|Serveur DNS primaire|Conteneur LXC|Bind9, partagé en équipe lors du module DNS|
|Serveur DNS secondaire|Conteneur LXC|Bind9, *idem*|

:::note[Conteneur LXC ?]
Un conteneur LXC est un environnement Linux isolé qui tourne sur le même noyau que l'hyperviseur (Proxmox). C'est beaucoup plus léger qu'une VM complète (démarrage en quelques secondes, empreinte mémoire minimale), mais du point de vue de l'administration système, ça se comporte exactement comme un serveur Linux ordinaire. Vous vous y connectez en SSH, vous installez des paquets, vous éditez des fichiers de configuration, etc. Vous en apprendrez davantage sur ces éléments dans votre cours d'infrastructure virtuelle.
:::

### Votre sous-domaine

Vous aurez besoin d'un sous-domaine pour votre projet de session. Celui-ci sera tout simplement composé de votre matricule suivi de *.cemti.ca*. À titre d'exemple, si votre matricule est le 1234567, votre sous-domaine est le `1234567.cemti.ca`

## LabInfo

Pour les exercices du cours, vous devrez utiliser LabInfo. Vous pouvez déjà y créer des VMs à la volée, les briser, les recréer et expérimenter sans risque.

:::caution
Deux environnements bien distincts. LabInfo ≠ Proxmox. Les exercices se font dans LabInfo. Le projet HébergePro se fait sur Proxmox. Ne mélangez pas les deux, ce serait fâcheux de bousiller un morceau de projet en cours 😬.
:::