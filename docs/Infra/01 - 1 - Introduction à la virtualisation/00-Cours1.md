# Cours 1

## Présentation de la virtualisation 📺

Même si la virtualisation peut sembler récente, elle remonte aux années 1960. IBM a virtualisé des mainframes avec les systèmes [CP‑40 et CP‑67](https://fr.wikipedia.org/wiki/IBM_CP-40), permettant d’exécuter plusieurs environnements sur une seule machine physique pour mieux partager les ressources. Ce sont les ancêtres directs des hyperviseurs modernes.

> *« Pourquoi ça n'a pas été popularisé dès cet époque ? »* 
>
> *-Les étudiants*

Parce que les étoiles n’étaient pas alignées 🌌 Les processeurs x86 n’étaient pas conçus, au départ, pour faciliter la virtualisation. Des acteurs comme VMware ont trouvé des contournements, puis les fabricants ont intégré des extensions de virtualisation dans les CPU. À partir des années 2000, l’écosystème s’est emballé 💥


## Pourquoi virtualiser ? 💡

### Réduction des coûts 💰

Moins de machines physiques pour un même résultat, c'est moins de dépenses directes et indirectes:

- Achat de matériel réduit
- Consommation d'énergie moindre 🔋
- Moins d'espace requis 🏢
- Maintenance simplifiée 🔧
- Licences et gestion consolidées

### Optimisation des ressources ⚙️

Par le passé, un service = serveur 😵‍💫 (ou presque). Résultat: beaucoup de RAM et de puissance de calcul (CPU) gaspillés. La virtualisation vient résoudre ce problème en mutualisant et réutulisant les ressources intelligemment.

- Allocation dynamique des ressources
- Consolidation des charges de travail
- Meilleur efficience

### Reprise après sinistre 💊

- Snapshots et sauvegardes faciles 🔄️
- Haute disponibilité automatique 🛠️
- Restauration rapide des services

### Impact environnemental réduit 🍃

Moins de matériel, c'est aussi:

- Moins de production industrielle 🏭
- Moins de transport et d'énergie fossile
- Moins de déchets électroniques ♻️

### On virtualise quoi ?

- Des ordinateurs et des serveurs (VM)
- Des équipements réseau: routeurs, pare-feu, commutateurs
- Du stockage : vSAN, datastores
- Des applications: Sandboxing, conteneurs, etc.

## L'hyperconvergence (HCI)

Pour bien saisir le principe de l'hyperconvergence, j'aime bien utiliser l'analogie du téléphone intelligent. Avant l'arrivée des téléphones intelligents, on utilisait plusieurs appareils distincts:

- 📷 Une caméra pour prendre des photos
- 📞 Un téléphone pour appeler
- 📧 Un ordinateur pour envoyer des courriels
- 📼 Un lecteur MP3 ou un iPod pour écouter de la musique
- 🗺️ Un GPS pour la navigation

L'arrivée du téléphone intelligent a **tout fusionné** dans un seul appareil compact, simple à gérer et mis à jour automatiquement.

L'hyperconvergence, c'est un principe très similaire, mais pour les **TI**.

### Architecture traditionnelle 

- Serveurs (calcul)
- Stockage (SAN/NAS)
- Réseautique (commutateurs/routeurs)

Chacun dans son coin, avec des interfaces différentes et séparées, ce qui complique énormément la gestion. 😓 

### Ce que propose l'HCI

L'hyperconvergence propose de tout rapatrié:

- Stockage, serveurs et réseautique dans une même boîte.
- Console de gestion unique et uniformisé.
- Déploiement accéléré.

Tout cela repose sur des hyperviseurs pour gérer les ressources (HDD, CPU, réseau, etc.)

### Avantages

- Scalabilité fluide et facile ⬆️
- Réduction des coûts 🤑
- Performance accrue 🎯
- Haute disponibilité 🪄
- Déploiement rapide 🏎️

## L'infonuagique ☁️

L'infonuagique, ou le « cloud », c'est déléguer la gestion du matériel à un centre de données. Vous n'avez plus à vous soucier de l'usure d'un serveur ou même d'assurer sa redondance. Tout ce que vous avez à faire, c'est vous concentrer sur le service à déployer.

### Modèles de service

Il existe plusieurs modèles de service dans le « cloud computing » :

|⭐ Modèle|🔧 Ce que vous gérez|🧪 Exemples|
|-------------------------------------|-----------------------|-----------------|
|IaaS (*Infrastructure as a Service*)|VM, OS, stockage, réseau|AWS EC2, Azure VM|
|PaaS (*Platform as a Service*)|Code applicatif (*backend*, *frontend*, etc.)| Google App Engine, Heroku|
|SaaS (*Software as a Service*)|Utilisation de l'application|Gmail, Dropbox, Microsoft 365|

**Analogie de la pizza** 🍕

- IaaS = On vous livre la farine, les tomates et le saucisson de pépéronni.
- PaaS = On vous livre la pâte, la sauce et les garnitures.
- SaaS = On vous livre une pizza prête à manger.

### Modèles de déploiement

| ⭐ Modèle | Description 🗒️ | Caractéristiques ✅ | Exemples |
|------------|----------------|-------------------|----------|
|Cloud public|Infrastructure partagée entre plusieurs clients, hébergée et gérée par un tiers.| <ul><li>Accès via internet</li><li>Évolutivité rapide</li><li>Paiement à l'usage</li><li>Pas d'infrastructure à maintenir</li></ul>|Microsoft Azure, AWS, Google Cloud Platform|
|Cloud privé|Infrastructure réservée à une seule organisation, soit sur un site ou hébergée chez un fournisseur.| <ul><li>Contrôle de sécurité élevés</li><li>Conformité renforcée</li><li>Personnalisation prossible</li><li>Coûts plus élevés</li></ul>|Datacenter interne, Azure Stack, VMware Cloud|
|Cloud hybride|Combinaison d'un cloud privé et public, avec orchestration entre les deux.|<ul><li>Flexibilité</li><li>Répartition des charges</li><li>Continuité des opérations</li><li>Compléxité accrue</li></ul>|Utilisation d'Azure pour le stockage + datacenter privé pour les données sensibles.|
|Multi-Cloud|Utilisation de plusieurs fournisseurs de cloud public en parallèle.|<ul><li>Éviter la dépendance à un fournisseur</li><li>Optimisation des coûts par service</li><li>Haute-disponibilité</li><li>Coordination complexe</li></ul>|Azure + AWS + GCP selon des besoins spécifiques.|

### VM, conteneur, instance 🧐

À travers les différents fournisseurs cloud, les hyperviseurs et la virtualisation en général, vous entendrez toutes sortes de termes. Ceci étant dit, chaque expression à une signification distincte:

| 🔍 Aspect | 🖥️ VM | 📦 Conteneur | ☁️ Instance Cloud |
|------------|-------|---------------|-------------------|
| Définition | Machine virtuelle complète | Environnement léger | VM à la demande |
| Isolation | Forte | Moyenne | Variable |
| Démarrage | Lent | Très rapide | Rapide |
| Poids | Lourd | Léger | Variable |
| Usage | OS Complet | Microservices | Serveurs cloud |

**Analogie du logement:**

- VM = Appartement privé
- Conteneur = Colocation
- Instance cloud = Chambre d'hôtel