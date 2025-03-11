import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';

# Travail pratique

Pour la réalisation de ce travail, l'infrastructure vous ait complètement fourni. Les serveurs DNS et DHCP sont prêts et à utiliser tel quel et il en va de même pour les clients. Un nom de domaine a déjà été sélectionné et tous les ordinateurs possèdent leur propre FQDN.

L'ensemble des ordinateurs virtuels nécessaires à la réalisation de ce TP sont disponible directement dans Labinfo dans la section MODÈLES > 420-2S5 > TP.

Voici les informations de chacune des machines virtuelles:

|Nom de la machine|Nom d'utilisateur|Mot de passe|Adapteur réseau 1|Adapteur réseau 2|
|-----------------|-----------------|------------|-----------------|-----------------|
|MODELE_PASSERELLE_2S5_TP1| N/A | N/A | Acces-Internet-1 | Votre réseau privé |
|MODELE_PC0001_2S5_TP1| Administrateur | Passw0rd| Votre réseau privé | N/A |
|MODELE_PC0002_2S5_TP1| Administrateur | Passw0rd| Votre réseau privé | N/A |
|MODELE_UbuntuServeur_2S5_TP1| utilisateur | Passw0rd| Votre réseau privé | N/A |
|MODELE_WindowsServeur_2S5_TP1| Administrateur | Passw0rd| Votre réseau privé | N/A |

## Mandat

Après avoir déployé les machines virtuelles fournies, répondez à chacune des questions présentées dans [ce document](../Assets/Travaux/Travail%20pratique.docx). Vous devez me remettre ce document dûment rempli via Teams, dans la section « Devoirs » avant l'échéance indiqué.

:::caution[Preuves et justifications]
Pour chaque réponse, vous devez fournir des explications et des justifications qui s'appuient sur des preuves. Ces preuves devront être ajoutées dans les encadrés respectifs pour appuyer vos propos. Si vous fournissez des preuves insuffisantes ou partielles, des points seront automatiquement retranchés.
:::

## Présentation de l'infrastructure

Voici l'infrastructure sur laquelle vous vous apprêtez à travailler:

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/tp_w.svg'),
            dark: useBaseUrl('/img/Serveurs1/tp_d.svg'),
        }}
    />
</div>

### Mise en place

1. Commencez par déployez la passerelle. Vous devrez ajuster l'une de ses cartes réseaux (celle qui n'est pas sur *accès internet*) pour la relier à l'un de vos réseaux privés.

2. Déployez les autres machines virtuelles dans l'autre que vous le souhaitez. Cependant, n'oubliez pas de modifier l'adapteur réseau afin de relier celui-ci à votre réseau privé.

3. <mark>**Vous n'avez aucune adresse IP à modifier ni de nom d'ordinateur à configuré. Changez-les à vos risques!**</mark>

## Correction et pondération

Voici un tableau représentant la quantité de points pour chacune des questions.

|Question|Pondération|
|:--------------------|-----------:|
|#1 - Réparation de la navigation| 4 points|
|#2 - Réservations DHCP| 4 points|
|#3 - Création d'enregistrements| 4 points|
|#4 - Configuration « PING » | 4 points|
|#5 - Gestionnaire des zones | 2 points|
|#6 - Redirecteurs | 2 points|
|#7 - Service SSH | 4 points|
|#8 - FQDN | 1 point|
|Total | 25 points|

### Détails de l'évaluation de chaque question

Voici les détails qui me permettront d'attribuer des points pour chaque élément:

- **Réparation de la navigation** *(4 points)*
    - Le diagnostic posé est le bon
    - La solution est appliquée est la bonne
    - Les bonnes pratiques de travail sont respectés
    - La navigation semble de nouveau fonctionnelle
- **Réservations DHCP** *(4 points)*
    - Les réservations prennent en compte l'adressage ip au sein des zones
    - Les réservations sont fonctionnelles
    - Il y a une réservation pour chaque poste
- **Création d'enregistrements** *(4 points)*
    - Un enregistrement valide a été ajouté dans la zone de recherche directe
    - Un enregistrement valide a été ajouté dans la zone de recherche inversée
    - Les numéros de série ont été incrémentés dans tous les cas
- **Configuration « PING »** *(4 points)*
    - Les requêtes « PING » fonctionnent dans les deux sens
    - Le pare-feu est actif dans les deux clients
    - Les règles concernées ont été modifiées
- **Gestionnaire des zones** *(2 points)*
    - L'information récupérée est la bonne
    - La méthode utilisée pour récupérer l'information est efficace
- **Redirecteurs** *(2 points)*
    - Les redirecteurs trouvés sont les bons
    - L'information a été récupérée au bon endroit
- **Service SSH** *(4 points)*
    - Un service SSH est bel et bien en fonction sur le serveur DNS
    - Le service est automatiquement lancé au démarrage
    - Une règle est en place pour n'autoriser que le PC concerné
    - Une preuve de connexion valide est fournie
- **FQDN** *(1 point)*
    - Il s'agit du bon FQDN
    - La méthode de récupération de l'information est efficace