import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';

# Laboratoire 6
* * *
## Configuration de pare-feu

## Préalable(s)

- Avoir complété le laboratoire # 4

## Objectif(s)
- Octroyer un accès SSH au serveur Ubuntu **seulement** au poste de travail Windows 10.
- Octroyer un accès SSH au serveur Windows **seulement** au poste de travail Windows 10.
- Pemermettre aux clients du réseau local d'envoyer des *pings* aux serveurs.

* * *
## Schéma

<ThemedImage
    alt="Schéma"
    sources={{
        light: useBaseUrl('/img/Serveurs1/Laboratoire6_W.svg'),
        dark: useBaseUrl('/img/Serveurs1/Laboratoire6_D.svg'),
    }}
/>

* * *

## Étapes de réalisation

Dans ce laboratoire, nous prendrons pour acquis le poste de travail sous Windows 10 est celui de l'administrateur des serveurs. Ce poste de travail <mark>doit posséder une adresse IP fixe.</mark>

À titre d'exemple, voici les adresses IP que j'utiliserai pour mes exemples dans le cadre de ce laboratoire:

| Machine | Adresse IPv4 |
|:---------:|:--------------:|
| Windows Serveur 2022 | 192.168.21.20 |
| Ubuntu Serveur 24.04 LTS | 192.168.21.10 |
| Windows 10 | 192.168.21.110 (statique) |

### Windows Serveur

#### Préparation du serveur

- Si ce n'est pas déjà fait, assurez-vous que votre serveur Windows ait bien une adresse IP statique ainsi qu'un nom convenable (Pas WIN-8JHL1J92)

- Assurez-vous que votre serveur soit sur un profil de connexion privé.

#### Installation du service SSH sous Windows

- Nous allons à présent installer un service SSH sur notre serveur Windows. Cela dit, ce service ne devra être accessible que par le poste de travail Windows 10 (le poste de l'administrateur). Ouvrez le panneau des parmètres Windows et dirigez-vous dans la section « Applications ». De là, cliquez sur « Fonctionnalités facultatives » puis « Ajouter une fonctionnalité ».

![Installation SSH](../Assets/06/InstallSSH.png)

- Dans la liste des fonctionnalités qui sont disponibles, installez la fonctionnalité « Serveur OpenSSH ». Une fois installé, ce service nous permettra d'atteindre la ligne de commande du serveur à distance.

#### Ajustement des règles du pare-feu (SSH)

- Si vous ne faites aucune modification, quiconque possédant un compte et un mot de passe sur le serveur pourrait s'y connecter en utilisant le protocole SSH, et ce, depuis n'importe quel poste. Ce que nous souhaitons faire ici, c'est non seulement autorisé la connexion seulement aux gens possédant un compte et un mot de passe, mais en plus, limiter l'accès depuis un seul poste.

- Ouvrez les règles du pare-feu Windows en tapant la commande `wf.msc` depuis la fenêtre « Exécuter » que vous pouvez ouvrir à l'aide du raccourci clavier <kbd>&#8862; win</kbd>+<kbd>r</kbd>. Dans les règles de trafic entrant, repérez cette règle:

    ![OpenSSHRule](../Assets/06/OpenSSHRule.png)

    Ouvrez les propriétés de la règle en effectuant un clic à l'aide du bouton de droite de votre souris sur celle-ci et en sélectionnant « propriétés ».

- Dans les propriétés, sélectionnez l'onglet « Étendue » et modifiez la section « Adresse IP distante » pour n'autorisez que l'adresse IP du poste de travail sous Windows 10.

    ![RegleWindowsOpenSSH](../Assets/06/RegleWindowsOpenSSH.png)

    > *Oui mais Gabriel, qu'en est-il des Adresses IP locales dans l'onglet étendue ? Doit-on également mettre une adresse IP particulière ici ?*
    >
    > *-Les étudiants*

    Cette fenêtre réfère aux adresses IP impliquées lors de la connexion à travers le pare-feu. Il y a l'adresse IP qui tente de se connecter, l'adresse IP distante (le pc distant si vous préférez) et il y a l'adresse IP local, c'est-à-dire l'adresse IP concernée sur le serveur qui offre le service.

#### Ajustement des règles du pare-feu (Ping)

Ce que l'on nomme un « PING », c'est l'envoi d'un paquet très rudimentaire afin de valider la bonne connectivité entre deux éléments du réseau. Le « PING » utilise le protocole icmpv4 pour fonctionner. Le pare-feu de Windows Serveur bloque ce protocole par défaut. Il nous faut donc autoriser celui-ci:

- Ouvrez les règles du pare-feu Windows en tapant la commande `wf.msc` depuis la fenêtre « Exécuter » que vous pouvez ouvrir à l'aide du raccourci clavier <kbd>&#8862; win</kbd>+<kbd>r</kbd>. Dans les règles de trafic entrant, repérez cette règle:

    ![RegleICMPv4Win](../Assets/06/RegleICMPWindows.png)

    Ouvrez les propriétés de la règle en effectuant un clic à l'aide du bouton de droite de votre souris sur celle-ci et en sélectionnant « propriétés ».

- Dans les propriétés, sélectionnez l'onglet « Étendue » et modifiez la section « Adresse IP distante » pour autoriser le sous-réseau local en entrant l'adresse `192.168.21.0/24`

- Appliquez vos modifications et activez la règle. 

#### Démarrage du service SSH

Bien que vous ayez installé la fonctionnalité nécessaire à l'utilisation du protocole SSH, le service lui, n'est pas démarré. Pour démarrer le service, utilisez la commande Powershell suivante:

```Powershell
Get-Service sshd | Start-Service
```

Si vous désirez faire en sorte que le service démarre automatiquement lorsque le serveur démarre, passez le démarrage de celui-ci en mode automatique grâce à la commande suivante:

```Powershell
Get-Service sshd | Set-Service -StartupType Automatic
```

#### Tentative de connexion

La première étape avant de vous connecter au serveur à l'aide du protocole SSH consiste à vérifier si vous êtes en mesure de communiquer avec ce-dernier. C'est exactement l'utilité de la commande `ping`: vérifier la capacité de deux hôtes de communiquer entre eux via le réseau.

Ouvrez donc un terminal sous votre poste de travail Windows 10 et tapez la commande suivate:

```Powershell
Test-NetConnection 192.168.21.20
```

Si tout est fonctionnel, vous devriez obtenir un résultat similaire à celui-ci:

![ResultatPing](../Assets/06/TestNetConnection.png)

Une fois que vous aurez confirmé que la communication entre les deux hôtes fonctionne bien, tentez d'ouvrir une session SSH, depuis votre poste de travail sous Windows 10, vers votre serveur 2022. Pour ce faire, entrez la commande suivante:

```Powershell
ssh Administrateur@192.168.21.20
```
:::important
<u>Si vous vous branchez au serveur à distance pour la première fois, vous obtiendrez ce message:</u><br/><br/>

![PremiereConnexion](../Assets/06/fisrtSSH.png)

Ce message stipule que l'ordinateur auquel vous vous connectez n'est pas reconnu. C'est normal dans ce cas-ci puisque nous nous y sommes jamais connecté. Vous devez donc confirmer que vous désirez bien vous y connecter en entrant la réponse `yes` à la question. Sachez cependant que si vous obtenez ce message alors que ce n'est pas la première fois que vous vous connectez au serveur, il pourrait y avoir un enjeu de sécurité.
:::

Lorsque votre sessions SSH sera bien lancée, vous devriez obtenir une ligne de commande semblable à celle-ci:

![WindowsSessionSSH](../Assets/06/WinSessionSSH.png)

Toutes les commandes lancées sur ce terminal seront exécutées sur le serveur à distance.

### Serveur Linux