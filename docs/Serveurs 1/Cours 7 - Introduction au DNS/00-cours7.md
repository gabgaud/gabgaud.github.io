# Cours 7

## Domain Name System

Depuis quelques cours maintenant, vous vous familiarisez avec l'utilisation d'adresses IP. Vous avez configuré des adresses IP sur vos serveurs par exemple. Cela dit, comment se fait-il que vous deviez utiliser des adresses IP pour envoyer un *ping* d'une machine à l'autre par exemple ? Ne serait-il pas plus facile d'envoyer un *ping* à une adresse comme `serveur.patate.com`?

Qu'en est-il lorsque vous naviguez sur le web ? Est-il plus facile de retenir www.cegepmontpetit.ca ou 35.203.2.187 ? La question est vite répondu. Imaginez un monde vous deviez vous souvenir de toutes les adresses IP des serveurs web que vous interrogez. Imaginez devoir vous souvenir des adresses IP suivantes:

- Vos réseaux sociaux (chacun d'entre eux ayant un IP différente)
- L'adresse IP d'Omnivox
- L'adresse IP de Spotify si vous écoutez de la musique
- L'adresse IP de YouTube
- L'adresse IP de Google
- L'adresse IP de ChatGPT
- Etc...

## Problématiques avec les adresses IP 🤔

Les adresses IP ne sont pas pratiques pour plusieurs raisons:

- Elles ne sont pas évidentes à retenir, du moins lorsque nous en avons plusieurs à retenir.
- Elles peuvent changer. Un serveur ou un ordinateur n'a pas toujours la même adresse IP.
- Une même adresse IP pourrait héberger plus d'un site web ou plus d'une application.

## La résolution de noms 💡
L'être humain étant ce qu'il est, il a plus de facilité à retenir les noms que les numéros. D'ailleurs, c'est pourquoi vous portez un nom et non pas un numéro (sauf si votre père est Elon Musk). Nous avons donc créé un mécanisme nous permettant de donner des noms à des ordinateurs (eh oui, on leur donne des noms...)

En analogie à ce principe, nous pourrions penser au répertoire téléphonique dans votre cellulaire. Aujourd'hui, je ne connais plus beaucoup de gens qui se souviennent du numéro de téléphone de leurs proches. On se contente plutôt d'appuyer sur leur nom dans notre répertoire téléphonique. C'est un peu comme cela que fonctionne la résolution de noms également.

![Contacts](../Assets/07/Contacts.png)

### Comment ça fonctionne ?

Une résolution de nom comporte un bon nombre d'étapes. Néanmoins, le processus a tellement bien été ficelé au fil du temps, que le processus prend moins de temps qu'il en faut pour cligner un oeil. Alors que se passe-t-il exactement lorsque vous tapez [www.patate.com](https://img.freepik.com/photos-gratuite/autocollant-drole-pomme-terre-visage_23-2148740793.jpg?t=st=1733952670~exp=1733956270~hmac=59caf559765b6cbfdec48d165d9b78632d30d6c9c08fcf3447ef69766d3d0e3d&w=1380) dans votre navigateur internet ? Analysons cela:

#### Étape 1 : Le fichier hosts

Votre ordinateur commencera par vérifier s'il possède l'adresse IP correspondante à l'adresse que vous avez tapé dans son fichier `hosts`. Le fichier `hosts` est présent dans **tous** les ordinateurs. Ce fichier possède des associations nom:adresse ip et il possède la priorité absolu lorsque vient le temps de résoudre un nom.