# Cours 6

## Retour sur les services <FAIcon icon="fa-solid fa-gears" size="1x"/>
Lors du cours *systèmes d'exploitation*, vous avez appris ce qu'était un service dans le contexte d'un système d'exploitation. Pour rappel, un service est un programme qui s'exécute en arrière-plan. Ce type de programme n'a généralement pas été écrit pour favoriser l'interaction humaine. Parmi ces services, on retrouve certains des éléments clés du système.

:::tip[Le saviez-vous ?]
Sous Linux, les services sont parfois appelés « *daemons* ». C'est un nom d'origine grecque qui signifie divinité. C'est pourquoi on retrouve souvent la lettre « d » à la fin de leur nom: sshd, httpd, etc.
:::

### Windows Serveur <FAIcon icon="fa-brands fa-windows" size="1x"/>
Sous Windows Serveur, les services du système d'exploitation s'administrent exactement de la même façon que sur un poste Windows standard. Si vous avez besoin de vous rafraichir la mémoire quant à la gestion des services sous Windows, [consultez cette section.](/docs/OS/Windows/07-Services.md)

### Serveur Linux <FAIcon icon="fa-brands fa-linux" size="1x"/>
Il en va de même pour les services sous Linux. Qu'il s'agisse d'un système Ubuntu *desktop* ou d'un système serveur, l'administration des services se fait de la même façon. Vous avez besoin de vous rafraichir la mémoire quant à la gestion des services sous Linux ? [Consultez cette section.](/docs/OS/Linux/08-Services.md)

## Retour sur la journalisation <FAIcon icon="fa-solid fa-newspaper" size="1x"/>
La journalisation permet d'effectuer le suivi des services et des processus du système. Comme les processus et les services n'offrent généralement pas d'interface pour interragir avec eux, en faire le suivi et l'administration peut devenir un enjeu. La journalisation permet donc de conserver les traces du bon, ou du mauvais fonctionnement de ces services et de ces processus.

### Windows Serveur <FAIcon icon="fa-brands fa-windows" size="1x"/>
Sous Windows Serveur, tout comme sur les postes de travail, la majorité des journaux sont rapportés dans l'observateur d'événements. L'Observateur d'événements offre une interface graphique convivial et permet de manipuler les différents journaux assez aisément. Si vous avez besoin de vous remémorer le fonctionnement de la journalisation sous Windows, je vous invite à [consulter cette section](/docs/OS/Windows/08-Journalisation.md).

### Serveur Linux <FAIcon icon="fa-brands fa-linux" size="1x"/>
Sous Linux, les journaux ont longtemps été sauvegardés sous forme de fichier texte et disparates. D'ailleurs, beaucoup de journaux sous Linux fonctionnent de la sorte. Cela dit, l'arrivée de `systemd` a changé les choses une centralisation des journaux semblent s'installer. En effet, la commande `journalctl` semble nous permette d'atteindre à peu près n'importe quel journal stocké au sein du système. Si vous avez besoin de vous raraichir la mémoire quant au fonctionnement de la journalisation sous Linux, je vous invite à [consulter cette section](/docs/OS/Linux/09-Journalisation.md).

## Pare-feu <FAIcon icon="fa-solid fa-fire" size="1x"/>

Qu'il s'agisse du pare-feu sous Windows ou sous Linux, le pare-feu a toujours le même objectif: filtrer le traffic entrant et sortant.

>*Oui mais Gabriel, à quoi ça sert de filtrer le traffic d'un ordinateur ?*
>
>*-Les étudiants*

C'est une question légitime! En gros c'est surtout une méthode de protection supplémentaire. Disons que votre maison possède 3 portes permettant d'y entrer. Peut-être que vous partagerez votre clé de maison avec certaines personnes, alors que vous demanderez à d'autres de cogner et d'attendre une réponse. C'est un peu l'équivalent avec votre ordinateur, mais au lieu de ne posséder que 3 portes, votre PC en possède 65 535 🤯 (Oui, je suis sérieux.)

Ça fait beaucoup de portes à surveiller, j'en conviens. Ces portes, on les appelle, en fait, des ports réseaux. Chacun de ces ports permet de laisser entrer, ou sortir, des paquets de votre PC vers le réseau et vice-versa. La grande majorité de ces ports sont fermés et le resteront. Toute tentative d'accéder à votre PC via ses ports sera vouée à l'échec. Néanmoins, nous auront besoin de laisser d'autres ports ouverts afin d'utiliser un service, comme le SSH par exemple. Généralement, un service est associé à un port. Voici quelques exemples:

- Port 80 : HTTP (Navigation web sans chiffrement)
- Port 443 : HTTPS (Navigation web sécurisée)
- Port 22 : SSH (Accès au terminal à distance)
- Port 21 : FTP (Transfert de fichier d'un PC à un autre)
- Port 53 : DNS (Résolution de noms)

Les configurations d'un pare-feu, permettront donc, d'autoriser ou de refuser le traffic sur un port (une porte 🚪)  de votre PC.

### Windows Serveur <FAIcon icon="fa-brands fa-windows" size="1x"/>

Sous Windows, le pare-feu se nomme « Pare-Feu Windows Defender » et il comporte 3 profils par défaut:

| Profil                | Type de réseau | Utilisation principale                                    |
|-----------------------|----------------|-----------------------------------------------------------|
| **Domaine**           | Réseau d'entreprise |Sécurisation des appareils dans un environnement contrôlé. |
| **Privé**             | Réseau domestique |Sécurisation des connexions dans un environnement de confiance. |
| **Public**            | Réseau ouvert |Protection maximale contre les menaces sur des réseaux non sécurisés. |

À chacun de ces profils, des règles par défaut seront appliquées. Évidemment, plus le réseau est considéré insécure, plus les règles seront strictes. Toutes ces règles, peu importe le profil dans lequel vous vous trouvez, sont modifiables.

#### Récupérer votre profil de connexion

Il est possible de connaître le profil de connexion dans lequel vous vous trouvez à l'aide d'une petite commande PowerShell:

```Powershell
Get-NetConnectionProfile
```
Vous obtiendrez alors un résultat similaire à celui-ci:

![ProfileDeConnexion](../Assets/06/NetworkProfile.png)

#### Modifier votre profil de connexion

Un peu de la même façon, vous pouvez modifier votre profile de connexion à l'aide de la commande PowerShell `Set-NetConnectionProfile`:

```Powershell
Set-NetConnectionProfile -NetworkCategory "Public"
```
Voici le résultat:

![ChangeProfile](../Assets/06/ChangeProfile.png)

#### Accéder aux règles
Pour accéder rapidement aux règles du pare-feu sous Windows, ouvrez la fenêtre « Exécuter » à l'aide du raccourci clavier <kbd>&#8862; win</kbd>+<kbd>r</kbd> et tapez la commande `wf.msc`

Une fois là, vous serez à un clic de voir les règles du pare-feu Windows:

![Parefeu Windows](../Assets/06/PareFeuWindows.png)

:::caution
Pour savoir si c'est une règle entrante ou sortante que vous devez modifier, il faut se demander si c'est vous qui offrez un service (entrant) ou si vous voulez plutôt rejoindre un service qui est offert par un autre PC/serveur (sortant).
:::

Que vous alliez voir les règles entrantes ou sortantes, vous devriez avoir un affichage similaire à celui-ci:

![Règles](../Assets/06/Règles.png)

Je vous résume les différentes informations affichées dans ce tableau:

| Colonne | Description |
|---------|-------------|
| Crochet vert ✅ | Si vous repérez un crochet vert avant le nom de la règle, cela signifie que la règle est active et que le filtrage du port en question s'exécute. |
| Nom | C'est le nom de la règle, tout simplement. |
| Groupe | Certaines règles peuvent être regroupées ensemble par logique. C'est le cas notamment du partage de fichiers et d'imprimantes. On regroupe les règles qui ont un lien entre elles pour en faciliter la gestion.|
| Profil | Il s'agit du ou des profils sur lesquels la règle concernée s'applique. Si le mot « tout » est inscrit, cela veut dire que la règle affectera les 3 profils.|
| Activée | C'est l'équivalent du crochet vert. Cette colonne indique si la règle s'applique actuellement.|
| Action | L'action que la règle applique. Celle-ci doit être en condordance avec le comportement par défaut du pare-feu. Par exemple, si le comportement par défaut du Pare-Feu est de bloquer tout les paquets à l'exception de ce qui est spécifiquement autorisé, il est inutile de créer des règles dont l'action est de bloquer puisque c'est déjà ce que fera le pare-feu par défaut.|
| Remplacer | La colonne remplacer indique si le remplacement de la règle est autoriser lorsqu'une seconde correspondant aux mêmes critères est créée. |
| Etc... | Plusieurs autres colonnes vous affiche de l'information concernant chacune des règles, à vous des les consulter 😉|

#### Créer une règle

La grande majorité du temps, il existe une règle prédéfini pour répondre à un besoin. Dès lors, tout ce qu'il vous reste à faire, c'est appliq