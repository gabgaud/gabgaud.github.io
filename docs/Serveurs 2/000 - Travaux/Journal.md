---
draft: true
---

# Le journal de travail - 15%

## C'est quoi  ?

Ce n'est pas un rapport. Ce n'est pas un résumé de cours ni une liste de commandes copiées depuis le site de cours ou fournies par l'IA 😉. C'est **votre trace personnelle de ce qui s'est vraiment passé** sur vos serveurs, semaine après semaine. Les commandes que vous avez tapées. Les erreurs que vous avez rencontrées. Les hypothèses que vous avez formulées. Les solutions que vous avez trouvées, ou pas, du premier coup.

> *« Mais monsieur, si j'inscris mes erreurs, je serai pénalisé ? »*
>
> *-Les étudiants*

**NON!** Un journal sans erreur, c'est un journal qui ment. Documenter un problème et sa solution démontre beaucoup plus de compétence que de prétendre que tout a fonctionné du premier coup. Les techniciens expérimentés documentent leurs erreurs, c'est comme ça qu'ils évitent de les répéter.

## Pourquoi est-ce important ?

Dans quelques mois, vous serez en stage (oui, déjà!). Votre superviseur vous demandera de configurer ou de dépanner un service que vous aurez peut-être croisé ici même, dans ce cours. Malheureusement, les superviseurs ne fournissent pas de site de cours comme moi 🙈. Sauf que votre journal lui, vous pourrez l'ouvrir de nouveau.

Il est évalué à **15% de votre note finale**. Sa correction se fera à la toute fin de la session. Remettez-le complet, pas en catastrophe la veille.

## Format

Votre journal peut être tenu dans **n'importe quel outil** qui vous convient : Word, Notion, Obsidian, un fichier Markdown, un Google Doc. L'important, c'est qu'il soit écrit et remis au format PDF via un dépôt Teams au moment opportun.

Une entrée au journal doit être fait par bon de travail. Nul besoin  de faire un roman, mais il faut consigner suffisamment de détails pour que vous puissiez reproduire ce que vous avez fait six mois plus tard sans retourner dans les notes de cours.

## Gabarit d'une entrée type 🩻

Vous pouvez utiliser ce gabarit pour chaque bon de travail. Remplissez-le au fur et à mesure, pas la veille de la remise.

* * *

**BT01: Titre du bon de travail**<br/>
**Date :** JJ mois 2026

**Objectif:** ( *En une phrase: qu'est-ce que ce bon de travail vous demandait de livrer ?* )

**Ce que j'ai fait:**<br/>
*Décrivez les grandes étapes de votre démarche, pas une liste exhaustive de chaque commande (je n'ai pas besoin de connaître chaque `ls` effectué), mais les étapes significatives dans l'ordre où vous les avez faites.*

**Commandes importantes:**<br/>
*Listez les commandes clés que vous avez utilisées, avec une brève explication de ce qu'elles font. Vous n'avez pas besoin de documenter les commandes de base telles que `ls` ou `cd`, concentrez-vous sur ce qui est spécifique au service que vous configurez.*

Exemples:

```bash
# Installe le serveur web apache
sudo apt install apache2 -y
```

ou encore:

```bash
# Configure Apache pour démarrer automatiquement au redémarrage du serveur
sudo systemctl enable apache2
```

**Problèmes rencontrés:**<br/>
*C'est la section la plus importante. Pour chaque problème: qu'est-ce qui ne fonctionnait pas ? Comment vous l'avez diagnostiqué ? Ce que vous avez essayé ? Ce qui a finalement fonctionné ?*

- **Problème:** *Description du problème (le message d'erreur, le comportement inattendu, etc.)*

- **Diagnostic:** *Comment vous avez cherché ? Quels sont les journaux que vous avez consultés ? Les commandes de vérification utilisées ? Vos premières hypothèses ?*

- **Solution:** *Ce qui a finalement réglé le problème.*

**Vérification du livrable:**<br/>
*Comment avez-vous confirmé que votre livrable fonctionne ? Est-ce une page web qui répond ? Une commande qui retourne le bon résultat ? Soyez précis.*

**Observations personnelles:**<br/>
*Qu'est-ce que vous avez appris ? Qu'est-ce qui vous a surpris ? Qu'est-ce que vous feriez différemment la prochaine fois ?*

## Exemple d'une bonne entrée au journal ✅

Voici ce à quoi ressemble une entrée bien rédigée

* * *

**Titre:** BT05 - Site web sécurisé en HTTPS

**Date:** 21 septembre 2026

**Objectif:** Déployer un site de type vitrine accessible à `https://www.1234567.cemti.ca` avec un certificat SSL valide via Let's Encrypt.

**Ce que j'ai fait:** J'ai commencé par installer Apache et j'ai créé un hôte virtuel pour `www.1234567.cemti.ca`. Ensuite, j'ai déposé la page HTML dans `/srv/hebergepro/www/`. J'ai ensuite installé Certbot pour obtenir le certificat Let's Encrypt et configuré la redirection HTTP -> HTTPS.

**Commandes importantes:**

```bash
sudo apt install apache2 -y
# Installe le serveur web

sudo certbot --apache -d www.1234567.cemti.ca
# Obtient un certificat et configure Apache automatiquement
```

**Problèmes rencontrés:**<br/>

- *Problème:* Certbot retournait l'erreur `Could not bind to IPv4 or IPv6` lors de la validation.

- *Diagnostic:* J'ai vérifié mon pare-feu avec la commande `sudo ufw status` et j'ai constaté que le port 80 n'était pas ouvert. Or, Certbot a besoin que le port 80 soit accessible pour valider le domaine.

- *Solution:* J'ai ouvert le port 80 avec la commande `sudo ufw allow 80/tcp`, puis j'ai relancé Certbot.

**Vérification du livrable:**<br/>
J'ai ouvert la page `https://www.1234567.cemti.ca` depuis mon téléphone (hors réseau du cégep) et j'ai vu la page s'affiché avec le petit cadenas vert.

**Observations personnelles:**<br/>
Je ne savais pas que Certbot pouvait modifier directement la configuration d'Apache. C'est pratique, mais ça veut dire qu'il faut faire attention si on a une configuration Apache personnalisée avant d'appeler Certbot.

## Critères d'évaluation 💯

|Critère|Excellent|Satisfaisant|Insuffisant|
|-------|---------|------------|-----------|
|Complétude|Tous les bons de travail sont documentés, aucun manquant.|Quelques bons de travail manquants ou très incomplets.|Plusieurs bons de travail manquants.|
|Problèmes documentés|Les problèmes rencontrés sont détaillés et comportent un diagnostic et une solution.|Les problèmes rencontrés sont mentionnés, mais la démarche de diagnostic est incomplète, incohérente ou problématique.|Peu ou aucun problème rencontré n'a été documenté.|
|Commandes utilisées|Les commandes sont pertinentes et expliquées dans leur contexte.|Quelques commandes sont listées, avec peu ou sans explications.|Copier-coller de commande avec peu, ou sans, explication ni contexte.|
|Vérification|Les livrables sont vérifiés de façon concrète et décrite.|Les livrables sont vérifiés sommairement ou à l'aide d'une confirmation vague.|Peu ou pas de vérification des livrables documentée.|
|Qualité du français|Vocabulaire technique correct, texte clair.|Quelques erreurs qui n'empêchent pas la compréhension.|Texte difficile à suivre et à comprendre.|

### Questions fréquentes

1. **Est-ce que je peux utiliser l'IA pour rédiger, m'accompagner ou me supporter dans la création et la rédaction de mon journal ?**

    <span class="red-text">**NON.**</span> L'utilisation de l'IA, quels qu'en soient la forme et l'objectif de cette utilisation, est interdite pour ce travail. La politique du collège en matière de plagiat sera appliquée dans l'éventualité où je détecterais l'utilisation de l'IA dans votre journal.

2. **Est-ce que je dois tout documenter, même les petites commandes ?**

    Non. Concentrez-vous sur ce qui est nouveau, ce qui a posé problème, et ce qui était significatif dans votre démarche. Des commandes telles que `ls` ou `cd` ne méritent pas une entrée dans le journal.

3. **Est-ce que mon journal peut être en anglais ?**

    Non. La qualité du français est évaluée.

4. **Je peux inclure des captures d'écran ?**

    Oui, et c'est encouragé pour documenter les livrables (ex: capture d'écran du site en https, capture d'un ticket créé dans GLPI). Ne remplacez pas le texte par des captures, complémentez-le.