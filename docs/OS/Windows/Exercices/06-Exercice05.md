import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Exercice 05

## Utilisateurs, groupes et permissions

Dans cet exercice, vous aurez l'occasion de mettre en pratique les éléments que nous avons vu dans la théorie du cours sur les utilisateurs, les groupes et les permissions.

## Prélables

Vous devez posséder une machine virtuelle sous Windows 11 24H2 opérationnelle.

## Étapes de réalisation

### Partie 1 : Utilisateurs

1. Avec l'aide de l'interface graphique de Windows 11, créez les utilisateurs suivants:

    |Nom d'utilisateur|Nom complet|Description|Mot de passe|Options|
    |----------|------------------|-------------------|--------|------------|
    |Vincent|Vincent Carrier|Professeur|Passw0rd|Le mot de passe n'expire jamais|
    |Eric|Éric Gendron|Professeur|Passw0rd|Le mot de passe n'expire jamais|
    |Gabriel|Gabriel Gaudreault|Professeur|Passw0rd|Le mot de passe n'expire jamais|

2. Avec l'aide de PowerShell cette fois, créez les utilisateur suivants:

    |Nom d'utilisateur|Nom complet|Description|Mot de passe|Options|
    |----------|------------------|-------------------|--------|------------|
    |Paul|Paul Meilleur|Étudiant|Passw0rd|N/A|
    |Brice|Brice DeNice|Étudiant|Passw0rd|N/A|
    |Jean|Jean Peuplu|Étudiant|Passw0rd|N/A|

3. Êtes-vous capable d'ouvrir une session avec les utilisateurs que vous avez créé via PowerShell ? Pourquoi ? Réglez cette situation.

4. Trouvez comment exporter la liste de vos utilisateurs au format **csv** (séparés par des virgules) sur le bureau de l'Administrateur.

### Partie 2 : Groupes

5. À l'aide l'interface graphique de Windows 11, créez les groupes suivants:

    |Nom du groupe|Description|
    |-------------|-----------|
    |Professeurs|Responsable de dispenser au moins un cours|
    |Étudiants|Inscrit dans au moins un cours|
    |Communauté académique|Fréquente l'établissement scolaire|

6. À l'aide de PowerShell cette fois, ajoutez les membres de chacun des groupes tel que présenté dans le tableau ci-dessous:

    |Groupe|Membres|
    |------|----------------|
    |Professeurs|Éric Gendron, Vincent Carrier, Gabriel Gaudreault|
    |Étudiants|Paul Meilleur, Brice DeNice, Jean Peuplu|
    |Communauté Académique|Éric Gendron, Paul Meilleur, Vincent Carrier, Brice DeNice, Gabriel Gaudreault, Jean Peuplu|

### Partie 3 : Permissions

7. Créez la structure des dossiers suivante:

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Windows/Exercices/Permissions_W.svg'),
            dark: useBaseUrl('/img/Windows/Exercices/Permissions_D.svg'),
        }}
    />
</div>

8. Permissions pour le dossier **Établissement**
    - Seuls les membres du groupe *Administrateurs*, du groupe *Communauté Académique* ainsi que l'utilisateur *Système* doivent posséder des accès.
    
        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Communauté Académique|Lecture et exécution|
        |Système|Contrôle total|

9. Permissions pour le dossier **Professeurs**
    - Seuls les membres du groupe *Administrateurs*, du groupe *Professeurs* ainsi que l'utilisateur *Système* doivent posséder des accès.

        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Professeurs|Lecture et exécution|
        |Système|Contrôle total|

10. Permissions pour le dossier **Élèves**
    - Seuls les membres du groupe *Administrateurs*, du groupe *Étudiants* ainsi que l'utilisateur *Système* doivent posséder des accès.

        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Élèves|Lecture et exécution|
        |Système|Contrôle total|

11. Permissions pour les dossiers individuels des professeurs.
    - Chaque professeur possède un dossier personnel dans lequel il peut manipuler les items qu'il souhaite. Seul le professeur concerné, le groupe *Administrateurs* et l'utilisateur *Système* possèdent des accès.

        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Professeur concerné|Modification|
        |Système|Contrôle total|

12. Permissions pour le dossier commun des professeurs.
    - Seuls les membres du groupe *Administrateurs*, du groupe *Professeurs* ainsi que l'utilisateur *Système* doivent posséder des accès.

        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Professeurs|Lecture, écriture et exécution|
        |Système|Contrôle total|

13. Permissions pour les dossiers individuels des étudiants.
    - Chaque élève possède un dossier personnel dans lequel il peut manipuler les items qu'il souhaite. Seul l'étudiant concerné, le groupe *Administrateurs* et l'utilisateur *Système* possèdent des accès.

        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Étudiant concerné|Modification|
        |Système|Contrôle total|

14. Permissions pour le dossier commun des étudiants.
    - Seuls les membres du groupe *Administrateurs*, du groupe *Étudiants* ainsi que l'utilisateur *Système* doivent posséder des accès.

        |Utilisateur(s) concerné(s)|Permissions|
        |--------------------------|-----------|
        |Groupe des Administrateurs|Contrôle total|
        |Étudiants|Lecture, écriture et exécution|
        |Système|Contrôle total|

## Correction

Pour corriger votre laboratoire, utiliser les comptes suivants et validez les permissions:

|Compte|Dossier Établissement|Dossier professeurs|Dossier Élèves|Dossier perso. Prof.|Dossier perso. Étu.|Dossier commun Prof.|Dossier commun Étu|
|------|-------------|------------|-----------|----------|----------|------------|----------|
|Brice|Accès sans écriture|Aucun accès|Accès sans écriture|Aucun accès|Accès presque complet*|Aucun accès|Accès lecture/écriture|
|Vincent|Accès sans écriture|Accès sans écriture|Aucun accès|Accès presque complet*|Aucun accès|Accès lecture/écriture|Aucun accès|
|Administrateur|Accès total|Accès total|Accès total|Accès total|Accès total|Accès total|Accès total|

*Un accès presque complet signifie tous les droits à l'exception de changer les permissions.