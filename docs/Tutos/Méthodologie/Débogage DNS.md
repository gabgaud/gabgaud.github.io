import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Débogage : Problèmes DNS

Le service DNS est souvent le coupable silencieux des pannes réseau. Le débogage nécessite d'isoler le client, le cache, le serveur local et les redirecteurs (*forwarders*). À cela s'ajoutent d'autres éléments si vous avez plus d'un serveur DNS (primaire/secondaire).

## Étape 0 : Ne supposez rien!

Une grande majorité des erreurs en réseau vient simplement du fait que les étudiants tiennent un certain nombre d'éléments pour acquis. Dans les 15 dernières années, en tant qu'enseignant, l'une des phrases que j'ai entendues le plus souvent dans ma vie est sans doute :

>*Je suis certain que ___________ est bien configuré, Monsieur.*
>
>*- Un étudiant trop sûr de lui*

<span class='red-text'>**Ne tenez jamais rien pour acquis et ne supposez jamais qu'un élément de base est bien configuré parce que vous l'avez configuré maintes fois.**</span> J'ai plusieurs années d'expérience en informatique et il m'arrive encore de faire des fautes de frappe dans mes adresses IP...

Revérifiez tout!

---

## Étape 1 : Validation de la configuration IP du client

Vérifiez la configuration IP du client avec lequel vous tentez de résoudre un nom de domaine. Assurez-vous que l'adresse IP du serveur DNS soit présente et qu'elle pointe bel et bien vers **votre** serveur DNS local (et non celui de la passerelle ou un DNS public comme `8.8.8.8`, à moins que ce ne soit le but).

- **Sous Windows :** Utilisez `ipconfig /all` et cherchez la ligne *Serveurs DNS*.
- **Sous Linux :** Utilisez `cat /etc/resolv.conf` (cherchez la ligne *nameserver*).
- **Communication :** Assurez-vous que le client peut faire un `ping` vers l'adresse IP du serveur DNS. S'il n'y a pas de route, il n'y aura pas de résolution.

---

## Étape 2 : L'interrogation (Utiliser les bons outils)

<span class='red-text'>**Règle d'or :**</span> **N'utilisez jamais la commande** `ping` **pour déboguer un problème DNS.** La commande `ping` utilise le cache du système d'exploitation et peut masquer les erreurs réelles du serveur.

Utilisez les outils dédiés que nous avons vus en classe pour interroger directement le serveur :

1.  **Commencez par tester le serveur local :** Forcez votre outil à interroger spécifiquement votre serveur pour une zone locale. La syntaxe de la commande est identique sous Windows et Linux :
    
    `nslookup pc1.mondomaine.local <IP_DE_VOTRE_SERVEUR>`  

2.  **Testez ensuite la résolution externe :** Demandez à votre serveur de résoudre un nom public (ex: `google.com`) pour vérifier si vos redirecteurs (*forwarders*) ou les serveurs racines fonctionnent.
---

## Étape 3 : Le piège du cache

Si vous venez de modifier un enregistrement sur votre serveur DNS mais que le client obtient toujours l'ancienne adresse IP, vous êtes victime du cache. **Videz toujours vos caches lors du débogage.**

- **Sous Windows :** Exécutez `ipconfig /flushdns`.
- **Sous Linux :** Selon votre distribution, exécutez `sudo resolvectl flush-caches` ou redémarrez le service de résolution local (`sudo systemctl restart systemd-resolved`).
- **Côté Serveur :** N'oubliez pas que le serveur DNS lui-même possède un cache pour les requêtes externes. Sous Windows Server, cliquez droit sur le serveur dans le gestionnaire DNS et choisissez "Effacer le cache". Sous Linux (BIND9), utilisez `sudo rndc flush`.

---

## Étape 4 : Inspection du service et des zones (Côté Serveur)

Si l'interrogation échoue, le problème se situe sur le serveur lui-même.

### 4.1 Serveur Windows
1. Ouvrez le gestionnaire DNS ou la console des services (`services.msc`) et assurez-vous que le service **Serveur DNS** est en cours d'exécution.
2. Vérifiez que votre serveur écoute sur la bonne interface (Propriétés du serveur > Onglet *Interfaces*).
3. Consultez l'observateur d'événements (*Journaux des applications et des services > Serveur DNS*).

### 4.2 Serveur Linux (BIND9 / named)
1. **État du service :** Assurez-vous que le service DNS s'exécute bien avec `sudo systemctl status named` (ou `bind9` selon la distribution).
2. **Journaux :** Dans le cas où le service ne tournerait pas (souvent à cause d'une erreur de frappe), vérifiez les derniers journaux pour trouver l'erreur exacte : `sudo journalctl -u named -n 50`
3. **Vérification de la syntaxe :** Avant de redémarrer le service, validez toujours vos fichiers :
   - Fichier de configuration principal : `sudo named-checkconf /etc/bind/named.conf`
   - Fichiers de zone : `sudo named-checkzone mondomaine.local /etc/bind/db.mondomaine.local`
4. **Le numéro de série (Serial) :** Lors de la modification d'un fichier de zone, **assurez-vous que le numéro de série a bien été incrémenté**. Si ce n'est pas fait, le serveur (et les serveurs secondaires) ignoreront vos modifications.

## Pour conclure

:::danger La Base
**Ne supposez rien !** Vérifiez toujours tout, même les éléments les plus basiques.
:::

<Tabs groupId="os-choice">
  <TabItem value="windows" label="Environnement Windows" default>

  | Étape | Objectif | Commandes / Actions |
  | :--- | :--- | :--- |
  | **1. IP du DNS** | Le client pointe-t-il vers le bon serveur ? | `ipconfig /all` <br/> *(Vérifier l'adresse IP dans la section Serveurs DNS)* |
  | **2. Interrogation** | Le serveur résout-il les requêtes ? | `nslookup pc1.mondomaine.local <IP_DU_SERVEUR>` <br/> *(Puis tester avec un domaine externe comme google.com)* |
  | **3. Cache** | Vider l'historique qui fausse les tests | **Client :** `ipconfig /flushdns` <br/> **Serveur :** Effacer le cache via la console du Gestionnaire DNS. |
  | **4. Service** | Le serveur tourne-t-il ? | Ouvrir `services.msc` > Vérifier l'état de **Serveur DNS** |
  | **5. Fichiers** | La syntaxe est-elle bonne ? | *Observateur d'événements > Journaux des applications et des services > Serveur DNS* |
  | **6. Serial** | Le transfert de zone fonctionne-t-il ? | Assurez-vous d'incrémenter ou de recharger la zone si vous modifiez manuellement des enregistrements. |

  </TabItem>
  <TabItem value="linux" label="Environnement Linux (BIND9)">

  | Étape | Objectif | Commandes / Actions |
  | :--- | :--- | :--- |
  | **1. IP du DNS** | Le client pointe-t-il vers le bon serveur ? | `cat /etc/resolv.conf` <br/> *(Vérifier l'adresse IP à la ligne nameserver)* |
  | **2. Interrogation** | Le serveur résout-il les requêtes ? | `nslookup pc1.mondomaine.local <IP_DU_SERVEUR>` <br/> *(Puis tester avec un domaine externe comme google.com)* |
  | **3. Cache** | Vider l'historique qui fausse les tests | **Client :** `sudo resolvectl flush-caches` <br/> **Serveur BIND9 :** `sudo rndc flush` |
  | **4. Service** | Le serveur tourne-t-il ? | `sudo systemctl status named` <br/> *(Ou vérifier les logs : `sudo journalctl -u named -n 50`)* |
  | **5. Fichiers** | La syntaxe est-elle bonne ? | **Conf :** `sudo named-checkconf /etc/bind/named.conf` <br/> **Zone :** `sudo named-checkzone mondomaine.local /etc/bind/db.mondomaine.local` |
  | **6. Serial** | Le numéro a-t-il été incrémenté ? | Vérifier le *Serial* au début du fichier de zone. **Il doit être augmenté à chaque modification !** |

  </TabItem>
</Tabs>