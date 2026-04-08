---
draft: true
---
import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Exercice 12

## Mise en place de stratégies de groupe

Dans cet exercice, vous aurez l'occasion d'exploiter diverses stratégies de groupe afin de vous familiariser avec celles-ci.

## Préalabes

Vous devez posséder une machine virtuelle sous Windows 11 24H2 opérationnelle. Importez un modèle au besoin.

## Étapes de réalisation

### **Sécurité du mot de passe 🔒**

Utilisez `secpol.msc` ou `gpedit.msc` pour appliquer les politiques suivantes:

    - Le mot de passe doit avoir une **longueur minimal de 10 caractères**
    - Le mot de passe doit **respecter des critères de compléxité**
    - L'historique des mots de passe doit empêcher la réutilisation des **5 derniers mots de passe**

### **Verrouillage du compte 🔐**

Configurez les options suivantes:

- Après **3 tentatives** de connexion échouées, le compte est verrouillé
- Le verrouillage doit durer **15 minutes**
- Le compteur de tentatives est réinitialisé après **15 minutes**

### **Restrictions d'accès 🧼**

Trouvez comment empêcher l'accès au **panneau de configuration** pour tous les utilisateurs.
*indice: section utilisateur de `gpedit.msc`

### **Script de démarrage ⚙️** 

Créez un **script de démarrage** qui enregistre la date et l'heure du démarrage de l'ordinateur dans un fichier nommé `journaldedemarrage.txt` à la racine de `C:\`.

Exemple avec un script **batch** (*.bat*)

```batch
echo Démarrage le %DATE% à %TIME% >> C:\journaldedemarrage.tx
```

- Placez ce script dans le bon dossier
- Ajoutez-le dans les stratégies (ordinateur > scripts > démarrage)
- Redémarrez la machine pour valider l'exécution du script

### **Vérification des GPOs 🕵️**

Générez un rapport html à l'aide de la commande appropriée et assurez-vous d'y repérer les stratégies de groupe que vous avez appliquées.