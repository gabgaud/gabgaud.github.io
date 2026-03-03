---
draft: true
---
import useBaseUrl from '@docusaurus/useBaseUrl';
import ThemedImage from '@theme/ThemedImage';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Exercice 03

## Installation et désinstallation de Logiciels

Dans cet exercice, vous aurez l'occasion d'installer et de désinstaller des logiciels ou des applications en expérimentant diverses méthodes d'installation et de désinstallation.

## Étapes de réalisation

### Question 1: Installation d'un logiciel avec le Windows Store

Débutez par confirmer que vous avez bien accès au Windows Store de Microsoft depuis votre machine virtuelle. Une fois celui-ci lancé, explorez les menus et les différentes catégories afin de vous familiariser avec l'interface.

Sélectionnez une application gratuite <mark>dont l'éditeur **n'est pas** Microsoft</mark> (par exemple, une application de productivité ou un petit jeu simple) et tentez de procéder à son installation.

![WindowsStore](../Assets/Exercices/03/WindowsStore.png)

Une fois votre installation installé, confirmez son bon fonctionnement.

**Quelques pistes de réfléxion pour votre journal de cours:**

- Quels avantages présente l’installation via le Windows Store (mise à jour automatique, sécurité, etc.) ?
- Quelles limitations ou contraintes peut-on rencontrer avec le Windows Store ?

### Gestion des logiciels avec Winget

**WinGet** est un outil utilisable sous forme de commandes. Vous devrez donc valider, d'abord et avant tout que vous êtes en mesure de l'utiliser. Entrez donc la commande suivante dans PowerShell pour confirmer que **WinGet** est bien prêt et disponible pour l'utilisation:

<div className="tabsborder">
    <Tabs>
        <TabItem value="VersionWinGet" label="Commande" default>
            ```Powershell
            winget --version
            ```
        </TabItem>
        <TabItem value="ResultatVersionWinGet" label="Résultat">
           ![VersionWinGet](../Assets/Exercices/03/VersionWinget.png)
        </TabItem>
    </Tabs>
</div><br/>

Une fois que vous avez confirmé que **WinGet** fonctionne bien, suivez les mêmes étapes que moi pour installer votre première application avec cette interface, soit Notepad++. Vous pouvez rechercher des applications directement avec **WinGet** en utilisant le paramètre *search* suivi du nom d'un application. Par exemple: `winget search notepad++`

<div className="tabsborder">
    <Tabs>
        <TabItem value="WinGetSearch" label="Commande" default>
            ```Powershell
            winget search notepad++
            ```
        </TabItem>
        <TabItem value="ResultatWinGetSearch" label="Résultat">
           ![WingetSearch](../Assets/Exercices/03/WingetSearch.png)
        </TabItem>
    </Tabs>
</div><br/>

Pour procéder à l'installation d'un application avec **WinGet**, on utilisera le paramètre *install* suivi du nom de l'application ou de son ID:

<div className="tabsborder">
    <Tabs>
        <TabItem value="WinGetInstall" label="Commande" default>
            ```Powershell
            winget install Notepad++.Notepad++ --source winget
            #La source est importante! Autrement vous installerez à la manière d'une application dans le store.
            ```
        </TabItem>
        <TabItem value="ResultatWinGetInstall" label="Résultat">
           ![WingetInstall](../Assets/Exercices/03/WinGetInstall.png)
        </TabItem>
    </Tabs>
</div><br/>

:::note
On procédera sensiblement de la même façon pour désinstaller un logiciel avec **WinGet**. Cela dit, nous utiliserons le paramètre *uninstall* plutôt que le paramètre *install*
:::

**Quelques pistes de réfléxion pour votre journal de cours:**

- Comment Winget facilite-t-il la gestion des logiciels en ligne de commande ?
- Dans quelles situations l’utilisation de Winget peut être plus avantageuse que le Windows Store ?

### Gestion manuelle des logiciels

Évidemment, la méthode manuelle de gestion des logiciels reste une méthode encore très utilisée de nos jours. Elle consiste à télécharger un logiciel depuis le site du développeur ou de l'éditeur et de procéder à son installation.

Pour cette partie de l'exercice, je vous propose deux volets:

 - Les installateurs au format *.exe*
 - Les installateurs au format *.msi*

#### Le format .exe

Les installateurs au format *.exe* sont compilés et ne peuvent être traités autrement qu'en étant tout simplement lancé. Autrement dit, lorsque votre installateur possède cette extension de fichier, tout ce que vous pouvez faire, c'est le lancer. Trouvez un installateur au format *.exe* et procédez à son installation sur votre machine virtuelle.

:::tip
Si vous n'avez pas d'idée de logiciel, vous pouvez installer **VLC** ou **Audacity**. Dans les deux cas, les installateurs sont offerts au format *.exe*
:::

#### Le format .msi

Le format *.msi* est particulier. En effet, ces installateurs peuvent être lancés via l'invite de commande de manière totalement silencieuse et invisible pour l'utilisateur final. Pour réaliser ce petit exploit, vous aurez besoin de la commande `msiexec`.

Consultez la [documentation officielle de Microsoft](https://learn.microsoft.com/fr-ca/windows-server/administration/windows-commands/msiexec) au sujet de cette commande et tentez d'installer silencieusement l'utilitaire [7-zip](https://www.7-zip.org/download.html) dont l'un des installateurs est offert au format *.msi*

**Quelques pistes de réfléxion pour votre journal de cours:**

- Quels sont les avantages et les risques d’installer des logiciels via des exécutables ou des packages MSI téléchargés ?
- Comment vérifier l’authenticité et la sécurité d’un fichier d’installation ?

### Correction

Bien qu'il n'y ait pas beaucoup d'éléments à vérifier dans le cadre de cet exercice, je vous offre tout de même la possibilité de vous corriger. Exécutez simplement ce [script de correction](../Assets/Exercices/03/ScriptCorrection.ps1)