# Utilisateurs et groupes 👨‍👩‍👧‍👦

## Système multi-utilisateur

Windows est un système d'exploitation de type multi-utilisateur. Cela implique différentes notions:

1. Un ou plusieurs utilisateurs pourraient être définis comme des administrateurs. Le rôle d'administrateur permet d'entreprendre des opérations qui peuvent engendrer des conséquences positives ou négatives sur le système. Nous nous attarderons aux différents rôles que peuvent posséder les utilisateurs ultérieurement.

2. La notion de propriété sera également importante dans un système de ce type. Les utilisateurs qui créent des dossiers et des fichiers en seront automatiquement les propriétaires. En tant que propriétaires d'un item, ils pourront décider, si oui ou non, ils désirent en partager son contenu avec les autres.

3. Il sera possible de regrouper des utilisateurs d'entre eux et de former des groupes. Les groupes nous permettent d'autoriser ou d'interdire des actions à plusieurs utilisateurs d'un seul coup. On forme généralement les groupes d'utilisateurs grâce à un lien qui les unit comme une profession, une responsabilité ou un rôle dans une entreprise.

## Les utilisateurs

Lors de l'installation de Windows, vous devrez créer un premier utilisateur. Windows 11 vous offrira d'abord et avant tout d'utiliser un compte Microsoft pour utiliser votre ordinateur. Même si, à première vue, l'utilisation d'un compte Microsoft peut paraitre intéressante, elle comporte certains inconvénients également.


![CompteMicrosoft](./Assets/09/CompteMicrosoft.png)

*Windows vous recommande d'utiliser un compte Microsoft à l'installation*

### Compte Microsoft

L'utilisation d'un compte Microsoft peut apporter certains avantages intéressants lorsqu'il est question de l'installation de Windows:

- **La synchronisation des paramètres:** Vos paramètres, thèmes, mots de passe et autres configurations sont synchronisés sur tous vos appareils Windows, ce qui facilite la transition d'un appareil à l'autre.

- **Accès aux services Microsoft:** Vous avez un accès direct à des services comme OneDrive, Microsoft Store, et Microsoft 365, ce qui peut améliorer votre expérience utilisateur.

- **Sécurité renforcée:** Un compte Microsoft offre des fonctionnalités de sécurité supplémentaires, comme la vérification en deux étapes, ce qui peut aider à protéger votre compte contre les accès non autorisés.

- **Mise à jour et support:** En utilisant un compte Microsoft, vous recevez plus facilement des mises à jour et un meilleur support pour les applications et les fonctionnalités liées à Microsoft.

Néanmoins, ces avantages s'accompagnent également d'inconvénients à ne pas négliger:

- **Dépendance à internet:** Pour profiter pleinement des avantages d'un compte Microsoft, une connexion Internet est souvent nécessaire, ce qui peut être un inconvénient dans certaines situations

- **Confidentialité:** L'utilisation d'un compte Microsoft implique un partage de données avec Microsoft, ce qui peut susciter des préoccupations en matière de confidentialité pour certains utilisateurs.

- **Complexité:** Pour certains utilisateurs, la gestion d'un compte Microsoft peut sembler plus complexe que l'utilisation d'un compte local, surtout s'ils ne sont pas familiers avec les services cloud.

- **Limitations d'un compte local:** Si vous utilisez un compte Microsoft, vous n'aurez pas la même flexibilité qu'avec un compte local en termes de contrôle total sur votre appareil. En effet, certains paramètres peuvent être automatiquement gérés ou modifiés par Microsoft, ce qui peut réduire votre contrôle sur l'expérience globale de votre appareil.

### Compte local

Vous l'aurez sans doute compris à travers les différents avantages et inconvénients que j'ai listés ci-dessus, le compte local est généralement plus facile d'utilisation et possède moins de dépendance. Le compte local n'a pas besoin d'internet et n'existe que dans l'ordinateur dans lequel vous le créer. C'est pourquoi nous utiliserons ce type de compte pour nos laboratoires.

:::note[Les comptes dans un contexte de laboratoire]
À travers vos différents laboratoires tout au long de vos études, vous aurez plusieurs laboratoires à réaliser et plusieurs ordinateurs à installer (virtuel ou non). Il est tout à fait inutile d'y relier votre compte Microsoft puisque vous ne bénéficierez pas toujours d'une connexion internet. Qui plus est, la majorité de ces machines de laboratoires seront détruites et réinstallées rapidement. Il est donc inutile d'y lier votre compte Microsoft.
:::

Ceci étant dit, Microsoft ne vous proposera pas, d'entré de jeu, de créer un compte local. Il faudra faire une petite « passe-passe ». 

1. Cliquez sur « Options de connexion » :

![OptionsdeConnexion](./Assets/09/OptionsConnexion.png)

2. Dans les options de connexion, cliquez sur « Joindre le domaine à la place » :

![JoindreDomaine](./Assets/09/JoindreDomaine.png)

3. De là, suivez les étapes proposées par l'installateur.

### Qui suis-je ?

Lorsque vous passez d'un utilisateur à l'autre dans le système, ou pour toute autre raison, vous pourriez ne plus vous souvenir avec quel utilisateur vous êtes connecté sur le système. La commande `whoami` vous retournera le nom de l'ordinateur sur lequel vous vous trouvez ainsi que l'utilisateur ayant entré la commande.

```Powershell
whoami
```

**Résultat:**

![whoami](./Assets/09/whoami.png)

### Le profil d'un utilisateur

Chaque utilisateur sur l'ordinateur, local ou non, possède ce que l'on nomme un profil d'utilisateur. Le profil d'un utilisateur est un ensemble de répertoires lui appartenant situé dans un répertoire parent à son nom dans `C:\Users\`. On retrouvera généralement les dossiers: Bureau, Contacts, Documents, Favoris, Images, Liens, Musique, Objets 3D, OneDrive, Parties enregistrées, Recherches, Téléchargements, Vidéos et AppData.

![ProfilUtilisateur](./Assets/09/Profil.png)

### Les comptes d'utilisateur prédéfinis

Même si vous avez créé votre premier utilisateur lors de l'installation de Windows 11, vous n'êtes pas seul au monde dans votre système d'exploitation (eh non!). Rassurez-vous, d'autres utilisateurs existent à votre insu. Ces utilisateurs, ce sont les utilisateurs prédéfinis. Ils ont été créés à l'installation de Windows, mais ils sont désactivés pour des raisons de sécurité, et ils le restent habituellement. Les comptes d'utilisateurs prédéfinis sont repérables depuis la console de gestion de l'ordinateur (clic-droit sur le menu démarrer, puis cliquez sur gestion de l'ordinateur ).

![UtilisateursPrédéfinis](./Assets/09/UtilisateursPredef.png)

- **Compte Administrateur:** Il s'agit d'un compte possédant des droits d'administration (évidemment) sur le système. Il est toujours présent dans chaque système mais son nom variera en fonction de la langue. Il est désactivé par défaut pour des raisons de sécurité, mais il est très facile de l'activer.

- **DefaultAccount:** C'est un compte système spécial créé à des fins internes, et il est inactif par défaut. Il n'est pas destiné à l'interaction directe de l'utilisateur et ne nécessite pas d'attention particulière sauf dans des cas très spécifiques de dépannage ou de configuration avancée.

- **Invité:** Le compte est invité est utilisé dans des cas où l'ordinateur concerné serait destiné à être utilisé par un large public. Par exemple dans le cas où un ordinateur serait en démonstration dans un kiosque ou dans le cas d'un ordinateur disponible dans un guichet libre-service.

- **WDAGUtilityAccount:** C'est un compte système utilisé spécifiquement pour Windows Defender, permettant l'exécution d'applications dans un environnement sécurisé et isolé. Ce compte n'est pas destiné à une utilisation par les utilisateurs, et son rôle principal est de contribuer à la sécurité du système en isolant les processus d'application afin de prévenir les risques d'attaque.

:::tip
Vous pouvez tout à fait lister les utilisateurs à l'aide de Powershell. Pour ce faire, nous utiliserons la commande `Get-LocalUser`.
:::