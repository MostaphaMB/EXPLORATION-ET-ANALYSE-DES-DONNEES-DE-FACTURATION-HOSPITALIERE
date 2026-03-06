### 🏥 Exploration et Analyse des Données de Facturation Hospitalière avec SQL
#
📝 Description du Projet

Ce projet consiste à analyser le flux complet d'un patient au sein d'un environnement hospitalier. L'objectif est de comprendre et de modéliser le parcours allant des soins reçus à la facturation, jusqu'au paiement par l'assurance et aux ajustements financiers. Cette analyse repose sur une base de données relationnelle composée d'une table de faits et de huit tables de dimension.

🎯 Objectifs du Projet

Structurer une base de données relationnelle complexe dans SQL Server.Maîtriser l'importation et la vérification de données provenant de sources externes.Appliquer des jointures et des agrégations avancées pour répondre à des problématiques métier.Développer un raisonnement analytique sur les flux financiers et le taux de recouvrement.

🛠️ Outils et Technologies

SQL Server : Moteur de base de données pour la création, le stockage et les requêtes.
Excel : Source de données brute pour l'importation.
SQL : Langage utilisé pour les scripts de création (DDL) et d'analyse (DML).

🚀 Étapes de Réalisation

1. Préparation et Modélisation 🏗️

Création de la base de données et définition de la FactTable ainsi que des 8 tables de dimension.Définition des clés primaires sur chaque table et mise en place des clés étrangères pour relier les dimensions à la table de faits.

2. Intégration des Données 📥

Chargement des fichiers Excel dans les tables correspondantes.Vérification de l'intégrité des données importées.

3. Analyse SQL et Requêtes Métier 📊

Réalisation de 10 requêtes spécifiques pour extraire des insights stratégiques, notamment :

- Volumes et Patients : Calcul du nombre de lignes avec charge brute > $100 et décompte des patients uniques.
- Performance Financière : Calcul du Taux de Recouvrement Brut (GCR) par localisation.

- Analyse Médicale : Identification des spécialités recevant le plus de paiements et suivi mensuel.

- Rapport Démographique : Segmentation des patients par tranches d'âge (<18, 18-65, >65 ans).

4. Suivi du Flux Patient 🔄

Mise en place de jointures complexes pour retracer le parcours d'un patient fictif.Visualisation cohérente de la chaîne : Soins → Facturation → Paiement → Ajustements.

📦 Projet individuel réalisé dans le cadre de la formation DATA Analyst 2026.
