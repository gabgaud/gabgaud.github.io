import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 19

## Les serveurs d'impression 🖨

* * * 

### C'est quoi un serveur d'impression ?


Un serveur d'impression est un ordinateur ou un équipement réseau qui :
- **Gère** l'envoi des travaux vers une ou plusieurs imprimantes.
- **Centralise** les demandes d'impression provenant de plusieurs utilisateurs.
- **Optimise** l'utilisation des imprimantes au sein des organisations ou des entreprises.

:::note[Cas typique]
Prenons l'exemple d'un bureau où travaillent 30 employés se partageant 5 imprimantes branchées sur le réseau. Plutôt que de configurer manuellement les imprimantes sur les 30 postes de travail, on configurera les imprimantes sur le serveur d'impression seulement, puis on les partagera sur le réseau, un peu de la même manière que l'on partage des dossiers.
:::

### Rôles du serveur d'impression

Le serveur d'impression agit comme un intermédiaire entre les postes qui envoient des travaux vers les imprimantes, et les imprimantes elles-mêmes. Néanmoins, son rôle ne s'arrête pas simplement à relayer de l'information. En effet, le serveur d'impression gérera les pilotes nécessaires à l'utilisation des imprimantes ainsi que la file d'attente.

#### Focus sur les pilotes 👨‍✈️

Pour rappel, un pilote (*driver* en anglais) est un petit logiciel, généralement fourni par le fabricant du périphérique (imprimante, carte graphique, etc.) qui traduit les instructions du système d'exploitation en une suite d'instructions compréhensible pour le périphérique.

Par exemple, lorsqu'un étudiant imprime un document Word, l'ordinateur de l'étudiant n'envoie pas un fichier *.docx* à l'imprimante. Il envoie plutôt un flux d'instructions formatées selon le langage de l'imprimante, généré par le pilote.

Stocker les pilotes sur le serveur d'impression permet d'en faire l'installation qu'une seule fois, plutôt que d'installer les pilotes individuellement sur chaque poste.

#### La file d'attente ⏳

La **file d'attente** est une zone tampon dans la mémoire vive d'un PC (ou d'un serveur 😉) où sont stockés temporairement les travaux d'impression **en attente**, **en cours** ou **suspendus**.

:::tip[Le saviez-vous? 🐢]
La file d'attente a été créée dût à la lenteur des périphériques d'impression. Un ordinateur peut envoyer un document à l'impression en quelques millisecondes. Or, l'imprimante peut prendre plusieurs secondes, voire des minutes pour procéder à l'impression du document. Si l'ordinateur devait attendre que le document soit complètement imprimé avant de passer à autre chose, cela le rendrait très inefficace. Ainsi est né la file d'attente.
:::

La **file d'attente** fonctionne donc comme suit:

- Elle **tamponne** en mémoire les travaux d'impression.
- Elle **libère immédiatement l'application** (Word, Excel, etc.) après que l'utilisateur ait cliqué sur « Imprimer ».
- Elle **gère les priorités** lorsque plusieurs utilisateurs envoient des travaux en même temps.

Sous Windows, la file d'attente est géré par le service `Spooler` (Spouleur d'impression en français). Son rôle sera évidemment encore plus important dans la mise en place d'un serveur d'impression. 

Sous Linux, le nom du système responsable de la file d'attente se nomme **CUPS** (*Common UNIX Printing System*). **CUPS** joue non seulement le rôle de spouleur d'impression, mais il peut également prendre les rôles de serveur d'impression et de gestionnaire d'imprimantes.

### Composantes 🧩

Un environnement d'impression, qu'il soit personnel ou d'entreprise, repose sur plusieurs éléments qui coopèrent pour permettre l'envoi et la gestion des travaux d'impression. Analysons ces éléments ensemble:

#### L'imprimante physique

Sans grande suprise, si nous désirons mettre en place un serveur d'impression, il nous faudra des imprimantes 😂. Blagues à part, on retrouve plusieurs types d'imprimante physique sur le marché:

- **Jet d'encre**: Elles coûtent généralement moins chères à l'achat, mais les cartouches coûtent cher et peuvent sécher si elles ne sont pas suffisamment utilisées.
- **Laser**: Elles sont très présentes en entreprise. Elles se démarquent par leur rapidité et leur efficacité dans l'impression de grands volumes.
- **Multifonctions** : Impriment, numérisent, copient et faxent (...oui...le fax, je sais...)
- **Avec connexion réseau** : Ces imprimantes possèdent leur propre carte réseau et se voient donc octroyer une adresse IP.
- **Avec connexion locales** : Branchées directement sur un poste par un port USB.

#### L'imprimante logique

Une **imprimante logique** est une configuration logicielle qui représente une imprimante. Cette configuration possède:

- Un **nom** pour l'identification
- Un **pilote** qui s'occupe de traduire les données à imprimer
- Un **port** qui relie l'imprimante logique à l'imprimante physique
- Des **paramètres** (format papier, couleur, recto-verso...)

Par exemple, on pourrait configurer deux imprimantes logiques, avec des configuration disctintes (couleur, format de papier, etc.), pointant vers la même imprimante physique.

#### Les ports 🔌

Un **port d'impression** est le canal de communication par lequel les données sont envoyées à l'imprimante physique. Il en existe plusieurs types, dont les trois principaux:

- **USB**: Destinés aux imprimantes modernes, branchés localement.
- **LPT et COM**: Anciens ports paralèlles et séries (pratiquement disparus).
- **TCP/IP**: Pour les imprimantes qui sont dotés d'une interface réseau.

#### Les pilotes ⚙️

Les **pilotes d'imprimante** sont des petits logiciels installés dans le système d'exploitation. Comme nous l'avons mentionné un peu plus haut, leur rôle consiste à **traduire les commandes d'impression** dans un format compréhensible pour l'imprimante. Ceci étant dit, je prends soin d'aborder une nouvelle fois les pilotes puisqu'ils font également parties des composantes structurant l'imprimante logique.

#### Les utilisateurs 

Les utilisateurs possèdent des permissions sur les imprimantes. Parmi ces permissions, nous retrouverons:

- **Imprimer** (permission de base)
- **Gérer ses propres travaux d'impression** (annuler, suspendre...)
- **Gérer les travaux des autres** (habituellement réservé aux admins.)
- **Administrer l'imprimante** (changer les pilotes, paramètres, etc.)

### Examen du spouleur d'impression 🔨

Le **spouleur d'impression** (ou *print spooler* en anglais) est un service du système d'exploitation responsable de la **gestion des travaux d'impression en arrière-plan**. Il agit comme un intermédiaire logiciel qui reçoit les documents à imprimer, les places dans une file d'attente, et les envoie à l'imprimante lorsque celle-ci est prête.

Pour rappel, sous Windows ce service le nom de `Spooler`. Sous Linux, son équivalent le plus répandu est **CUPS** (*Common UNIX Printing System*).

#### Responsabilités principales

Voici ce que gère le spouleur d'impression:

- **Réception des travaux d'impression** depuis les applications.
- **Stockage temporaire** des travaux dans une file d'attente (souvent sous forme de fichiers `.SPL` et `.SHD` dans Windows).
- **Gestion de l'ordre d'impression** - généralement selon le principe **FIFO** (*First In, First Out*), c'est-à-dire que le **premier travail arrivé** sera le **premier imprimé**.
- **Envoi des travaux à l'imprimante** lorsqu'elle devient disponible.
- **Notification à l'utilisateur** en cas de problème (imprimante hors ligne, bourrage, plus de papier, etc.).

#### Et dans les coulisses

1. L'application **envoie le travail d'impression** au spouleur.
2. Le spouleur **convertit le document** via le pilote d'impression, puis le **place dans un fichier temporaire**.
3. Le document est mis en **file d'attente**.
4. Le spouleur attend que l'imprimante sois prête, puis **transmet les données**.
5. Une fois l'impression terminée, **les fichiers temporaires sont supprimés**.

#### Sur un serveur d'impression

Sur un **serveur d'impression,** le spouleur joue un rôle **encore plus central**. En outre, il doit **gérer des dizaines, voire des centaines de travaux simultanés** et permet **d'éviter la surcharge** des imprimantes ou de l'interface réseau.