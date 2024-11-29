# Processus 🕵️

## Qu'est-ce qu'un processus ?

Dans la section précédente, nous avons abordé l'installation de paquets et d'applications sous Linux. Néanmoins, qu'en est-il de leur fonctionnement ? Que se produit-il dans le système lorsqu'on lance un logiciel ? C'est là que les processus interviennent.

Peut-être avez-vous déjà entendu le terme, peut-être pas. Cela dit, les processus existent depuis bien longtemps et ils ont toujours été juste sous vos yeux. En fait, tout ce qui s'exécute sur un ordinateur, le fait au sein d'un processus. Donc, le processus, c'est d'abord un contenant, une espèce de boîte virtuelle si vous voulez.

Pourquoi a-t-on besoin des processus ? Pour plusieurs raisons:

1. **Multitâche:** Pouvez-vous seulement imaginer ce que serait d'utiliser un ordinateur en exécutant qu'un seul logiciel à la fois ? Ce serait incroyable fastidieux et pas du tout pratique. Les processus permettent à plusieurs programmes de s'exécuter simultanément. En d'autres mots, si tu es capable d'écouter de la musique tout en faisant quelques recherches sur le web, c'est grâce aux processus.

2. **Isolation:** Chaque processus est isolé des autres, c'est pourquoi je les compare à des contenants. Cela signifie qu'un programme ne peut pas en affecter un autre directement. Si un processus plante, il ne met pas à risque les autres processus, ce qui améliore de beaucoup la stabilité du système.

3. **Gestion des ressources:** Les processus aident à répartir efficacement les ressources (Puissance de calcul, mémoire, etc.) entre les différents programmes. Le système d'exploitation peut surveiller l'utilisation des ressources et en ajuster l'allocation en fonction des besoins des processus en cours d'exécution.

4. **Sécurité:** Les processus peuvent être exécutés avec différents niveaux de privilège. Cela permet de protéger le système en limitant les actions que certains programmes peuvent effectuer, réduisant ainsi les risques de *malwares* ou de comportements indésirables.

### Comment ça fonctionne ?
<mark>Tout ce qui s'exécute sur le système, est systématiquement exécuté dans un processus.</mark> Même ce que pourrait lancer Linux, en arrière-plan, sera lancé dans un processus. Il n'y a donc rien à faire, pour créer un processus, outre que de lancer un exécutable. Peu importe de quoi il s'agit, un processus sera créé. Nous verrons un peu plus loin comment lister, administrer et gérer les différents processus dans votre système Linux. Nous verrons également que chaque processus existant est identifié par le système d'exploitation.

## Lister les processus
Dans le terminal d'Ubuntu, vous pouvez utiliser la commande `ps` pour obtenir la liste des processus. En lien avec cette commande, certains commutateurs peuvent être très pratiques:

| Commutateur | Action |
|:-----------:|:------:|
| -a | Affiche les processus de tous les utilisateurs |
| -u | Affiche le propriétaire de chaque processus |
| -x | Affiche les processus en arrière-plan (lancé par le système) |

Exemple:<br/>
![Commande ps](./Assets/07/pscommandexemple.png)

La définition de chacune des colonnes du tableau est décrite ci-dessous:
| Colonne  | Signification                                                                                          |
|----------|-------------------------------------------------------------------------------------------------------|
| USER     | L'utilisateur ayant lancé le processus.                                                               |
| PID      | Identifiant unique du processus (Process ID).                                                         |
| %CPU     | Pourcentage d'utilisation du CPU par le processus.                                                    |
| %MEM     | Pourcentage de mémoire vive (RAM) utilisée par le processus.                                          |
| VSZ      | Taille virtuelle du processus en kilo-octets (inclut la mémoire des bibliothèques partagées).         |
| RSS      | Taille de la mémoire vive réellement utilisée (non paginée), en kilo-octets.                         |
| TTY      | Terminal associé au processus (`?` si le processus n'est pas lié à un terminal).                      |
| STAT     | État du processus (ex. `S` pour Sleeping, `R` pour Running) et attributs supplémentaires (ex. `s`).   |
| START    | Heure ou date de lancement du processus.                                                              |
| TIME     | Temps CPU total consommé par le processus (minutes:secondes).                                         |
| COMMAND  | Commande ou chemin complet utilisé pour lancer le processus.                                          |

### Inconvénient de PS
La commande `ps` ne permet pas de consulter les processus en temps réel. Elle se contente plutôt de prendre une photo des processus actifs sur le système à un instant *t*. Pour visualiser les processus en temps réel, vous pouvez utiliser la commande `top`. Cette dernière vous affichera la liste des processus qu'elle rafraichira régulièrement. Néanmoins, nous sommes encore loin de ce qu'offre le gestionnaire des tâches sous Windows. La commande `top` ne vous permettra pas de redémarrer ou d'arrêter un service.

Exemple de la commande *top*:
![ExempleTOP](./Assets/07/top.png)

### Filtrer avec grep
La commande `ps` avec, ou sans, commutateur pourrait vous donner une liste de résultat assez impressionnante. Après tout, si tout est exécuté dans un processus, il est normal d'en retrouver plusieurs dizaines. Je vous invite donc à jumeler le tout à la commande `grep` pour filtrer vos résultats. Par exemple, si je recherche un processus en lien avec l'éditeur de texte nano, je pourrais utiliser la commande suivante:

```bash
ps -ux | grep nano
```
Résultat:<br/>
![Commande ps grep](./Assets/07/psnano.png)

:::caution
Avez-vous remarqué quelque chose dans l'image ci-dessus ? Même si je n'ai démarré qu'une seule instance de *Nano*, j'obtiens deux résultats lorsque j'applique mon filtre avec `grep`. Pourquoi ?

<u>**Souvenez-vous: tout est exécuté au sein d'un processus!**</u>
<br/><br/>
La commande `grep` que j'ai utilisé pour filtrer la sortie de ma commande `ps` est, elle aussi, exécuté dans un processus. Donc lorsque je filtre les processus à la recherche d'un mot, je vois apparaitre le processus qui a été lancé pour `grep` également.
:::

## Administration
Vous savez, désormais, que pour démarrer un processus, il suffit de lancer n'importe quel exécutable. Celui-ci sera lancé automatiquement dans un processus. Cela dit, comment est-il possible de suspendre, d'arrêter ou de redémarrer un processus ? À l'aide de la commande `kill`.

La commande `kill` fonctionne en envoyant des signaux aux différents processus. Ces signaux 