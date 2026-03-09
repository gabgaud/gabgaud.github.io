import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Débogage : Problèmes DHCP

Le service DHCP est devenu essentiel à nos vies. Lorsque celui-ci ne fonctionne plus, c'est un problème critique, car il isole complètement les appareils du reste du réseau. Sur cette page, je vous explique comment procéder au débogage de ce service de manière structurée.

## Étape 0 : Ne supposez rien!

Une grande majorité des erreurs en réseau vient simplement du fait que les étudiants tiennent un certain nombre d'éléments pour acquis. Dans les 15 dernières années, en tant qu'enseignant, l'une des phrases que j'ai entendues le plus souvent dans ma vie est sans doute :

>*Je suis certain que ___________ est bien configuré, Monsieur.*
>
>*- Un étudiant trop sûr de lui*

<span class='red-text'>**Ne tenez jamais rien pour acquis et ne supposez jamais qu'un élément de base est bien configuré parce que vous l'avez configuré maintes fois.**</span> J'ai plusieurs années d'expérience en informatique et il m'arrive encore de faire des fautes de frappe dans mes adresses IP...

---

## Étape 1 : Inspection côté client

La première étape consiste à vérifier ce que le client perçoit de la situation.

### Sous Windows
- Vérifiez si vous avez une adresse APIPA (`169.254.x.x/16`). Si c'est le cas, le client tente de joindre le DHCP en envoyant des trames de diffusion (Broadcast), mais personne ne lui répond.
- Videz d'abord l'ancienne configuration avec `ipconfig /release`.
- Tentez de relancer le processus avec `ipconfig /renew`.
- *Astuce :* Si le câble est débranché ou la carte réseau virtuelle désactivée, Windows affichera « Média déconnecté ».

### Sous Linux
Bien que Linux n'utilise pas le protocole APIPA par défaut, le principe reste le même.
- Identifiez votre interface avec `ip a` (ex: `ens18`, `eth0`, `enp0s3`).
- Libérez le bail DHCP actuel : `sudo dhclient -r ens18`
- Forcez une nouvelle demande : `sudo dhclient -v ens18` (le `-v` pour *verbose* vous permettra de voir exactement à quelle étape du processus DORA le client bloque).

---

## Étape 2 : Inspection de l'état du service (Serveur)

Si le client fait bien son travail, il faut s'assurer que le serveur est éveillé et à l'écoute.

### Sous Windows Server
- Ouvrez `services.msc` ou utilisez PowerShell : `Get-Service DHCPServer`.
- Vérifiez que le statut est **« En cours d'exécution »** et que le type de démarrage est **« Automatique »**.
- Assurez-vous que le serveur DHCP est **autorisé** dans l'Active Directory (si applicable). Un serveur non autorisé refusera de distribuer des adresses.

### Sous Linux (Kea DHCP)
- Vérifiez le statut du service IPv4 : `sudo systemctl status kea-dhcp4-server`
- Si le service est en échec (*failed*), c'est extrêmement fréquent que la cause soit une erreur de syntaxe dans votre fichier JSON (une virgule manquante ou en trop, une accolade mal fermée).
- **Vérifiez toujours la syntaxe JSON** avant de redémarrer le service avec la commande native de Kea : 
  `sudo kea-dhcp4 -t -c /etc/kea/kea-dhcp4.conf`

---

## Étape 3 : Analyse des journaux (Logs)

Un administrateur réseau lit les journaux. C'est là que le serveur explique pourquoi il refuse de travailler.

- **Windows :** Ouvrez l'Observateur d'événements (`eventvwr.msc`). Allez dans *Journaux des applications et des services > Microsoft > Windows > DHCP-Server > Opérationnel*. 
- **Linux (Kea DHCP) :** Contrairement à l'ancien ISC, Kea possède un système de journalisation très paramétrable (les *loggers* dans le fichier JSON). 
  - Par défaut, consultez les journaux systemd en temps réel : `sudo journalctl -u kea-dhcp4-server -f`
  - Si vous avez configuré Kea pour écrire dans un fichier spécifique, surveillez ce fichier : `tail -f /var/log/kea/kea-dhcp4.log`
  - Vous y verrez les messages clés de l'allocation : `DHCP4_DISCOVER`, `DHCP4_OFFER`, etc.

---

## Étape 4 : Analyse de l'étendue (Subnet) et des options

Si le service tourne et qu'il n'y a pas d'erreurs majeures dans les journaux, le problème est logique.

- **Le bassin (*pool*) d'adresses est-il épuisé ?** S'il n'y a plus d'adresses disponibles, Kea ignorera les requêtes (cherchez les avertissements `DHCP4_PACKET_DROP_0001` dans les logs).
- **Les options DHCP sont-elles bien configurées dans votre bloc de sous-réseau (subnet4) ?**
    - `routers` (Passerelle par défaut) ?
    - `domain-name-servers` (Serveurs DNS) ?

---

## Étape 5 : L'environnement virtuel (vSphere)

Puisque nous travaillons dans un environnement virtualisé avec vSphere, il est très fréquent que le problème ne vienne ni de Windows, ni de Linux, mais de la configuration de la machine virtuelle elle-même. Si le client et le serveur ne peuvent pas communiquer "physiquement", le DHCP ne fonctionnera jamais.


Dans vSphere Client, faites un clic droit sur votre machine virtuelle et sélectionnez **Modifier les paramètres**.

1. **La case magique :** Sous la section de votre adaptateur réseau, vérifiez que la case **"Connecter lors de la mise sous tension"** soit bien cochée. Si ce n'est pas le cas, c'est l'équivalent d'avoir le câble réseau débranché de l'ordinateur.

2. **Le bon réseau :** Assurez-vous que l'adaptateur réseau de votre client et celui de votre serveur DHCP sont connectés au même réseau virtuel. S'ils sont sur des réseaux virtuels différents et qu'aucun routage n'est configuré, les requêtes DHCP n'atteindront jamais le serveur.

## Pour conclure

:::danger La Base
**Ne supposez rien !** Vérifiez toujours tout, même les éléments les plus basiques.
:::

<Tabs groupId="os-choice">
  <TabItem value="windows" label="Environnement Windows" default>

  | Étape | Objectif | Commandes / Actions |
  | :--- | :--- | :--- |
  | **1. Client** | Relancer le processus (DORA) | `ipconfig /release` puis `ipconfig /renew`<br/>*(Vérifier si présence d'une adresse APIPA 169.254.x.x)* |
  | **2. Service** | Le serveur est-il éveillé ? | Ouvrir `services.msc` > Vérifier l'état de **Serveur DHCP** |
  | **3. Config.** | Le serveur a-t-il le droit d'agir ? | Le serveur est-il **Autorisé** dans l'Active Directory ? |
  | **4. Logs** | Pourquoi le serveur refuse-t-il ? | *Observateur d'événements > ... > Windows > DHCP-Server > Opérationnel* |
  | **5. Étendue** | Reste-t-il des IP et options ? | Console DHCP : Vérifier le pool et les *Options d'étendue* (003 Routeur, 006 DNS) |
  | **6. Réseau** | Le broadcast passe-t-il ? | **vSphere :** La VM est-elle sur le bon Port Group ?<br/>**Routeur :** Y a-t-il un *DHCP Relay* si les réseaux sont séparés ? |

  </TabItem>
  <TabItem value="linux" label="Environnement Linux (Kea)">

  | Étape | Objectif | Commandes / Actions |
  | :--- | :--- | :--- |
  | **1. Client** | Relancer le processus (DORA) | `sudo dhclient -r` puis `sudo dhclient -v ens18` |
  | **2. Service** | Le serveur est-il éveillé ? | `sudo systemctl status kea-dhcp4-server` |
  | **3. Config.** | La syntaxe JSON est-elle valide ? | `sudo kea-dhcp4 -t -c /etc/kea/kea-dhcp4.conf` |
  | **4. Logs** | Pourquoi le serveur refuse-t-il ? | `sudo journalctl -u kea-dhcp4-server -f`<br/>*(Chercher les messages DISCOVER, OFFER, ou les erreurs)* |
  | **5. Étendue** | Reste-t-il des IP et options ? | Fichier JSON : Vérifier la section `subnet4` (pool plein, `routers`, `domain-name-servers`) |
  | **6. Réseau** | Le broadcast passe-t-il ? | **vSphere :** La VM est-elle sur le bon commutateur ? |

  </TabItem>
</Tabs>