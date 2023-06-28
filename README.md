# SpendWise - Application de gestion des dépenses par enveloppe

SpendWise est une application Flutter conçue pour vous aider à gérer vos dépenses en utilisant un système d'enveloppe par budget. L'application utilise Riverpod pour la gestion des états et Isar comme base de données locale pour stocker les données de vos enveloppes et transactions.

## Utilisation de Riverpod pour la gestion des états

SpendWise utilise la bibliothèque Riverpod pour gérer les états de l'application de manière efficace et réactive. Riverpod facilite la gestion des dépendances et fournit un modèle de programmation déclaratif pour mettre à jour et accéder aux données de manière cohérente.

Dans le code source de SpendWise, vous trouverez l'utilisation de `Provider` et pour gérer les états globaux et locaux. Les modifications d'état déclenchent automatiquement les mises à jour de l'interface utilisateur, garantissant ainsi une expérience utilisateur fluide.

[https://riverpod.dev/fr/]
## Utilisation d'Isar comme base de données locale

SpendWise utilise la base de données locale Isar pour stocker et gérer les données des enveloppes et des transactions. Isar est une base de données NoSQL intégrée pour Flutter qui offre de bonnes performances et une syntaxe conviviale pour interagir avec les données.

La couche d'accès aux données de SpendWise est construite autour d'Isar, permettant ainsi le stockage persistant des informations des enveloppes, des transactions et de l'historique. L'utilisation d'Isar facilite également les opérations de requête et de filtrage des données, offrant ainsi une expérience utilisateur rapide et réactive.

[https://isar.dev/]
## Fonctionnalités clés

- Créez des enveloppes de budget pour différentes catégories de dépenses, telles que la nourriture, le divertissement, les factures, etc.
- Ajoutez des transactions à vos enveloppes en effectuant des retraits ou des ajouts.
- Visualisez facilement le solde actuel de chaque enveloppe.
- Consultez l'historique des transactions pour chaque enveloppe.
- Recevez des notifications ou des rappels lorsque vous atteignez certains seuils ou limites de dépenses.
- Gérez vos enveloppes et transactions de manière conviviale grâce à une interface utilisateur intuitive.

## Configuration et installation

1. Assurez-vous d'avoir Flutter et Dart installés sur votre système.
2. Clonez ou téléchargez le projet SpendWise depuis le référentiel GitHub.
3. Ouvrez un terminal et accédez au répertoire du projet.
4. Exécutez la commande `flutter pub get` pour obtenir les dépendances nécessaires.
5. Connectez votre appareil mobile ou configurez un émulateur.
6. Exécutez la commande `flutter run` pour lancer l'application sur votre appareil ou émulateur.

## Contribuer

Si vous souhaitez contribuer à l'amélioration de l'application SpendWise, vous pouvez suivre ces étapes :

1. Fork le référentiel SpendWise sur GitHub.
2. Créez une branche pour vos modifications : `git checkout -b my-feature`.
3. Faites les modifications et effectuez les tests nécessaires.
4. Committez vos modifications : `git commit -m "Add my feature"`.
5. Poussez les modifications vers votre fork : `git push origin my-feature`.
6. Soumettez une demande d'extraction (pull request) pour que vos modifications soient examinées et fusionnées dans le projet principal.

Nous sommes impatients de voir vos contributions et d'améliorer ensemble SpendWise !