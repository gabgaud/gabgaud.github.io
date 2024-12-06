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

### Préparation du serveur Windows

- Si ce n'est pas déjà fait, assurez-vous que votre serveur Windows ait bien une adresse IP statique ainsi qu'un nom convenable (Pas WIN-8JHL1J92)

- Assurez-vous que votre serveur soit sur un profil de connexion privé.

### Installation du service SSH sous Windows

- Nous allons à présent installer un service SSH sur notre serveur Windows. Cela dit, ce service ne devra être accessible que par le poste de travail Windows 10 (le poste de l'administrateur). Ouvrez le panneau des parmètres Windows et dirigez-vous dans la section « Applications ». De là, cliquez sur « Fonctionnalités facultatives » puis « Ajouter une fonctionnalité ».

![Installation SSH](../Assets/06/InstallSSH.png)

- Dans la liste des fonctionnalités qui sont disponibles, installez la fonctionnalité « Serveur OpenSSH ». Une fois installé, ce service nous permettra d'atteindre la ligne de commande du serveur à distance.

### Ajustement des règles du pare-feu

- Si vous ne faites aucune modification, quiconque possédant un compte et un mot de passe sur le serveur pourrait s'y connecter en utilisant le protocole SSH, et ce, depuis n'importe quel poste. Ce que nous souhaitons faire ici, c'est non seulement autorisé la connexion seulement aux gens possédant un compte et un mot de passe, mais en plus, limiter l'accès depuis un seul poste.

- Ouvrez les règles du pare-feu Windows en tapant la commande `wf.msc` depuis la fenêtre « Exécuter » que pouvez ouvrir à l'aide du raccourci clavier <kbd>&#8862; win</kbd>+<kbd>r</kbd>. Dans les règles de trafic entrant, repérez cette règle:

    ![OpenSSHRule](../Assets/06/OpenSSHRule.png)

    Ouvrez les propriétés de la règle en effectuant un clic à l'aide du bouton de droite de votre souris sur celle-ci et en sélectionnant « propriétés ».

- Dans les propriétés, sélectionnez l'onglet « Étendue » et modifiez la section « Adresse IP locale » pour n'autorisez que l'adresse IP du poste de travail sous Windows 10.

    ![RegleWindowsOpenSSH](../Assets/06/RegleWindowsOpenSSH.png)

    > *Oui mais Gabriel, qu'en est-il des Adresses IP distantes dans l'onglet étendue ? Doit-on également mettre une adresse IP particulière ici ?*
    >
    > *-Les étudiants*

    On les appelle des adresses IP distantes pour une raison bien simple: Elles ne font pas parties du réseau local. Dans ce cours, Serveurs 1, nous nous préoccupons surtout du réseau local. Pour l'instant, vous n'avez rien à modifier dans la section « Adresse IP distante ».

### Démarrage du service SSH

Bien que vous ayez installé la fonctionnalité nécessaire à l'utilisation du protocole SSH, le service lui, n'est pas démarré. Pour démarrer le service, utilisez la commande Powershell suivante:

```Powershell
Get-Service sshd | Start-Service
```

Si vous désirez faire en sorte que le service démarre automatiquement lorsque le serveur démarre, passez le démarrage de celui-ci en mode automatique grâce à la commande suivante:

```Powershell
Get-Service sshd | Set-Service -StartupType Automatic
```

### Tentative de connexion

Depuis le poste de travail sous Windows 10, tentez d'ouvrir une session via SSH sur votre serveur 2022. Pour ce faire, entrez la commande suivante:

```Powershell
ssh Administrateur@192.168.21.20
```