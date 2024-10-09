# Processus 🕵️

## Qu'est-ce qu'un processus ?

Dans la section précédente, nous avons abordé ensemble les logiciels et les applications. Plus précisémment, nous avons vu comment procéder à leur installation et leur désinstallation. Néanmoins, qu'en est-il de leur fonctionnement ? Que se produit-il dans le système lorsqu'on lance un logiciel ? C'est là que les processus interviennent.

Peut-être avez-vous déjà entendu le terme, peut-être pas. Cela dit, les processus existent depuis bien longtemps et ils ont toujours été juste sous vos yeux. En fait, tout ce qui s'exécute sur un ordinateur, le fait au sein d'un processus. Donc, le processus, c'est d'abord un contenant, une espèce de boîte virtuelle si vous voulez.

Pourquoi a-t-on besoin des processus ? Pour plusieurs raisons:

1. **Multitâche:** Pouvez-vous seulement imaginer ce que serait d'utiliser un ordinateur en exécutant qu'un seul logiciel à la fois ? Ce serait incroyable fastidieux et pas du tout pratique. Les processus permettent à plusieurs programmes de s'exécuter simultanément. En d'autres mots, si tu es capable d'écouter de la musique tout en faisant quelques recherches sur le web pour compléter tes travaux sur *Microsoft Word*, c'est grâce aux processus.

2. **Isolation:** Chaque processus est isolé des autres, c'est pourquoi je les compare à des contenants. Cela signifie qu'un programme ne peut pas en affecter un autre directement. Si un processus plante, il ne met pas à risque les autres processus, ce qui améliore de beaucoup la stabilité du système.

3. **Gestion des ressources:** Les processus aident à répartir efficacement les ressources (Puissance de calcul, mémoire, etc.) entre les différents programmes. Le système d'exploitation peut surveiller l'utilisation des ressources et en ajuster l'allocation en fonction des besoins des processus en cours d'exécution.

4. **Sécurité:** Les processus peuvent être exécutés avec différents niveaux de privilège. Cela permet de protéger le système en limitant les actions que certains programmes peuvent effectuer, réduisant ainsi les risques de *malwares* ou de comportements indésirables.

### Comment ça fonctionne ?

<mark>Tout ce qui s'exécute sur le système, est systématiquement exécuté dans un processus.</mark> Même ce que pourrait lancer Windows, en arrière-plan, sera lancé dans un processus. Il n'y a donc rien à faire, pour créer un processus, outre que de lancer un exécutable. Peu importe de quoi il s'agit, un processus sera créé. Nous verrons un peu plus loin comment lister, administrer et gérer les différents processus dans votre système Windows. Nous verrons également que chaque processus existant est identifié par le système d'exploitation.

## Le gestionnaire des tâches

Le gestionnaire des tâches, est à mon humble avis, un outil très pratique et indispensable pour tout bon technicien. Peut-être l'avez-vous déjà consulté ou utiliser sans même le savoir. Le gestionnaire des tâches est accessible de plusieurs façons:

- En utilisant le raccourci clavier <kbd>&#8862; win</kbd>+<kbd>r</kbd>, puis en tapant `taskmgr`

- En effectuant un clic à l'aide du bouton de droite de la souris sur la barre des tâches, puis en cliquant sur Gestionnaire des tâches.

- En utilisant le raccourci clavier <kbd>&#8862; win</kbd>+<kbd>⇧ Shift</kbd>+<kbd>⎋ Escape</kbd>

- En utilisant le raccourci clavier <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd>, puis en cliquant sur Gestionnaire des tâches.

Voici à quoi ressemble le gestionnaire des tâches une fois lancée:

![Gestionnaire des tâches](./Assets/06/Taskmgr.png)

## Section: Processus
Ce que vous voyez actuellement, ce sont la liste des processus présentemment en cours. Windows les sépare en deux grands types:

- **Les applications:** Ce sont les programmes ou les logiciels que vous avez vous-mêmes lancés. En s'exécutant, Windows leur a créé un processus et il se retrouve donc dans cette liste. Dans l'exemple ci-dessus, on voit que même le gestionnaire des tâches, que j'ai moi-même lancé possède son processus. Les processus qui se retrouvent sous cette section possèdent généralement une interface graphique avec laquelle vous interagissez.

- **Les processus en arrière-plan:** Ces processus n'interragissent habituellement pas avec vous. Il peut s'agir de services Windows, de mises à jour automatiques, d'applications se lançant au démarrage ou de tout autre tâche assurant le bon fonctionnement du système. Dans l'image ci-dessus, on peut remarquer que les deux premiers processus de cette section commence par le terme *antimalware*. Il s'agit en fait de *Windows Defender*, un service antiviral de Windows s'exécutant.

Pour chacun des processus listés, nous avons accès à différentes données concernant sa consommation de ressources (mémoire, puissance de calcul, stockage, etc.). Ces informations sont précieuses et nous permettent de garder un oeil sur ce qui tourne normalement ou anormalement sur votre pc. J'attire votre attention sur la ligne du navigateur *Microsoft Edge*. En un tour de main, je peux constater que ce processus utilise plus de 72% des ressources de calcul disponible, ainsi que plus d'un demi giga-octet de mémoire. C'est considérable.

![Processus Multiples](./Assets/06/ProcessusMulti%20.png)

Remarquez le nombre 17 (encerclé en rouge) à côté du processus *Microsoft Edge*. Il s'agit en fait, du nombre de processus regroupé sous un seul logiciel. Certains logiciels peuvent utiliser plus d'un processus pour fonctionner. Cela permet d'isoler certains aspects d'un même logiciel (des onglets, des modules complémentaires, etc.). Certains logiciels, dans la façon dont ils ont été développés et programmés, peuvent parfois utiliser plus d'un processus.

### Affichage en mode standard (onglet processus)

Il est possible de modifier les colonnes de données affichées dans le gestionnaire des tâches pour afficher les informations que l'on désir analyser. Voici l'ensemble des colonnes qu'il est possible d'afficher dans le gestionnaire des tâches:

![Colonnes Gestionnaire](./Assets/06/colonnes.png)

|Colonne|Données|
|:------------------:|---------------------|
| **Type** | Ce sont les deux grand types de processus, soit « Applications » ou « Processus en arrière-plan » |
| **Statut** | Cette colonne ne sera utilisée que lorsqu'un processus aura un statut autre que son statut normal (en cours d'exécution). Par exemple, lorsqu'un processus *gèle*, la mention « **Ne répond pas** » apparaitra.<br/><br/> Certains processus afficheront un statut « **Mode efficacité** » accompagné d'une petite feuille verte 🍃 lorsque le système d'exploitation aura suspendu celui-ci ou une partie de celui-ci pour économiser de l'énergie.<br/><br/> Dans un même ordre d'idée, un processus pourrait afficher un statut « **interrompu** » afin que le système puisse économiser des ressources et de l'énergie. |
| **Éditeur** | L'entreprise propriétaire de l'exécutable lancé au sein du processus |
| **PID** | Il s'agit du « Process ID » l'identifiant unique du processus concerné. Chaque processus s'en voit attribuer un dès sa création. |
| **Nom du processus** | Il s'agit en fait du nom de l'exécutable qui a provoqué la création du processus concerné. |
| **Ligne de commande** | C'est la ligne de commande, incluant l'exécutable, qui a provoqué la création du processus concerné. |
| **Processeur, Mémoire, Disque, Réseau et Processeur graphique** | L'utilisation, en valeurs informatiques ou en pourcentage, des différentes ressources qu'un processus utilise|
| **Moteur de processeur graphique** | Cette colonne se concentre sur les différents moteurs de traitement du GPU (Processeur graphique). Les GPU modernes ont plusieurs "moteurs" spécialisés pour différentes tâches, comme le traitement graphique, le calcul ou l'IA. La colonne indique quel moteur est en cours d'utilisation et à quel pourcentage.|
| **Consommation d'énergie et Tendance de consommation d'énergie** | La colonne « Consommation d'énergie » permet de voir la consommation d'énergie d'un processus en temps réel.<br/><br/> La tendance de consommation d'énergique, quant à elle, t'indiquera la consommation d'énergie d'un processus échelonnée sur quelques minutes. |


### Affichage en mode détails (onglet détails)

L'onglet *Détails* du gestionnaire des tâches permet d'obtenir de nombreux détails rapidements quant aux différents processus en cours d'exécution.

![Onglet Détails](./Assets/06/Details.png)

De la même façon dont nous avons géré l'affichage des différentes colonnes dans l'onglet *processus*, l'affichage dans l'onglet *détails* est également ajustable. Vous n'avez qu'à effectuer un clic à l'aide du bouton de droite de la souris sur l'une des en-têtes de colonnes et sélectionnez les champs qui vous intéressent. Par exemple, le champ `élevé` vous permet de savoir si un processus bénéficie de privilèges administratifs pour s'exécuter.

### Fin de tâche et nouvelle tâche

Dans les différentes sections du gestionnaire des tâches que nous avons abordé jusqu'à maintenant, vous aurez peut-être remarqué la présence de deux boutons:

- Exécuter une nouvelle tâche

- Terminer une tâche

![Boutons](./Assets/06/NewTaskEndTask.png)

#### Exécuter une nouvelle tâche

Ce bouton est l'équivalent du raccourci clavier <kbd>&#8862; win</kbd>+<kbd>r</kbd>. Il permet de lancer un exécutable (et donc la création d'un processus) rapidement. Si vous y entrez le chemin d'un exécutable, celui-ci se lancera et un processus sera automatiquement créé.

**Exemple:**

![ExecCMD](./Assets/06/ExecCMD.png)

:::caution
Si vous prenez soin de cocher la case encerclé en rouge dans l'image ci-dessus, l'exécutable sera lancé en tant qu'Administrateur. À condition que vous possédiez ces droits évidemment.
:::

**Résultat:**

![ExecCMDResult](./Assets/06/ExecCMDResult.png)

#### Mettre fin à une tâche

Mettre fin à une tâche est une opération à entreprendre avec parcimonie. En effet, mettre fin à une tâche permet de « forcer » la fermeture d'un processus et donc, de ce qui s'exécute à l'intérieur de celui-ci également.

:::danger
N'utilisez la fin de tâche qu'en dernier recours! Lorsque vous fermez un logiciel normalement, certaines actions peuvent s'exécuter en arrière-plan avant sa fermeture (une sauvegarde de fichier, une opération dans le registe, etc.), lorsque vous faites une fin de tâche, le processus se ferme immédiatement, sans donner la chance au logiciel d'exécuter ces dernières tâches. Cette action peut parfois engendrer des conséquences importantes.
:::

## Section : Performance

La section performance du gestionnaire des tâches vous permet de surveiller de près les différentes composantes de votre ordinateur.

![Onlget performance](./Assets/06/Performances.png)

Outre l'aspect visuel intéressant de pouvoir suivre les performances de l'ordinateur en temps réel, le moniteur de performance peut vous indiquer que quelque chose ne va pas avec votre ordinateur. Par exemple, un processeur dont le pourcentage d'utilisation est régulièrement, voire toujours, au dessus de 90% peut indiquer qu'un processus exploite beaucoup de puissance de calcul. Si vous n'avez lancé aucun exécutable, peut-être qu'un logiciel caché s'exécute à votre insu.

L'utilisation de la mémoire, quant à elle, peut aussi vous donner quelques indices. Une utilisation élevée de la mémoire peut indiquer que vous exécutez trop de logiciels à la fois ou que votre ordinateur ne possède pas suffisamment de mémoire pour combler vos besoins.

Vous aurez accès à d'autres informations pertinentes telle que l'utilisation des stockage en lecture et en écriture, ainsi que l'utilisation de votre connexion réseau en envoi et en réception.

## Gestion des processus en Powershell

PowerShell permet également d'administrer les processus sous Windows. Analysons quelques commandes pour arriver à nos fins.

### Lister les processus

Pour lister les processus, nous utiliserons la commande `Get-Process`

**Exemple:**

```Powershell
Get-Process
```

**Résultat:**

![ResultatGetProcess](./Assets/06/GetProcess.png)

Encore une fois, plusieurs éléments sont affichés dans le résultat. Voici une brève description pour chacun des éléments:

| Élément | Description |
|:-------:|-------------|
| Handles | Il s'agit du nombre de "poignées" que le processus utilise. Les poignées sont des références aux ressources du système comme les fichiers ouverts, les threads (instructions) ou les connexions réseau.|
| NPM(K) | La mémoire non paginée utilisée par le processus. C'est une portion de la mémoire qui ne peut pas être déplacée sur le disque dur, elle doit rester en mémoire vive (RAM). La valeur est en kilo-octets.|
| PM(K) | La mémoire paginée utilisée par le processus. Contrairement à la mémoire non paginée, celle-ci peut être temporairement déplacée sur le disque dur si nécessaire. La valeur est aussi en kilo-octets.|
| WS(K) | Le "Working Set" (ensemble de travail), c'est-à-dire la quantité de mémoire que le processus utilise actuellement dans la RAM. En d'autres termes, c'est la mémoire que le processus a activement en usage en ce moment.|
| CPU(s) | Le temps processeur utilisé par le processus, exprimé en secondes. Cela correspond au temps total durant lequel le processus a utilisé le CPU pour effectuer des calculs.|
| Id | L'ID du processus. C'est un identifiant unique attribué par le système pour chaque processus en cours d'exécution. Il permet de différencier les processus. |
| SI | Le numéro de session. Cela indique la session à laquelle appartient le processus, utile lorsqu'il y a plusieurs utilisateurs connectés sur un système.|

### Démarrer un processus

Pour démarrer un processus, il faut inévitablement lancer un exécutable. On le fera avec la commande `start-process`

**Exemple:**

```Powershell
Start-Process 'C:\Windows\System32\calc.exe'
```

**Résultat:**

![StartProcess](./Assets/06/StartProcess.png)

### Arrêter un processus

Pour arrêter un processus, l'idéal est d'avoir son identifiant unique en main. Pour cela, vous devrez possiblement utiliser la commande `Get-Process` au préalable. Une fois l'id en main, vous pourrez utiliser la commande `stop-process` pour mettre fin au processus.

**Exemple:**

```Powershell
Stop-Process 4388
```

**Résultat:**

![StopProcess](./Assets/06/StopProcess.png)