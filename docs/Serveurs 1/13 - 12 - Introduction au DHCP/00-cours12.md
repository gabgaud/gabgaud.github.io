import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Cours 12

## La configuration IP jusqu'ici...

Jusqu'à aujourd'hui, vous deviez configurer vos adresses IP manuellement. Cette façon de faire n'est pas représentative puisque dans une entreprise qui compte plusieurs centaines d'ordinateurs, il serait impensable de configurer les adresses IP à la main. De plus, cette méthode de configuration (à la main) engendre un lot d'inconvénients:

- Le risque de configurer deux ordinateurs avec la même adresse IP est plus élevé
- Cela nécessite une nouvelle configuration chaque fois qu'un appareil change de réseau
- La configuration de l'adressage IP nécessite des privilèges d'administration. C'est donc un administrateur qui doit, chaque fois, changer la configuration.

## Le serveur DHCP

Le DHCP est un acronyme (oui, un autre!) qui signifie *Dynamic Host Configuration Protocol*. Cela pourrait se traduire par protocole de configuration dynamique des hôtes. Ce serveur a pour objectif de fournir l'adressage IP ainsi que toute information pertinente aux différents clients du réseau.

Les serveurs DHCP sont partout. Les routeurs domestiques, certains pare-feu physiques, les appareils mobiles et évidemment les serveurs peuvent tous opérer un service DHCP.

### Principe de fonctionnement

Le processus DHCP se traduit par 4 étapes (**DORA**):

1. **Découverte** (*discover*):<br/>
    Le client qui joint le réseau envoie un message à toutes les machines du réseau grâce à l'adresse de broadcast en espérant joindre un serveur DHCP.

2. **Offre** (*offer*):<br/>
    Le serveur reçoit le message via le canal de diffusion et offre une adresse IP disponible au client.

3. **Requête** (*Request*):<br/>
    Le client répond au serveur et confirme son désir d'emprunter une adresse IP.

4. **Acquittement** (*Acknowledge*):<br/>
    Le serveur confirme le prêt et enregistre l'information dans sa base de données.

![ProcessusDHCP](../Assets/13/DHCP.gif)

### Rappel sur les adresses MAC et IP

|Spécifications|Adresse MAC|Adresse IP|
|--------------|:-----------:|:-----------:|
|**Type**|Adresse physique|Adresse logique|
|**Longueur**|6 octets en hexadécimal|4 octets en binaire|
|**Attribution**|Fixée par le manufacturier|Configurable et paramétrable|
|**Utilisation**|Permet la communication entre hôtes d'un même réseau|Permet d'interconnecter plusieurs réseaux|
|**Exemple**|A6:BB:68:D1:FF:A7|172.16.16.30|

### Baux

L'octroi d'une adresse IP par le serveur n'est jamais *ad vitam eternam*. Le serveur et le client signent un bail sur lequel une durée est prescrite. La durée d'un bail est déterminée par l'administrateur du service. L'objectif principal du bail est d'éviter l'épuisement complet du bassin d'adresses disponibles. Ainsi, lorsqu'un bail n'est pas renouvelé par le client, l'adresse IP qui lui est associée est remise dans le bassin d'adresses disponibles.

#### Critères à considérer

Lorsque nous définissons la durée d'un bail DHCP, il importe de considérer certains éléments importants:

- **Le bassin d'adresses:**<br/>
    Le bassin d'adresse n'est ni plus ni moins que la quantité d'adresses IP que vous avez à votre disposition. Plus vous avez une quantité importante d'adresses à distribuer, plus vous pouvez vous permettre un bail long. L'inverse est aussi vrai. Si vous avez un bassin d'adresse limité, un bail plus court serait sans doute une meilleure idée.

- **Nature du réseau:**<br/>
    La nature et la dynamique du réseau jouent un rôle important dans la mise en place du bail. En effet, si le réseau sur lequel vous travaillez comporte un nombre important d'appareils entrants et sortants (Ex: Restauration rapide), vous devrez songer à mettre un bail plus court pour assurer le retour des adresses inutilisées dans le bassin. *A contrario*, si vous vous affairez à un réseau plutôt stable, avec peu d'appareils entrants et sortants, la durée du bail pourrait être plus longue.

- **Type de périphériques:**<br/>
    Si votre réseau comporte beaucoup d'appareils statiques, un bail plus long (voire une réservation) pourrait être de mise. Si votre réseau est constitué en grande partie d'appareils mobiles et portables, il vaudrait mieux diminuer la longueur des baux DHCP.

- **Politique technologique:**<br/>
    Enfin, il se peut que l'entreprise ait le désir de réduire la charge de travail du serveur DHCP pour toutes sortes de raison. Dans pareil cas, un bail DHCP plus long assurera un faible taux d'activité du serveur. À l'inverse, une entreprise pourrait également préférer avoir un contrôle plus granulaire sur son bassin d'adressage. Dans ce cas, mieux vaut définir des baux DHCP de plus courte durée.

#### Le renouvèlement

Les clients commencent à renouveler leur bail respectif lorsque la moitié de la durée du bail est écoulée. Par exemple, pour un bail de 24 heures, le client tente de renouveler le bail après 12 heures. Le client demande le renouvèlement en envoyant un message de type *dhcp request* (Étape 3 DORA). Cette demande contient l'adresse IP actuelle et les informations de configuration du client.

Si le serveur accepte la demande, il enverra un message de type *dhcp acknowledge* (Étape 4 DORA). Si le serveur ne répond pas à la demande, le client pourra continuer à utiliser l'adresse IP jusqu'à l'expiration du bail. Lorsque le bail est arrivé à expiration, le processus DHCP doit être repris depuis le début, soit les 4 étapes DORA.

### Les étendues
Une étendue DHCP correspond généralement à un sous-réseau, c'est-à-dire une quantité d'adresses IP définie par un masque de sous-réseau, parmi laquelle le serveur DHCP sera autorisé à distribuer certaines adresses. <mark>Une étendue se termine toujours par 0 et représente un ensemble d'adresses.</mark> Voici quelques exemples d'étendues que nous pourrions utiliser:

|Étendue|Quantité d'adresses|
|:-----:|:-----------------:|
|192.168.21.0 /24|254|
|172.20.20.0 /16|65 534|
|10.0.40.0 /26|62|

Chaque étendue dans le serveur DHCP possède ses propriétés, lesquelles peuvent être configurées selon nos besoins:

#### Le bassin d'adresses

Le bassin d'adresses représente l'ensemble des adresses IP pouvant être assignées par le serveur DHCP au sein d'une étendue.

![BassinAdresses](../Assets/13/BassinAdresses.png)

#### Les exclusions

Consiste en une, ou plusieurs portions des adresses du bassin que l'on retire du processus de distribution. Exclure certaines adresses IP du bassin est une pratique tout à fait facultative. Nous pouvons très bien définir un bassin d'adresse qui couvrira une fraction du sous-réseau à la place.

#### Les réservations

Il est possible de réserver une adresse IP particulière pour un client. Ainsi, celui-ci recevra toujours la même adresse IP, peu importe si le bail est expiré ou non. C'est une alternative à l'attribution d'adresse IP manuelle. Les réservations se font sur la base des adresses MAC. Si une carte réseau est remplacée, il faudra nécessaire ajuster la réservation.

#### Les options

Outre les adresses IP, le serveur DHCP peut fournir une panoplie d'informations supplémentaires quant au réseau. C'est ce que l'on nomme les options. Une option DHCP possède généralement un nom et un numéro d'identification.

Voici quelques-unes des options DHCP les plus utilisées

|Numéro|Nom|Explication|
|:--:|:----:|--------------|
|1|Subnet Mask|Le masque de sous-réseau à fournir avec l'adresse IP des clients.|
|3|Router|Il s'agit en fait de l'adresse IP de la passerelle par défaut à utiliser.|
|6|DNS (Domain Name Server)|Il s'agit du (ou des) serveur de noms à utiliser.|
|15|Domain Name|Le suffixe DNS que les clients devraient utiliser.|

Pour la liste complète et exhaustive, vous pouvez consulter [le site de l'iana.](https://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml)

### Tolérance aux pannes

Une panne du service DHCP n'est pas souhaitable. Voici les symptômes que vous verrez apparaitre en cas de panne:

- Les machines ayant déjà obtenu une adresse IP avant la défaillance du serveur conserveront leur adresse jusqu'à l'expiration du bail.
- Les renouvèlements de baux ne fonctionneront pas.
- Les machines qui tenteront de joindre le réseau ne recevront pas de configuration IP.

Le service DHCP ne possède pas de tolérance aux pannes inhérente, néanmoins il existe des configurations qui permettront un minimum de haute disponibilité.

#### Le fractionnement de l'étendue

C'est une méthode pour assurer une certaine tolérance aux pannes DHCP. Deux serveurs DHCP sont en place, que l'on pourrait qualifier de primaire et de secondaire. On allouera 80% de l'étendue au serveur principal et 20% au serveur secondaire. Finalement, on configurera un délai de réponse sur le serveur secondaire. Ainsi, il pourra distribuer des adresses IP dans le cas où le serveur primaire n'aurait pas répondu dans le délai imparti.

<div style={{textAlign: 'center'}}>
    <ThemedImage
        alt="Schéma"
        sources={{
            light: useBaseUrl('/img/Serveurs1/DHCP_FailOver_W.gif'),
            dark: useBaseUrl('/img/Serveurs1/DHCP_FailOver_D.gif'),
        }}
    />
</div>

## Le protocole APIPA

APIPA signifie *Automatic Private IP Adressing*. Il s'agit d'un protocole créé par Microsoft et **présent sur les PC Windows uniquement.** Lorsqu'un ordinateur sous Windows et configuré pour obtenir son adresse IP automatiquement (la configuration par défaut) et qu'aucun serveur DHCP ne répond, l'ordinateur s'attribuera lui-même une adresse prise au hasard dans le sous-réseau 169.254.0.0/16.

À la base, le protocole APIPA avait été conçu pour faciliter la configuration de [réseaux *ad hoc*](https://fr.wikipedia.org/wiki/R%C3%A9seau_ad_hoc) et pour permettre la communication entre machines même si celles-ci n'ont pas d'accès à un serveur DHCP. Aujourd'hui, le protocole est plus utilisé pour détecter les problématiques en lien avec l'adressage dynamique que quoi que ce soit.

:::tip[Le saviez-vous ?]
Il est possible de désactiver complètement le protocole APIPA sous Windows. Cela fera en sorte que si l'ordinateur n'arrive pas à joindre le serveur DHCP, aucune configuration IP ne sera appliquée. Autrement dit, le champ « Adresse IP » de votre carte réseau restera vide plutôt que de se configurer une adresse dans le sous-réseau 169.254.0.0/16.

Pour désactiver le protocole APIPA sous votre PC, entrez la commande suivante dans une console Powershell en tant qu'Administrateur:

```Powershell
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ -Name IPAutoconfigurationEnabled -Value 0
```

Redémarrez votre ordinateur pour appliquer les changements.

:::

## Mise à jour automatique du DNS

Dans les cours précédents, nous avons abordé les serveurs DNS. Vous savez, désormais, qu'un serveur DNS qui gère au moins une zone possède plusieurs enregistrements. Ces enregistrements correspondent normalement à l'adresse IP d'un PC. Lorsque c'est un serveur DHCP qui gère l'adressage IP dynamiquement sur le réseau, une problématique survient: comment assurer une correspondance nom de domaine : adresse IP valide et à jour dans le serveur DNS ?

Il est possible de configurer le serveur DHCP pour que ce dernier avise le serveur DNS lorsqu'il attribue une adresse IP. Ainsi le serveur DNS pourra mettre à jour les enregistrements concernés.

## Quelques commandes utiles

### Windows

Sous Windows, vous saviez déjà que la commande `ipconfig` vous permet d'obtenir la configuration IP de votre ordinateur. Cependant, certains commutateurs de cette commande peut s'avérer très utile en contexte de configuration dynamique:

- `ipconfig /release`<br/>
    Cette commande vous permettra de relâcher une configuration reçu par un serveur DHCP.

- `ipconfig /renew`<br/>
    Cette commande relance l'entièreté du processus DHCP, soit les 4 étapes DORA.

### Linux

Sous Linux (Ubuntu), c'est la commande `ip a` qui vous permet d'avoir un résumé de votre configuration IP. Néanmoins, ce sera la commande `dhclient` qui vous permettra de manoeuvrer en contexte de configuration dynamique.

- `dhclient -r`
    Cette commande vous permettra de relâcher une configuration reçu par un serveur DHCP.

- `dhclient -v`
    Cette commande relance l'entièreté du processus DHCP, soit les 4 étapes DORA.

## Références

- [Présentation du cours](../Assets/12/12-420-2S5-H25%20(DHCP).pdf)