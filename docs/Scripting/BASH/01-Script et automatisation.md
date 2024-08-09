# Script et automatisation 📜

## Pourquoi faire des scripts ? 
C'est une question légitime. Après tout, pourquoi utilise-t-on encore un "Shell" alors que nous avons des interfaces graphiques qui nous permettent de tout faire ou presque ?

 ### Éliminer les tâches répétitives
 Si vous êtes un administrateur réseau, ou un administrateur système, ou encore si vous aspirez à l'un de ces métiers, vous aurez sans l'ombre d'un doute des tâches redondantes à exécuter à un moment ou un autre. Un script pourrait vous permettre d'exécuter cette même tâche et d'investir le temps épargné sur des tâches à valeur ajoutée.

 ### Exécuter une même tâche sur plusieurs postes
 Imaginons un instant que vous soyez le responsable d'un parc informatique qui détient plus de 300 ordinateurs. Malheureusement, vous vous rendez compte qu'un fichier bien particulier cause des ennuis sur la plupart des postes. La seule idée de penser que vous pourriez perdre une journée à vous asseoir à chaque poste pour supprimer le même fichier est abrutissante. Un script, bien exécuté à distance, vous permettrait de réaliser le même exploit, et ce, sans même quitter le confort de votre propre poste.

 ### Réduire le risque d'erreurs humaines
 Même si une tâche peut paraître simple, la répétez *n* fois augmente le risque d'être distrait en l'exécutant et évidemment, augmente également le risque d'erreurs. Le script, lui, ne se trompe jamais. Même exécuté 3000 fois, la tâche sera exécutée de la même façon chaque fois. C'est une capacité que les machines ont que de ne jamais se fatiguer, à nous de l'utiliser à notre avantage.

 ## C'est quoi un script ? 
 Un script, ce n'est ni plus ni moins qu'un fichier contenant du texte. Ce texte est constitué de lignes de commande qui seront exécutées dans l'ordre. Pour bien comprendre les scripts, il vous faudra donc bien comprendre les commandes qui les constituent. Si ce n'est pas déjà fait, je vous invite à consulter la rubrique **[lignes de commandes](/docs/OS/Linux/03-Lignes%20de%20commande.md)** de la section Systèmes d'exploitation (Linux) de ce site. Vous y retrouverez quelques commandes essentielles avant de vous lancer dans le "Scripting".
 
 ### Script versus programme
 Il importe de bien distinguer les programmes des scripts. Contrairement aux programmes, les scripts sont généralement orientés vers une tâche précise. *A contrario* des langages de programmation qui sont compilés, les langages de programmation utilisés en "Scripting" sont dit interpretés. Une compilation de code est une étape supplémentaire avant d'obtenir le produit fini. Le développeur écrit son code, il doit ensuit le compiler, ce qui rendra le code compréhensible pour l'ordinateur qui, à son tour, pourra exécuter le programme. Un langage interprété n'a pas besoin de passer par l'étape de compilation. Autant le développeur que l'ordinateur sera en mesure d'en comprendre les rudiments. Les script sont souvent associés à un "Shell" particulier. Ils exploitent les commande de ce-dernier.