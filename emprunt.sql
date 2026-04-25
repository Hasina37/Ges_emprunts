-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 25 avr. 2026 à 04:55
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `erp_com`
--
CREATE DATABASE IF NOT EXISTS `erp_com` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `erp_com`;

-- --------------------------------------------------------

--
-- Structure de la table `approvisionnements`
--

DROP TABLE IF EXISTS `approvisionnements`;
CREATE TABLE IF NOT EXISTS `approvisionnements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produit_id` int NOT NULL,
  `quantite` int NOT NULL,
  `prix_achat` decimal(38,2) NOT NULL,
  `date_approvisionnement` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4pwlidtchoftcyaqlt8r7g66s` (`produit_id`),
  KEY `FKj2cpujm8telfdtkdpqo28heo9` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `approvisionnements`
--

INSERT INTO `approvisionnements` (`id`, `produit_id`, `quantite`, `prix_achat`, `date_approvisionnement`, `user_id`) VALUES
(1, 1, 10, 2000000.00, '2026-04-03 10:13:34', 1),
(2, 1, 10, 2000000.00, '2026-04-04 20:34:31', 1);

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(2, 'Informatique', 'Produits IT');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `name`, `email`, `phone`, `address`, `created_at`) VALUES
(2, 'Jean', 'jean@mail.com', '0341234567', 'Tana', '2026-04-03 09:53:39');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `date_commande` datetime DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('en_attente','validee','annulee') DEFAULT 'en_attente',
  `total_prix` decimal(38,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKoib3exi3ry2spqi19i9qk4ey1` (`client_id`),
  KEY `FKavy0l3h0s3v20uoi8dfcq9ipc` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id`, `client_id`, `user_id`, `date_commande`, `statut`, `total_prix`) VALUES
(1, 2, 1, '2026-04-03 10:41:02', 'en_attente', 500000.00);

-- --------------------------------------------------------

--
-- Structure de la table `commande_details`
--

DROP TABLE IF EXISTS `commande_details`;
CREATE TABLE IF NOT EXISTS `commande_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commande_id` int NOT NULL,
  `produit_id` int NOT NULL,
  `quantite` int NOT NULL,
  `prix_total_par_produit` decimal(38,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6h9vy36ckfskuqpy6ayt2btia` (`commande_id`),
  KEY `FKoqjngy0ilt63h0mpx6c8xiny2` (`produit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commande_details`
--

INSERT INTO `commande_details` (`id`, `commande_id`, `produit_id`, `quantite`, `prix_total_par_produit`) VALUES
(1, 1, 1, 2, 100000.00);

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

DROP TABLE IF EXISTS `factures`;
CREATE TABLE IF NOT EXISTS `factures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `commande_id` int DEFAULT NULL,
  `numero_facture` int NOT NULL,
  `date_facture` datetime DEFAULT CURRENT_TIMESTAMP,
  `montant_total` decimal(38,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_facture` (`numero_facture`),
  KEY `FKpwspofv4ycf27iyfso8abo4kk` (`commande_id`),
  KEY `FK5hmnfmcpdnpu0sbwjpoihexpa` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`id`, `user_id`, `commande_id`, `numero_facture`, `date_facture`, `montant_total`) VALUES
(1, 1, 1, 1, '2026-04-03 11:00:33', 500000.00);

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `prix` decimal(38,2) NOT NULL,
  `stock` int DEFAULT '0',
  `categorie_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK8xk7p0dnnygs2sys4thsfekba` (`categorie_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `name`, `description`, `prix`, `stock`, `categorie_id`, `created_at`) VALUES
(1, 'Laptop', 'PC portable', 2500000.00, 5, 2, '2026-04-03 10:05:15');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('manager','vendeur') NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `phone`, `created_at`) VALUES
(1, 'John Doe', 'john@example.com', '12345678', 'manager', '0341234567', '2026-04-02 13:02:47');
--
-- Base de données : `erp_commercial`
--
CREATE DATABASE IF NOT EXISTS `erp_commercial` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `erp_commercial`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `code`, `nom`, `description`) VALUES
(3, 'PAP', 'Papeter', 'Fournitures de bureau'),
(4, 'TEXT', 'Textile', 'Vêtements et tissus'),
(5, 'DOB', 'Immoblier', 'Mobilier de bureau et maison');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_client` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `utilisateur_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_client` (`numero_client`),
  UNIQUE KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `numero_client`, `nom`, `prenom`, `email`, `telephone`, `adresse`, `utilisateur_id`) VALUES
(1, 'CLI-2024-001', 'DURAND', 'Sophie', 's.durand@email.com', '0612345678', '12 Rue de Paris, Lyon', 6),
(2, 'CLI-2024-002', 'BERNARD', 'Lucas', 'l.bernard@email.com', '0698765432', '45 Avenue Victor Hugo, Marseille', 7),
(3, 'CLI-2024-003', 'PETIT', 'Emma', 'client@erp.com', '0678912345', '8 Place Bellecour, Lyon', 2);

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE IF NOT EXISTS `commandes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_commande` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` bigint NOT NULL,
  `date_commande` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('EN_ATTENTE','VALIDEE','ANNULEE','LIVREE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN_ATTENTE',
  `total` decimal(38,2) NOT NULL,
  `utilisateur_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_commande` (`numero_commande`),
  KEY `idx_commande_client` (`client_id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`id`, `numero_commande`, `client_id`, `date_commande`, `statut`, `total`, `utilisateur_id`) VALUES
(14, 'CMD-2', 1, '2026-02-26 17:58:19', 'LIVREE', 8999.90, NULL),
(16, 'CMD-3', 3, '2026-02-27 08:00:20', 'LIVREE', 18899.87, NULL),
(17, 'CMD-4', 3, '2026-02-27 08:49:44', 'LIVREE', 4499.95, NULL),
(20, 'CMD-5', 1, '2026-02-27 08:57:21', 'LIVREE', 702732.00, NULL),
(21, 'CMD-6', 1, '2026-02-27 09:15:36', 'VALIDEE', 2250.00, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

DROP TABLE IF EXISTS `factures`;
CREATE TABLE IF NOT EXISTS `factures` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_facture` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commande_id` bigint NOT NULL,
  `date_facturation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `montant_total` decimal(38,2) NOT NULL,
  `montant_verse` decimal(38,2) NOT NULL,
  `monnaie_rendue` decimal(38,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_facture` (`numero_facture`),
  KEY `idx_facture_commande` (`commande_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`id`, `numero_facture`, `commande_id`, `date_facturation`, `montant_total`, `montant_verse`, `monnaie_rendue`) VALUES
(1, 'FACT-001', 14, '2026-02-26 18:02:56', 8999.90, 9000.90, 1.00),
(2, 'FACT-002', 16, '2026-02-27 08:02:49', 18899.87, 20000.00, 1100.13),
(3, 'FACT-003', 17, '2026-02-27 08:50:14', 4499.95, 5000.00, 500.05),
(4, 'FACT-004', 20, '2026-02-27 08:58:31', 702732.00, 800000.00, 97268.00),
(5, 'FACT-005', 21, '2026-02-27 09:15:52', 2250.00, 3000.00, 750.00);

-- --------------------------------------------------------

--
-- Structure de la table `lignes_commande`
--

DROP TABLE IF EXISTS `lignes_commande`;
CREATE TABLE IF NOT EXISTS `lignes_commande` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `commande_id` bigint NOT NULL,
  `produit_id` bigint NOT NULL,
  `quantite` int NOT NULL,
  `prix_unitaire` decimal(38,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `produit_id` (`produit_id`),
  KEY `idx_ligne_commande` (`commande_id`)
) ;

--
-- Déchargement des données de la table `lignes_commande`
--

INSERT INTO `lignes_commande` (`id`, `commande_id`, `produit_id`, `quantite`, `prix_unitaire`) VALUES
(25, 14, 1, 10, 899.99),
(27, 16, 2, 16, 450.00),
(28, 16, 1, 13, 899.99),
(29, 17, 1, 5, 899.99),
(30, 20, 6, 3, 234244.00),
(31, 21, 2, 5, 450.00);

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `prix_unitaire` decimal(38,2) NOT NULL,
  `stock_quantite` int NOT NULL DEFAULT '0',
  `categorie_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `categorie_id` (`categorie_id`)
) ;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `reference`, `nom`, `description`, `prix_unitaire`, `stock_quantite`, `categorie_id`) VALUES
(1, 'PROD-001', 'Ordinateur Portable HP', 'PC Portable 15.6\" i5 16Go RAM', 899.99, 22, 5),
(2, 'PROD-002', 'Bureau Ergonomique', 'Bureau réglable en hauteur', 450.00, 99, 5),
(3, 'PROD-003', 'Ramette Papier A4', '500 feuilles 80g/m²', 5.99, 194, 3),
(4, 'PROD-004', 'Chemise Coton', 'Chemise homme taille M', 29.99, 94, 4),
(5, 'PROD-005', 'Souris Sans Fil', 'Souris optique Bluetooth', 25.50, 150, NULL),
(6, 'PROD-009', 'Scanner', 'tehhte', 234244.00, 102, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ADMIN','CLIENT','LIVREUR') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `email`, `mot_de_passe`, `role`) VALUES
(1, 'admin@erp.com', 'admin123', 'ADMIN'),
(2, 'client@erp.com', 'client123', 'CLIENT'),
(3, 'n@gmail.com', '123', 'ADMIN'),
(4, 'b@gmail.com', '2005', 'CLIENT'),
(5, 'l@gmail.com', '123456', 'LIVREUR'),
(6, 's.durand@email.com', '123456', 'CLIENT'),
(7, 'l.bernard@email.com', '123456', 'CLIENT');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `commandes_ibfk_2` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`);

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `factures_ibfk_1` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`id`);

--
-- Contraintes pour la table `lignes_commande`
--
ALTER TABLE `lignes_commande`
  ADD CONSTRAINT `lignes_commande_ibfk_1` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lignes_commande_ibfk_2` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`id`);

--
-- Contraintes pour la table `produits`
--
ALTER TABLE `produits`
  ADD CONSTRAINT `produits_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
--
-- Base de données : `garage_db`
--
CREATE DATABASE IF NOT EXISTS `garage_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `garage_db`;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `nom`, `prenom`, `telephone`, `adresse`) VALUES
(4, 'RAJAONARIVELO', 'Fenomanantsoa Nantenaina', '034 44 889 02', 'IPA 290 BIS'),
(6, 'ANDRIAMIARINONY', 'Nomanjanahary Fandresena', '034 45 889 30', 'Malaza');

-- --------------------------------------------------------

--
-- Structure de la table `historique_reparations`
--

DROP TABLE IF EXISTS `historique_reparations`;
CREATE TABLE IF NOT EXISTS `historique_reparations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_reparation` varchar(10) NOT NULL,
  `id_vehicule` int NOT NULL,
  `immatriculation` varchar(20) NOT NULL,
  `client_nom` varchar(100) NOT NULL,
  `description` text,
  `date_entree` date NOT NULL,
  `date_sortie_prevue` date DEFAULT NULL,
  `cout_estime` decimal(15,2) DEFAULT '0.00',
  `statut` varchar(20) NOT NULL DEFAULT 'En cours',
  `date_archivage` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `historique_reparations`
--

INSERT INTO `historique_reparations` (`id`, `numero_reparation`, `id_vehicule`, `immatriculation`, `client_nom`, `description`, `date_entree`, `date_sortie_prevue`, `cout_estime`, `statut`, `date_archivage`) VALUES
(4, '002', 12, '2005 TBC', 'ANDRIAMIARINONY Nomanjanahary Fandresena', 'panne genérateur', '2015-05-14', '2015-05-20', 300000.00, 'Terminé', '2025-11-20 08:32:24'),
(3, '001', 13, '2003 TBC', 'RAJAONARIVELO Fenomanantsoa Nantenaina', 'panne moteur', '2025-06-24', '2025-06-27', 300000.00, 'En cours', '2025-11-21 08:06:09');

-- --------------------------------------------------------

--
-- Structure de la table `reparations`
--

DROP TABLE IF EXISTS `reparations`;
CREATE TABLE IF NOT EXISTS `reparations` (
  `numero_reparation` varchar(10) NOT NULL,
  `id_vehicule` int NOT NULL,
  `description` text,
  `date_entree` date NOT NULL,
  `date_sortie_prevue` date DEFAULT NULL,
  `cout_estime` decimal(10,2) DEFAULT NULL,
  `statut` enum('En cours','Terminé') DEFAULT 'En cours',
  PRIMARY KEY (`numero_reparation`),
  KEY `id_vehicule` (`id_vehicule`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `reparations`
--

INSERT INTO `reparations` (`numero_reparation`, `id_vehicule`, `description`, `date_entree`, `date_sortie_prevue`, `cout_estime`, `statut`) VALUES
('002', 12, 'panne genérateur', '2015-05-14', '2015-05-20', 300000.00, 'Terminé'),
('001', 13, 'panne moteur', '2025-06-24', '2025-06-27', 300000.00, 'En cours');

--
-- Déclencheurs `reparations`
--
DROP TRIGGER IF EXISTS `after_reparation_insert`;
DELIMITER $$
CREATE TRIGGER `after_reparation_insert` AFTER INSERT ON `reparations` FOR EACH ROW BEGIN
    INSERT INTO historique_reparations (
        numero_reparation, id_vehicule, immatriculation, client_nom,
        description, date_entree, date_sortie_prevue, cout_estime, statut, date_archivage
    )
    SELECT 
        NEW.numero_reparation,
        NEW.id_vehicule,
        v.immatriculation,
        CONCAT(c.nom, ' ', c.prenom),
        NEW.description,
        NEW.date_entree,
        NEW.date_sortie_prevue,
        NEW.cout_estime,
        NEW.statut,
        NOW()
    FROM vehicules v
    JOIN clients c ON v.id_client = c.id
    WHERE v.id = NEW.id_vehicule;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `after_reparation_update`;
DELIMITER $$
CREATE TRIGGER `after_reparation_update` AFTER UPDATE ON `reparations` FOR EACH ROW BEGIN
    -- On met à jour TOUTE la ligne dans l'historique
    UPDATE historique_reparations hr
    JOIN vehicules v ON v.id = NEW.id_vehicule
    JOIN clients c ON c.id = v.id_client
    SET 
        hr.id_vehicule = NEW.id_vehicule,
        hr.immatriculation = v.immatriculation,
        hr.client_nom = CONCAT(c.nom, ' ', c.prenom),
        hr.description = NEW.description,
        hr.date_entree = NEW.date_entree,
        hr.date_sortie_prevue = NEW.date_sortie_prevue,
        hr.cout_estime = NEW.cout_estime,
        hr.statut = NEW.statut,
        hr.date_archivage = NOW()
    WHERE hr.numero_reparation = NEW.numero_reparation;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `vehicules`
--

DROP TABLE IF EXISTS `vehicules`;
CREATE TABLE IF NOT EXISTS `vehicules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `immatriculation` varchar(20) NOT NULL,
  `marque` varchar(50) DEFAULT NULL,
  `modele` varchar(50) DEFAULT NULL,
  `annee` int DEFAULT NULL,
  `id_client` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `immatriculation` (`immatriculation`),
  KEY `id_client` (`id_client`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `vehicules`
--

INSERT INTO `vehicules` (`id`, `immatriculation`, `marque`, `modele`, `annee`, `id_client`) VALUES
(13, '2003 TBC', 'KIA', 'Pride', 2006, 4),
(12, '2005 TBC', 'Vols', 'Caddy', 2005, 6);
--
-- Base de données : `gestion_emprunt`
--
CREATE DATABASE IF NOT EXISTS `gestion_emprunt` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `gestion_emprunt`;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add etudiant', 3, 'add_etudiant'),
(6, 'Can change etudiant', 3, 'change_etudiant'),
(7, 'Can delete etudiant', 3, 'delete_etudiant'),
(8, 'Can view etudiant', 3, 'view_etudiant'),
(9, 'Can add objet', 4, 'add_objet'),
(10, 'Can change objet', 4, 'change_objet'),
(11, 'Can delete objet', 4, 'delete_objet'),
(12, 'Can view objet', 4, 'view_objet'),
(13, 'Can add user', 5, 'add_user'),
(14, 'Can change user', 5, 'change_user'),
(15, 'Can delete user', 5, 'delete_user'),
(16, 'Can view user', 5, 'view_user'),
(17, 'Can add emprunt', 2, 'add_emprunt'),
(18, 'Can change emprunt', 2, 'change_emprunt'),
(19, 'Can delete emprunt', 2, 'delete_emprunt'),
(20, 'Can view emprunt', 2, 'view_emprunt'),
(21, 'Can add permission', 7, 'add_permission'),
(22, 'Can change permission', 7, 'change_permission'),
(23, 'Can delete permission', 7, 'delete_permission'),
(24, 'Can view permission', 7, 'view_permission'),
(25, 'Can add group', 6, 'add_group'),
(26, 'Can change group', 6, 'change_group'),
(27, 'Can delete group', 6, 'delete_group'),
(28, 'Can view group', 6, 'view_group'),
(29, 'Can add user', 8, 'add_user'),
(30, 'Can change user', 8, 'change_user'),
(31, 'Can delete user', 8, 'delete_user'),
(32, 'Can view user', 8, 'view_user'),
(33, 'Can add content type', 9, 'add_contenttype'),
(34, 'Can change content type', 9, 'change_contenttype'),
(35, 'Can delete content type', 9, 'delete_contenttype'),
(36, 'Can view content type', 9, 'view_contenttype'),
(37, 'Can add session', 10, 'add_session'),
(38, 'Can change session', 10, 'change_session'),
(39, 'Can delete session', 10, 'delete_session'),
(40, 'Can view session', 10, 'view_session'),
(41, 'Can add categorie', 11, 'add_categorie'),
(42, 'Can change categorie', 11, 'change_categorie'),
(43, 'Can delete categorie', 11, 'delete_categorie'),
(44, 'Can view categorie', 11, 'view_categorie'),
(45, 'Can add historique emprunt', 12, 'add_historiqueemprunt'),
(46, 'Can change historique emprunt', 12, 'change_historiqueemprunt'),
(47, 'Can delete historique emprunt', 12, 'delete_historiqueemprunt'),
(48, 'Can view historique emprunt', 12, 'view_historiqueemprunt');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `backend_categorie`
--

DROP TABLE IF EXISTS `backend_categorie`;
CREATE TABLE IF NOT EXISTS `backend_categorie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `backend_categorie`
--

INSERT INTO `backend_categorie` (`id`, `nom`) VALUES
(2, 'Livre'),
(3, 'Informatique');

-- --------------------------------------------------------

--
-- Structure de la table `backend_emprunt`
--

DROP TABLE IF EXISTS `backend_emprunt`;
CREATE TABLE IF NOT EXISTS `backend_emprunt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_emprunt` datetime(6) NOT NULL,
  `rendu` tinyint(1) NOT NULL,
  `date_rendu` datetime(6) DEFAULT NULL,
  `etudiant_id` bigint NOT NULL,
  `objet_id` bigint NOT NULL,
  `donne_par_id` bigint DEFAULT NULL,
  `quantite` int UNSIGNED NOT NULL,
  `date_retour_prevue` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Backend_emprunt_etudiant_id_4e48c175` (`etudiant_id`),
  KEY `Backend_emprunt_objet_id_feabe9ca` (`objet_id`),
  KEY `Backend_emprunt_donne_par_id_0222dfd2` (`donne_par_id`)
) ;

--
-- Déchargement des données de la table `backend_emprunt`
--

INSERT INTO `backend_emprunt` (`id`, `date_emprunt`, `rendu`, `date_rendu`, `etudiant_id`, `objet_id`, `donne_par_id`, `quantite`, `date_retour_prevue`) VALUES
(1, '2026-04-21 19:22:45.313225', 1, '2026-04-21 19:23:12.971981', 1, 1, 1, 1, NULL),
(2, '2026-04-21 19:23:17.515744', 1, '2026-04-21 19:34:10.164450', 1, 1, 1, 1, NULL),
(3, '2026-04-21 19:33:23.824809', 1, '2026-04-21 19:34:09.687330', 1, 1, 1, 1, NULL),
(4, '2026-04-21 19:33:28.609744', 1, '2026-04-21 19:34:09.217816', 1, 1, 1, 1, NULL),
(5, '2026-04-21 19:33:32.160138', 1, '2026-04-21 19:34:08.803187', 1, 1, 1, 1, NULL),
(6, '2026-04-21 19:33:34.993415', 1, '2026-04-21 19:34:07.719852', 1, 1, 1, 1, NULL),
(7, '2026-04-21 19:33:37.104641', 1, '2026-04-21 19:34:07.250496', 1, 1, 1, 1, NULL),
(8, '2026-04-21 19:33:38.764247', 1, '2026-04-21 19:34:06.825848', 1, 1, 1, 1, NULL),
(9, '2026-04-21 19:33:40.207966', 1, '2026-04-21 19:34:06.327396', 1, 1, 1, 1, NULL),
(10, '2026-04-21 19:34:40.736227', 1, '2026-04-21 19:49:29.347729', 1, 2, 1, 1, NULL),
(15, '2026-04-21 19:57:27.744388', 1, '2026-04-21 19:59:16.210370', 1, 1, 1, 2, NULL),
(14, '2026-04-21 19:57:20.133020', 1, '2026-04-21 19:59:16.957393', 1, 1, 1, 1, NULL),
(16, '2026-04-21 20:00:12.166228', 1, '2026-04-21 20:05:13.106993', 1, 1, 1, 2, NULL),
(17, '2026-04-21 20:05:20.958785', 1, '2026-04-21 20:07:45.163873', 1, 1, 1, 2, NULL),
(18, '2026-04-21 20:07:47.866420', 1, '2026-04-21 20:11:38.679397', 1, 1, 1, 2, NULL),
(19, '2026-04-21 20:11:44.877484', 1, '2026-04-21 20:12:28.838553', 1, 1, 1, 8, NULL),
(20, '2026-04-21 20:13:13.033365', 1, '2026-04-21 20:24:16.958724', 1, 1, 1, 3, NULL),
(21, '2026-04-21 20:54:51.421670', 1, '2026-04-24 06:22:15.046536', 1, 1, 1, 4, NULL),
(22, '2026-04-24 06:22:02.628704', 1, '2026-04-24 06:22:11.243144', 1, 2, 1, 1, NULL),
(23, '2026-04-24 17:33:06.260003', 1, '2026-04-24 18:12:32.933111', 1, 1, 1, 1, NULL),
(24, '2026-04-24 18:12:50.786730', 1, '2026-04-24 18:22:22.099807', 1, 1, 1, 1, NULL),
(25, '2026-04-24 18:16:55.880922', 1, '2026-04-24 18:17:20.692649', 1, 1, 1, 1, NULL),
(26, '2026-04-24 18:21:52.144735', 1, '2026-04-24 18:22:08.289630', 1, 1, 1, 1, NULL),
(27, '2026-04-24 18:23:07.892838', 1, '2026-04-24 18:23:15.532819', 1, 1, 1, 1, NULL),
(28, '2026-04-24 18:30:26.580435', 1, '2026-04-24 18:30:35.703315', 1, 1, 1, 1, NULL),
(29, '2026-04-24 18:31:01.144333', 1, '2026-04-24 18:35:03.738896', 1, 1, 1, 4, NULL),
(31, '2026-04-24 18:34:22.942905', 1, '2026-04-24 18:35:04.756795', 1, 2, 1, 1, NULL),
(32, '2026-04-24 18:35:17.994230', 1, '2026-04-24 18:35:27.558008', 1, 1, 1, 5, NULL),
(36, '2026-04-24 19:10:25.389922', 1, '2026-04-24 19:28:58.068634', 1, 1, 1, 1, NULL),
(38, '2026-04-24 19:42:49.811373', 1, '2026-04-24 19:43:08.608588', 1, 1, 1, 1, NULL),
(39, '2026-04-24 20:01:20.547798', 0, NULL, 1, 1, 1, 1, NULL),
(40, '2026-04-24 20:10:46.416528', 0, NULL, 1, 3, 1, 2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `backend_etudiant`
--

DROP TABLE IF EXISTS `backend_etudiant`;
CREATE TABLE IF NOT EXISTS `backend_etudiant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_etudiant` varchar(50) NOT NULL,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_etudiant` (`numero_etudiant`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `backend_etudiant`
--

INSERT INTO `backend_etudiant` (`id`, `numero_etudiant`, `nom`) VALUES
(1, 'SE20230016', 'Nantenaina'),
(2, 'SE20230015', 'RAJAONARIVELO');

-- --------------------------------------------------------

--
-- Structure de la table `backend_historiqueemprunt`
--

DROP TABLE IF EXISTS `backend_historiqueemprunt`;
CREATE TABLE IF NOT EXISTS `backend_historiqueemprunt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `etudiant` varchar(100) NOT NULL,
  `objet` varchar(100) NOT NULL,
  `donne_par` varchar(100) DEFAULT NULL,
  `quantite` int UNSIGNED NOT NULL,
  `date_emprunt` datetime(6) NOT NULL,
  `date_rendu` datetime(6) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `action` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `emprunt_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Déchargement des données de la table `backend_historiqueemprunt`
--

INSERT INTO `backend_historiqueemprunt` (`id`, `etudiant`, `objet`, `donne_par`, `quantite`, `date_emprunt`, `date_rendu`, `status`, `action`, `created_at`, `emprunt_id`) VALUES
(20, 'Nantenaina', 'Ordinateur Portable HP', 'Tojo', 2, '2026-04-24 20:10:46.416528', NULL, 'NON_RENDU', 'EMPRUNT_CREE', '2026-04-24 20:10:46.417543', 40),
(19, 'Nantenaina', 'HDMI', 'Tojo', 1, '2026-04-24 20:01:20.547798', NULL, 'NON_RENDU', 'EMPRUNT_CREE', '2026-04-24 20:01:20.547798', 39),
(18, 'Nantenaina', 'HDMI', 'Tojo', 1, '2026-04-24 19:42:49.811373', '2026-04-24 19:43:08.608588', 'RENDU', 'RETOUR', '2026-04-24 19:42:49.812372', 38);

-- --------------------------------------------------------

--
-- Structure de la table `backend_objet`
--

DROP TABLE IF EXISTS `backend_objet`;
CREATE TABLE IF NOT EXISTS `backend_objet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `quantite_totale` int UNSIGNED NOT NULL,
  `categorie_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Backend_objet_categorie_id_1817ae16` (`categorie_id`)
) ;

--
-- Déchargement des données de la table `backend_objet`
--

INSERT INTO `backend_objet` (`id`, `nom`, `quantite_totale`, `categorie_id`) VALUES
(1, 'HDMI', 8, 2),
(2, 'Scanner', 1, 3),
(3, 'Ordinateur Portable HP', 20, 3);

-- --------------------------------------------------------

--
-- Structure de la table `backend_user`
--

DROP TABLE IF EXISTS `backend_user`;
CREATE TABLE IF NOT EXISTS `backend_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `backend_user`
--

INSERT INTO `backend_user` (`id`, `username`, `password`, `is_admin`, `is_active`) VALUES
(1, 'Tojo', 'pbkdf2_sha256$1200000$vZS0lwzEZRP0NE9al7M01M$lRrfTXgs3F1+tBy6GabcGVFPRoswte45NcpP4y+q0VE=', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'Backend', 'emprunt'),
(3, 'Backend', 'etudiant'),
(4, 'Backend', 'objet'),
(5, 'Backend', 'user'),
(6, 'auth', 'group'),
(7, 'auth', 'permission'),
(8, 'auth', 'user'),
(9, 'contenttypes', 'contenttype'),
(10, 'sessions', 'session'),
(11, 'Backend', 'categorie'),
(12, 'Backend', 'historiqueemprunt');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(20, 'Backend', '0001_initial', '2026-04-21 19:04:28.867859'),
(2, 'contenttypes', '0001_initial', '2026-04-21 17:29:38.578987'),
(3, 'auth', '0001_initial', '2026-04-21 17:29:38.843747'),
(4, 'admin', '0001_initial', '2026-04-21 17:29:38.946389'),
(5, 'admin', '0002_logentry_remove_auto_add', '2026-04-21 17:29:38.951478'),
(6, 'admin', '0003_logentry_add_action_flag_choices', '2026-04-21 17:29:38.956387'),
(7, 'contenttypes', '0002_remove_content_type_name', '2026-04-21 17:29:39.002683'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-04-21 17:29:39.022913'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-04-21 17:29:39.047589'),
(10, 'auth', '0004_alter_user_username_opts', '2026-04-21 17:29:39.051589'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-04-21 17:29:39.090501'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-04-21 17:29:39.091826'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-04-21 17:29:39.097832'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-04-21 17:29:39.122029'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-04-21 17:29:39.144629'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-04-21 17:29:39.165979'),
(17, 'auth', '0011_update_proxy_permissions', '2026-04-21 17:29:39.175276'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-04-21 17:29:39.194909'),
(19, 'sessions', '0001_initial', '2026-04-21 17:29:39.215828'),
(21, 'Backend', '0002_emprunt_quantite', '2026-04-21 19:38:42.684290'),
(22, 'Backend', '0003_categorie_objet_categorie', '2026-04-24 16:59:36.356632'),
(23, 'Backend', '0004_historiqueemprunt', '2026-04-24 18:05:08.232187'),
(24, 'Backend', '0005_historiqueemprunt_emprunt_id', '2026-04-24 18:29:40.963835'),
(25, 'Backend', '0006_emprunt_date_retour_prevue', '2026-04-24 19:17:07.404217');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2flnqzf7ccujbe5pj342dgfa0tsoldmt', 'eyJ1c2VyX2lkIjoxLCJ1c2VybmFtZSI6IlRvam8ifQ:1wGKvK:EPlesdxJ_7BGrpFtu1-WOG82GHzkYpyUZim0cAAC_UE', '2026-05-08 18:06:42.436496');
--
-- Base de données : `gestion_service_technique`
--
CREATE DATABASE IF NOT EXISTS `gestion_service_technique` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `gestion_service_technique`;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `nif` varchar(20) NOT NULL,
  `stat` varchar(20) DEFAULT NULL,
  `rapport_intervention` blob,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contrats`
--

DROP TABLE IF EXISTS `contrats`;
CREATE TABLE IF NOT EXISTS `contrats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vente_id` int NOT NULL,
  `type_contrat` enum('garantie','maintenance') NOT NULL,
  `date_contrat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `date_fin` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vente_id` (`vente_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `equipements`
--

DROP TABLE IF EXISTS `equipements`;
CREATE TABLE IF NOT EXISTS `equipements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `nombre` int NOT NULL,
  `numero_serie` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `machines`
--

DROP TABLE IF EXISTS `machines`;
CREATE TABLE IF NOT EXISTS `machines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_machine` varchar(255) NOT NULL,
  `type_machine` varchar(100) NOT NULL,
  `numero_serie` varchar(100) NOT NULL,
  `date_arrivee` date NOT NULL,
  `date_vente` date DEFAULT NULL,
  `IDM` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_serie` (`numero_serie`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pieces_de_rechange`
--

DROP TABLE IF EXISTS `pieces_de_rechange`;
CREATE TABLE IF NOT EXISTS `pieces_de_rechange` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) NOT NULL,
  `numero_serie` varchar(100) NOT NULL,
  `machine_id` int DEFAULT NULL,
  `nombre_pieces` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `machine_id` (`machine_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`) VALUES
(1, 'admin', 'admin123', '2025-07-22 11:51:30');

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `fuel_consumption` decimal(10,2) NOT NULL,
  `last_technical_visit` date DEFAULT NULL,
  `next_service` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

DROP TABLE IF EXISTS `ventes`;
CREATE TABLE IF NOT EXISTS `ventes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `type_materiel` enum('machine','equipement','piece_de_rechange') NOT NULL,
  `machine_id` int DEFAULT NULL,
  `equipement_id` int DEFAULT NULL,
  `piece_id` int DEFAULT NULL,
  `date_vente` date NOT NULL,
  `nombre` int NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `mode_paiement` enum('especes','carte') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `machine_id` (`machine_id`),
  KEY `equipement_id` (`equipement_id`),
  KEY `piece_id` (`piece_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `mndpt_db`
--
CREATE DATABASE IF NOT EXISTS `mndpt_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `mndpt_db`;
--
-- Base de données : `mndpt_db_ok`
--
CREATE DATABASE IF NOT EXISTS `mndpt_db_ok` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `mndpt_db_ok`;

-- --------------------------------------------------------

--
-- Structure de la table `affectations_affectation`
--

DROP TABLE IF EXISTS `affectations_affectation`;
CREATE TABLE IF NOT EXISTS `affectations_affectation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reference` varchar(50) NOT NULL,
  `date_creation` date NOT NULL,
  `auteur_id` bigint NOT NULL,
  `direction_id` bigint NOT NULL,
  `materiel_id` bigint NOT NULL,
  `utilisateur_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  UNIQUE KEY `materiel_id` (`materiel_id`),
  KEY `affectations_affectation_auteur_id_8b3c1357` (`auteur_id`),
  KEY `affectations_affectation_direction_id_408266ee` (`direction_id`),
  KEY `affectations_affectation_utilisateur_id_441ee79d` (`utilisateur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `affectations_affectation`
--

INSERT INTO `affectations_affectation` (`id`, `reference`, `date_creation`, `auteur_id`, `direction_id`, `materiel_id`, `utilisateur_id`) VALUES
(19, 'ref n°004/2025/MNDPT/', '2025-09-24', 1, 15, 48, 1),
(16, 'ref n°001/2025/MNDPT/', '2025-09-24', 1, 15, 43, 1),
(20, 'ref n°005/2025/MNDPT/', '2025-09-24', 1, 15, 46, 4),
(18, 'ref n°003/2025/MNDPT/', '2025-09-24', 1, 14, 45, 3);

-- --------------------------------------------------------

--
-- Structure de la table `audit_auditlog`
--

DROP TABLE IF EXISTS `audit_auditlog`;
CREATE TABLE IF NOT EXISTS `audit_auditlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(10) NOT NULL,
  `table` varchar(100) NOT NULL,
  `reference_id` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `utilisateur_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_auditlog_utilisateur_id_1d7845f4` (`utilisateur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `audit_auditlog`
--

INSERT INTO `audit_auditlog` (`id`, `action`, `table`, `reference_id`, `description`, `timestamp`, `utilisateur_id`) VALUES
(4, 'CREATE', 'Materiel', '4', 'Création du matériel B001 (ID=4)', '2025-08-01 06:58:48.022949', 4),
(3, 'DELETE', 'Materiel', '3', 'Suppression du matériel B001 (ID=3)', '2025-07-31 09:39:15.519668', 3),
(5, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-01 11:27:13.639397', 1),
(6, 'CREATE', 'Materiel', '5', 'Création du matériel B002 (ID=5)', '2025-08-01 11:46:35.202232', 1),
(7, 'CREATE', 'Incident', '11', 'Incident ID 11 créé pour matériel ID 4.', '2025-08-01 11:47:06.868418', 1),
(8, 'Modifier', 'User', '1', 'Demande de réinitialisation du mot de passe.', '2025-08-01 11:51:23.288262', 1),
(9, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-01 11:51:38.952133', 1),
(10, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-01 11:56:11.649878', 1),
(11, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-01 12:01:48.644989', 4),
(12, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 08:29:35.062904', 4),
(13, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 08:40:26.543212', 4),
(14, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 09:35:02.932427', 4),
(15, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 10:12:51.939883', 4),
(16, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 11:37:00.473006', 4),
(17, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 12:43:59.360307', 4),
(18, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 12:45:31.097370', 4),
(19, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 12:50:34.090544', 4),
(20, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-04 13:50:12.397819', 4),
(21, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-05 05:06:54.866104', 4),
(22, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-05 06:17:18.882800', 4),
(23, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-05 07:05:02.082373', 4),
(24, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-06 06:25:29.399614', 4),
(25, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-06 06:26:25.513174', 4),
(26, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-06 06:28:09.688685', 4),
(27, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-08-06 06:46:32.150787', 4),
(28, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-06 06:49:09.051672', 2),
(29, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-06 06:49:15.585696', 2),
(30, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-06 06:49:15.676798', 2),
(31, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-06 06:49:56.235572', 1),
(32, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-06 06:50:06.284992', 1),
(33, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-07 04:59:28.131791', 1),
(34, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-13 09:18:47.614025', 1),
(35, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-13 13:07:28.189035', 1),
(36, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-13 14:01:58.555580', 1),
(37, 'UPDATE', 'Incident', '11', 'Incident ID 11 modifié.', '2025-08-13 14:04:00.034203', 1),
(38, 'CREATE', 'Affectation', '5', 'Affectation ID 5 créée.', '2025-08-13 14:05:27.242718', 1),
(39, 'CREATE', 'Incident', '12', 'Incident ID 12 créé pour matériel ID 5.', '2025-08-13 14:05:41.115727', 1),
(40, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-13 14:09:45.787675', 2),
(41, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-13 14:10:13.852429', 1),
(42, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-23 03:40:35.442629', 1),
(43, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-23 03:41:28.381908', 1),
(44, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-25 03:43:00.986718', 1),
(45, 'EXPORT', 'Affectation', '5', 'Export PDF de l’affectation ID 5.', '2025-08-25 03:43:06.342819', 1),
(46, 'EXPORT', 'Affectation', '5', 'Export PDF de l’affectation ID 5.', '2025-08-25 03:43:06.422695', 1),
(47, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 03:51:32.116322', 1),
(48, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 03:51:46.461577', 1),
(49, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 03:51:58.052173', 1),
(50, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-25 04:05:20.449895', 1),
(51, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:08:49.633526', 1),
(52, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:08:53.855233', 1),
(53, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:11:22.354482', 1),
(54, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:11:51.163816', 1),
(55, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:12:17.688790', 1),
(56, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:16:04.052836', 1),
(57, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:16:55.655189', 1),
(58, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:18:02.520149', 1),
(59, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:20:21.137003', 1),
(60, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:20:26.129569', 1),
(61, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:22:25.490165', 1),
(62, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:22:31.567076', 1),
(63, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:24:29.722020', 1),
(64, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 04:24:33.672065', 1),
(65, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-25 06:40:27.656186', 1),
(66, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 06:40:31.025968', 1),
(67, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-25 06:48:12.220298', 1),
(68, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-25 06:48:51.033646', 2),
(69, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-25 06:50:19.217684', 1),
(70, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-25 12:27:57.693232', 1),
(71, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-26 16:12:14.674862', 1),
(72, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 05:32:49.922410', 1),
(73, 'UPDATE', 'Incident', '12', 'Incident ID 12 modifié.', '2025-08-27 05:33:18.797258', 1),
(74, 'Modifier', 'User', '1', 'Demande de réinitialisation du mot de passe.', '2025-08-27 06:00:39.799013', 1),
(75, 'Modifier', 'User', '1', 'Mot de passe réinitialisé avec succès.', '2025-08-27 06:01:12.025241', 1),
(76, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 06:01:35.652684', 1),
(77, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 06:11:12.942419', 1),
(78, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 06:12:38.128047', 1),
(79, 'EXPORT', 'Affectation', '5', 'Export PDF de l’affectation ID 5.', '2025-08-27 06:13:31.404897', 1),
(80, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-27 06:14:33.916493', 2),
(81, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 06:15:00.602938', 1),
(82, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-27 06:30:01.646031', 1),
(83, 'EXPORT', 'Affectation', '4', 'Export PDF de l’affectation ID 4.', '2025-08-27 06:38:06.623139', 1),
(84, 'Modifier', 'User', '3', 'Utilisateur ratovomaroagnessydonie@gmail.com modifié.', '2025-08-27 06:40:00.522864', 1),
(85, 'CREATE', 'Materiel', '6', 'Création du matériel B003 (ID=6)', '2025-08-27 06:43:10.875539', 1),
(86, 'CREATE', 'Affectation', '6', 'Affectation ID 6 créée.', '2025-08-27 06:43:31.366195', 1),
(87, 'EXPORT', 'Affectation', '6', 'Export PDF de l’affectation ID 6.', '2025-08-27 06:43:38.869272', 1),
(88, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 08:38:11.876330', 1),
(89, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 09:59:10.625711', 1),
(90, 'CREATE', 'Materiel', '7', 'Création du matériel B004 (ID=7)', '2025-08-27 10:18:18.336771', 1),
(91, 'CREATE', 'Affectation', '7', 'Affectation ID 7 créée.', '2025-08-27 10:18:57.615531', 1),
(92, 'EXPORT', 'Affectation', '7', 'Export PDF de l’affectation ID 7.', '2025-08-27 10:19:20.556639', 1),
(93, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-27 10:20:03.625757', 2),
(94, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 10:21:59.802764', 1),
(95, 'CREATE', 'Materiel', '8', 'Création du matériel OP001 (ID=8)', '2025-08-27 10:27:44.469673', 1),
(96, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 12:40:03.429312', 1),
(97, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-27 12:40:09.733555', 2),
(98, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-27 12:46:38.321119', 2),
(99, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-27 12:49:22.421625', 2),
(100, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 12:56:59.323578', 1),
(101, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 13:10:36.774057', 1),
(102, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 14:26:40.926930', 1),
(103, 'CREATE', 'Materiel', '9', 'Création du matériel B005 (ID=9)', '2025-08-27 14:26:58.399399', 1),
(104, 'CREATE', 'Materiel', '10', 'Création du matériel B006 (ID=10)', '2025-08-27 14:26:59.811818', 1),
(105, 'DELETE', 'Materiel', '10', 'Suppression du matériel B006 (ID=10)', '2025-08-27 14:31:32.594420', 1),
(106, 'DELETE', 'Materiel', '9', 'Suppression du matériel B005 (ID=9)', '2025-08-27 14:31:36.498874', 1),
(107, 'DELETE', 'Materiel', '8', 'Suppression du matériel OP001 (ID=8)', '2025-08-27 14:31:38.788875', 1),
(108, 'CREATE', 'Materiel', '11', 'Création du matériel B005 (ID=11)', '2025-08-27 14:31:57.690863', 1),
(109, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 15:28:18.139503', 1),
(110, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 16:59:52.766088', 1),
(111, 'CREATE', 'Materiel', '12', 'Création du matériel OP001 (ID=12)', '2025-08-27 17:00:13.122430', 1),
(112, 'CREATE', 'Materiel', '13', 'Création du matériel B006 (ID=13)', '2025-08-27 17:04:45.122359', 1),
(113, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 18:01:52.446114', 1),
(114, 'DELETE', 'Affectation', '6', 'Affectation ID 6 supprimée.', '2025-08-27 18:05:30.819625', 1),
(115, 'CREATE', 'Affectation', '8', 'Affectation ID 8 créée.', '2025-08-27 18:05:44.360234', 1),
(116, 'CREATE', 'Incident', '13', 'Incident ID 13 créé pour matériel ID 11.', '2025-08-27 18:05:59.656904', 1),
(117, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-27 18:13:47.421889', 1),
(118, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 06:25:36.877884', 1),
(119, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 07:22:35.377442', 1),
(120, 'CREATE', 'Materiel', '14', 'Création du matériel IP001 (ID=14)', '2025-08-29 08:18:47.229124', 1),
(121, 'DELETE', 'Materiel', '14', 'Suppression du matériel IP001 (ID=14)', '2025-08-29 08:19:34.935502', 1),
(122, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 08:28:51.660566', 1),
(123, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 09:24:59.665177', 1),
(124, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 09:30:56.464550', 1),
(125, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 09:37:11.364084', 1),
(126, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 09:47:49.544658', 1),
(127, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-29 16:45:31.116394', 1),
(128, 'DELETE', 'Incident', '12', 'Incident ID 12 supprimé pour matériel ID 5.', '2025-08-29 16:49:41.476335', 1),
(129, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-29 16:58:51.305708', 2),
(130, 'EXPORT', 'Affectation', '5', 'Export PDF de l’affectation ID 5.', '2025-08-29 17:07:58.991515', 2),
(131, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-29 17:08:21.923386', 2),
(132, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-30 06:54:16.091974', 2),
(133, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-30 07:17:59.780074', 2),
(134, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-30 07:18:56.810238', 1),
(135, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-30 07:29:56.885532', 2),
(136, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-30 07:58:57.277840', 1),
(137, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-30 08:04:35.464878', 2),
(138, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-30 08:04:51.082566', 1),
(139, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-30 08:05:47.971383', 1),
(140, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-30 08:05:55.661011', 2),
(141, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-30 08:06:09.616402', 1),
(142, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-08-30 08:12:56.307559', 2),
(143, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-08-30 08:13:10.891157', 1),
(144, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-09-01 05:48:21.768390', 2),
(145, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-01 06:22:21.622179', 1),
(146, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-09-01 06:31:18.322557', 2),
(147, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-01 06:36:11.776017', 1),
(148, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-09-01 06:40:03.893470', 2),
(149, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-03 06:13:23.867203', 1),
(150, 'Ajouter', 'User', '5', 'Utilisateur rajaonarivelo@gmail.com créé.', '2025-09-03 06:15:36.723064', 1),
(151, 'Connexion', 'User', '5', 'Connexion réussie.', '2025-09-03 06:16:02.152025', NULL),
(152, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-03 06:49:02.334083', 1),
(153, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-03 08:03:33.310890', 1),
(154, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-04 10:49:40.926362', 1),
(155, 'CREATE', 'Materiel', '15', 'Création du matériel IP001 (ID=15)', '2025-09-04 10:50:04.489897', 1),
(156, 'CREATE', 'Affectation', '9', 'Affectation ID 9 créée.', '2025-09-04 10:50:29.300898', 1),
(157, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-05 07:19:58.189489', 1),
(158, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-08 20:01:34.805385', 1),
(159, 'CREATE', 'Materiel', '16', 'Création du matériel SC001 (ID=16)', '2025-09-08 20:02:40.659107', 1),
(160, 'CREATE', 'Affectation', '10', 'Affectation ID 10 créée.', '2025-09-08 20:05:50.361997', 1),
(161, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-09 08:14:26.241011', 1),
(162, 'Modifier', 'User', '5', 'Utilisateur rajaonarivelo@gmail.com modifié.', '2025-09-09 08:15:21.171866', 1),
(163, 'Modifier', 'User', '2', 'Utilisateur gest@gmail.com modifié.', '2025-09-09 08:16:25.828130', 1),
(164, 'Connexion', 'User', '3', 'Connexion réussie.', '2025-09-09 08:17:06.423409', 3),
(165, 'Connexion', 'User', '5', 'Connexion réussie.', '2025-09-09 08:17:19.703311', NULL),
(166, 'Modifier', 'User', '3', 'Demande de réinitialisation du mot de passe.', '2025-09-09 08:21:34.054834', 3),
(167, 'Modifier', 'User', '3', 'Mot de passe réinitialisé avec succès.', '2025-09-09 08:24:17.667091', 3),
(168, 'Connexion', 'User', '3', 'Connexion réussie.', '2025-09-09 08:24:31.267449', 3),
(169, 'Connexion', 'User', '2', 'Connexion réussie.', '2025-09-17 15:23:43.835819', 2),
(170, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-18 11:27:52.464236', 1),
(171, 'Supprimer', 'User', '5', 'Utilisateur rajaonarivelo@gmail.com supprimé.', '2025-09-18 11:35:55.302104', 1),
(172, 'DELETE', 'Materiel', '7', 'Suppression du matériel B004 (ID=7)', '2025-09-18 11:54:09.028811', 1),
(173, 'DELETE', 'Materiel', '5', 'Suppression du matériel B002 (ID=5)', '2025-09-18 12:15:01.312071', 1),
(174, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-18 12:30:31.258947', 1),
(175, 'DELETE', 'Materiel', '16', 'Suppression du matériel SC001 (ID=16)', '2025-09-18 12:40:21.549696', 1),
(176, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 07:08:57.680201', 1),
(177, 'CREATE', 'Materiel', '17', 'Création du matériel B007 (ID=17)', '2025-09-21 07:18:38.535815', 1),
(178, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 07:26:59.827114', 1),
(179, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 07:29:23.517908', 1),
(180, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-09-21 07:34:52.710738', 4),
(181, 'Modifier', 'User', '1', 'Utilisateur rajaonarivelonantenaina733@gmail.com modifié.', '2025-09-21 07:39:09.681381', 4),
(182, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 07:40:23.136566', 1),
(183, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 07:48:43.211484', 1),
(184, 'Modifier', 'User', '1', 'Utilisateur rajaonarivelonantenaina733@gmail.com modifié.', '2025-09-21 08:07:46.751979', 1),
(185, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:24:18.078296', 1),
(186, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:24:30.083716', 1),
(187, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:31:17.161498', 1),
(188, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:31:29.374001', 1),
(189, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:31:58.832020', 1),
(190, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:32:40.671499', 1),
(191, 'DELETE', 'Materiel', '17', 'Suppression du matériel B007 (ID=17)', '2025-09-21 08:39:08.537522', 1),
(192, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:42:25.083803', 1),
(193, 'CREATE', 'Materiel', '22', 'Création du matériel B011 (ID=22)', '2025-09-21 08:47:59.076719', 1),
(194, 'DELETE', 'Materiel', '21', 'Suppression du matériel B010 (ID=21)', '2025-09-21 08:48:15.369169', 1),
(195, 'CREATE', 'Materiel', '23', 'Création du matériel B012 (ID=23)', '2025-09-21 08:48:33.763227', 1),
(196, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:49:18.000078', 1),
(197, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 08:50:40.571315', 1),
(198, 'DELETE', 'Materiel', '23', 'Suppression du matériel B012 (ID=23)', '2025-09-21 08:52:33.162072', 1),
(199, 'CREATE', 'Materiel', '27', 'Création du matériel B014 (ID=27)', '2025-09-21 08:58:23.937749', 1),
(200, 'DELETE', 'Materiel', '24', 'Suppression du matériel  (ID=24)', '2025-09-21 08:59:51.253797', 1),
(201, 'DELETE', 'Materiel', '26', 'Suppression du matériel B013 (ID=26)', '2025-09-21 08:59:53.280373', 1),
(202, 'DELETE', 'Materiel', '25', 'Suppression du matériel B012 (ID=25)', '2025-09-21 08:59:55.620102', 1),
(203, 'DELETE', 'Materiel', '27', 'Suppression du matériel B014 (ID=27)', '2025-09-21 09:00:10.974249', 1),
(204, 'CREATE', 'Materiel', '28', 'Création du matériel IP002 (ID=28)', '2025-09-21 09:00:28.968634', 1),
(205, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:01:13.749749', 1),
(206, 'CREATE', 'Materiel', '29', 'Création du matériel OP002 (ID=29)', '2025-09-21 09:08:12.799190', 1),
(207, 'DELETE', 'Materiel', '29', 'Suppression du matériel OP002 (ID=29)', '2025-09-21 09:11:23.834916', 1),
(208, 'CREATE', 'Materiel', '30', 'Création du matériel OP002 (ID=30)', '2025-09-21 09:11:36.830027', 1),
(209, 'DELETE', 'Materiel', '30', 'Suppression du matériel OP002 (ID=30)', '2025-09-21 09:13:15.064291', 1),
(210, 'CREATE', 'Materiel', '31', 'Création du matériel OP002 (ID=31)', '2025-09-21 09:13:29.349792', 1),
(211, 'DELETE', 'Materiel', '31', 'Suppression du matériel OP002 (ID=31)', '2025-09-21 09:14:15.931313', 1),
(212, 'CREATE', 'Materiel', '32', 'Création du matériel OP002 (ID=32)', '2025-09-21 09:14:29.170607', 1),
(213, 'DELETE', 'Materiel', '32', 'Suppression du matériel OP002 (ID=32)', '2025-09-21 09:17:24.919692', 1),
(214, 'CREATE', 'Materiel', '33', 'Création du matériel OP002 (ID=33)', '2025-09-21 09:17:37.443649', 1),
(215, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:17:59.837078', 1),
(216, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:18:26.181294', 1),
(217, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:19:13.265770', 1),
(218, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:20:21.819647', 1),
(219, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:21:30.809949', 1),
(220, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:21:42.235739', 1),
(221, 'CREATE', 'Materiel', '34', 'Création du matériel OP003 (ID=34)', '2025-09-21 09:26:44.698260', 1),
(222, 'DELETE', 'Materiel', '34', 'Suppression du matériel OP003 (ID=34)', '2025-09-21 09:35:48.502932', 1),
(223, 'CREATE', 'Materiel', '35', 'Création du matériel OP003 (ID=35)', '2025-09-21 09:35:57.858737', 1),
(224, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:36:32.044181', 1),
(225, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:36:47.024090', 1),
(226, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:40:59.573762', 1),
(227, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:44:48.204720', 1),
(228, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:45:07.014129', 1),
(229, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:46:08.830586', 1),
(230, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:50:19.528625', 1),
(231, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:56:49.397037', 1),
(232, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:57:36.749089', 1),
(233, 'DELETE', 'Materiel', '35', 'Suppression du matériel OP003 (ID=35)', '2025-09-21 09:58:13.279514', 1),
(234, 'CREATE', 'Materiel', '36', 'Création du matériel B012 (ID=36)', '2025-09-21 09:58:45.612656', 1),
(235, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 09:59:26.581721', 1),
(236, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:09:10.803570', 1),
(237, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:12:11.399475', 1),
(238, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:12:39.166148', 1),
(239, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:13:05.647332', 1),
(240, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:13:40.808514', 1),
(241, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:19:24.563876', 1),
(242, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:23:57.746703', 1),
(243, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:33:11.710699', 1),
(244, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:34:06.269079', 1),
(245, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:35:09.493192', 1),
(246, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:35:30.569075', 1),
(247, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:36:00.546732', 1),
(248, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:37:19.046542', 1),
(249, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:37:39.843340', 1),
(250, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:49:02.894783', 1),
(251, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:49:16.067930', 1),
(252, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:49:33.670124', 1),
(253, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:50:03.425293', 1),
(254, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 10:57:48.382811', 1),
(255, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:01:01.972667', 1),
(256, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:06:15.998610', 1),
(257, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:08:29.180591', 1),
(258, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:13:27.470017', 1),
(259, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:15:59.498810', 1),
(260, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:22:27.888725', 1),
(261, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:26:28.998928', 1),
(262, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:29:07.498061', 1),
(263, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 11:30:03.278887', 1),
(264, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 12:32:06.598920', 1),
(265, 'DELETE', 'Materiel', '20', 'Suppression du matériel B009 (ID=20)', '2025-09-21 12:32:22.682132', 1),
(266, 'DELETE', 'Materiel', '4', 'Suppression du matériel B001 (ID=4)', '2025-09-21 12:32:25.307452', 1),
(267, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 12:32:45.072905', 1),
(268, 'DELETE', 'Materiel', '36', 'Suppression du matériel B012 (ID=36)', '2025-09-21 12:32:49.285204', 1),
(269, 'CREATE', 'Materiel', '37', 'Création du matériel B001 (ID=37)', '2025-09-21 12:33:05.971139', 1),
(270, 'CREATE', 'Materiel', '38', 'Création du matériel OP001 (ID=38)', '2025-09-21 12:33:46.198274', 1),
(271, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 12:35:13.692530', 1),
(272, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 12:37:21.236005', 1),
(273, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-21 12:38:00.619638', 1),
(274, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-22 06:12:07.437589', 1),
(275, 'CREATE', 'Materiel', '39', 'Création du matériel IP001 (ID=39)', '2025-09-22 06:12:41.997164', 1),
(276, 'DELETE', 'Affectation', '9', 'Affectation ID 9 supprimée.', '2025-09-22 06:14:30.814943', 1),
(277, 'DELETE', 'Affectation', '8', 'Affectation ID 8 supprimée.', '2025-09-22 06:14:33.567957', 1),
(278, 'CREATE', 'Affectation', '11', 'Affectation ID 11 crée.', '2025-09-22 06:14:44.715611', 1),
(279, 'CREATE', 'Affectation', '12', 'Affectation ID 12 crée.', '2025-09-22 06:16:00.008138', 1),
(280, 'DELETE', 'Affectation', '11', 'Affectation ID 11 supprimée.', '2025-09-22 06:16:07.651439', 1),
(281, 'CREATE', 'Affectation', '13', 'Affectation ID 13 crée.', '2025-09-22 06:16:15.407081', 1),
(282, 'CREATE', 'Incident', '14', 'Incident ID 14 créé pour matériel ID 39.', '2025-09-22 06:17:14.472012', 1),
(283, 'DELETE', 'Materiel', '39', 'Suppression du matériel IP001 (ID=39)', '2025-09-22 06:18:47.277599', 1),
(284, 'Modifier', 'User', '4', 'Utilisateur handriolahsolofo@gmail.com modifié.', '2025-09-22 06:19:13.644074', 1),
(285, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-09-22 06:19:36.445709', 4),
(286, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-22 06:20:15.219552', 1),
(287, 'CREATE', 'Materiel', '40', 'Création du matériel IP001 (ID=40)', '2025-09-22 06:58:51.850157', 1),
(288, 'CREATE', 'Affectation', '14', 'Affectation ID 14 crée.', '2025-09-22 06:59:45.532554', 1),
(289, 'CREATE', 'Incident', '15', 'Incident ID 15 créé pour matériel ID 40.', '2025-09-22 07:00:03.391367', 1),
(290, 'DELETE', 'Incident', '15', 'Incident ID 15 supprimé pour matériel ID 40.', '2025-09-22 07:04:31.975321', 1),
(291, 'DELETE', 'Materiel', '40', 'Suppression du matériel IP001 (ID=40)', '2025-09-22 07:04:52.015851', 1),
(292, 'CREATE', 'Materiel', '41', 'Création du matériel IP001 (ID=41)', '2025-09-22 07:05:17.424228', 1),
(293, 'CREATE', 'Affectation', '15', 'Affectation ID 15 crée.', '2025-09-22 07:06:02.843988', 1),
(294, 'CREATE', 'Incident', '16', 'Incident ID 16 créé pour matériel ID 41.', '2025-09-22 07:06:21.324647', 1),
(295, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-22 09:34:53.598864', 1),
(296, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:48.742184', 1),
(297, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:49.950175', 1),
(298, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:53.667310', 1),
(299, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:53.961606', 1),
(300, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:54.177775', 1),
(301, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:54.287227', 1),
(302, 'EXPORT', 'Affectation', '12', 'Export PDF de l’affectation ID 12.', '2025-09-22 09:36:54.290216', 1),
(303, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 06:47:56.929561', 1),
(304, 'CREATE', 'Materiel', '42', 'Création du matériel B002 (ID=42)', '2025-09-23 07:12:13.596806', 1),
(305, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 07:12:56.098074', 1),
(306, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 07:14:58.186898', 1),
(307, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 07:49:50.330995', 1),
(308, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 07:54:37.409800', 1),
(309, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 08:29:42.801405', 1),
(310, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 09:29:47.686218', 1),
(311, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 11:53:06.251116', 1),
(312, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 11:54:01.272692', 1),
(313, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 18:30:39.157181', 1),
(314, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 19:17:24.966610', 1),
(315, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-09-23 19:17:39.841547', 4),
(316, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 19:17:54.371083', 1),
(317, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-23 19:23:07.962700', 1),
(318, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 02:19:01.877651', 1),
(319, 'DELETE', 'Materiel', '38', 'Suppression du matériel OP001 (ID=38)', '2025-09-24 02:21:06.573153', 1),
(320, 'DELETE', 'Materiel', '41', 'Suppression du matériel IP001 (ID=41)', '2025-09-24 02:21:10.565795', 1),
(321, 'DELETE', 'Materiel', '42', 'Suppression du matériel B002 (ID=42)', '2025-09-24 02:21:21.709314', 1),
(322, 'DELETE', 'Materiel', '37', 'Suppression du matériel B001 (ID=37)', '2025-09-24 02:21:25.456407', 1),
(323, 'CREATE', 'Materiel', '43', 'Création du matériel B001 (ID=43)', '2025-09-24 02:22:36.793761', 1),
(324, 'CREATE', 'Materiel', '44', 'Création du matériel B002 (ID=44)', '2025-09-24 02:23:36.580806', 1),
(325, 'CREATE', 'Materiel', '45', 'Création du matériel B003 (ID=45)', '2025-09-24 02:24:35.037478', 1),
(326, 'CREATE', 'Materiel', '46', 'Création du matériel OP001 (ID=46)', '2025-09-24 02:25:43.606438', 1),
(327, 'CREATE', 'Materiel', '47', 'Création du matériel OP002 (ID=47)', '2025-09-24 02:26:30.552533', 1),
(328, 'CREATE', 'Materiel', '48', 'Création du matériel IP001 (ID=48)', '2025-09-24 02:27:10.251983', 1),
(329, 'CREATE', 'Materiel', '49', 'Création du matériel IP002 (ID=49)', '2025-09-24 02:27:42.670906', 1),
(330, 'CREATE', 'Materiel', '50', 'Création du matériel SC001 (ID=50)', '2025-09-24 02:28:28.373310', 1),
(331, 'CREATE', 'Affectation', '16', 'Affectation ID 16 crée.', '2025-09-24 02:31:56.984435', 1),
(332, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:00.009098', 1),
(333, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:00.884960', 1),
(334, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:04.093753', 1),
(335, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:04.249691', 1),
(336, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:04.378570', 1),
(337, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:04.390958', 1),
(338, 'EXPORT', 'Affectation', '16', 'Export PDF de l’affectation ID 16.', '2025-09-24 02:32:04.539344', 1),
(339, 'CREATE', 'Affectation', '17', 'Affectation ID 17 crée.', '2025-09-24 02:32:20.708257', 1),
(340, 'CREATE', 'Affectation', '18', 'Affectation ID 18 crée.', '2025-09-24 02:32:56.379877', 1),
(341, 'CREATE', 'Affectation', '19', 'Affectation ID 19 crée.', '2025-09-24 02:33:09.777061', 1),
(342, 'DELETE', 'Affectation', '17', 'Affectation ID 17 supprimée.', '2025-09-24 02:33:30.180725', 1),
(343, 'CREATE', 'Incident', '17', 'Incident ID 17 créé pour matériel ID 48.', '2025-09-24 02:39:22.637130', 1),
(344, 'CREATE', 'Incident', '18', 'Incident ID 18 créé pour matériel ID 43.', '2025-09-24 02:40:09.915680', 1),
(345, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-09-24 02:43:59.794765', 4),
(346, 'Connexion', 'User', '4', 'Connexion réussie.', '2025-09-24 02:44:27.248098', 4),
(347, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 02:44:35.932869', 1),
(348, 'DELETE', 'Incident', '18', 'Incident ID 18 supprimé pour matériel ID 43.', '2025-09-24 02:51:36.762076', 1),
(349, 'UPDATE', 'Materiel', '43', 'Mise à jour du matériel B001 (ID=43)', '2025-09-24 02:52:06.626447', 1),
(350, 'UPDATE', 'Materiel', '48', 'Mise à jour du matériel IP001 (ID=48)', '2025-09-24 02:52:27.175063', 1),
(351, 'DELETE', 'Incident', '17', 'Incident ID 17 supprimé pour matériel ID 48.', '2025-09-24 02:59:59.117499', 1),
(352, 'CREATE', 'Incident', '19', 'Incident ID 19 créé pour matériel ID 48.', '2025-09-24 03:00:40.573606', 1),
(353, 'DELETE', 'Incident', '19', 'Incident ID 19 supprimé pour matériel ID 48.', '2025-09-24 03:01:53.901564', 1),
(354, 'CREATE', 'Incident', '20', 'Incident ID 20 créé pour matériel ID 48.', '2025-09-24 03:02:48.549754', 1),
(355, 'CREATE', 'Incident', '21', 'Incident ID 21 créé pour matériel ID 43.', '2025-09-24 03:03:17.388152', 1),
(356, 'CREATE', 'Affectation', '20', 'Affectation ID 20 crée.', '2025-09-24 03:04:23.448278', 1),
(357, 'CREATE', 'Incident', '22', 'Incident ID 22 créé pour matériel ID 46.', '2025-09-24 03:04:52.882044', 1),
(358, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 03:21:56.070878', 1),
(359, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 03:54:55.936272', 1),
(360, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 06:06:16.657383', 1),
(361, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 07:59:39.739410', 1),
(362, 'Connexion', 'User', '1', 'Connexion réussie.', '2025-09-24 11:05:11.464595', 1);

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add emplacement', 7, 'add_emplacement'),
(26, 'Can change emplacement', 7, 'change_emplacement'),
(27, 'Can delete emplacement', 7, 'delete_emplacement'),
(28, 'Can view emplacement', 7, 'view_emplacement'),
(29, 'Can add materiel', 8, 'add_materiel'),
(30, 'Can change materiel', 8, 'change_materiel'),
(31, 'Can delete materiel', 8, 'delete_materiel'),
(32, 'Can view materiel', 8, 'view_materiel'),
(33, 'Can add affectation', 9, 'add_affectation'),
(34, 'Can change affectation', 9, 'change_affectation'),
(35, 'Can delete affectation', 9, 'delete_affectation'),
(36, 'Can view affectation', 9, 'view_affectation'),
(37, 'Can add historique', 10, 'add_historique'),
(38, 'Can change historique', 10, 'change_historique'),
(39, 'Can delete historique', 10, 'delete_historique'),
(40, 'Can view historique', 10, 'view_historique'),
(41, 'Can add incident', 11, 'add_incident'),
(42, 'Can change incident', 11, 'change_incident'),
(43, 'Can delete incident', 11, 'delete_incident'),
(44, 'Can view incident', 11, 'view_incident'),
(45, 'Can add otp', 12, 'add_otp'),
(46, 'Can change otp', 12, 'change_otp'),
(47, 'Can delete otp', 12, 'delete_otp'),
(48, 'Can view otp', 12, 'view_otp'),
(49, 'Can add Journal d\'Audit', 13, 'add_auditlog'),
(50, 'Can change Journal d\'Audit', 13, 'change_auditlog'),
(51, 'Can delete Journal d\'Audit', 13, 'delete_auditlog'),
(52, 'Can view Journal d\'Audit', 13, 'view_auditlog'),
(53, 'Can add signalement', 14, 'add_signalement'),
(54, 'Can change signalement', 14, 'change_signalement'),
(55, 'Can delete signalement', 14, 'delete_signalement'),
(56, 'Can view signalement', 14, 'view_signalement');

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(6, 'users', 'user'),
(7, 'emplacements', 'emplacement'),
(8, 'materiels', 'materiel'),
(9, 'affectations', 'affectation'),
(10, 'historique', 'historique'),
(11, 'incidents', 'incident'),
(12, 'users', 'otp'),
(13, 'audit', 'auditlog'),
(14, 'signalements', 'signalement');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'emplacements', '0001_initial', '2025-07-18 07:45:45.152974'),
(2, 'contenttypes', '0001_initial', '2025-07-18 07:45:45.182912'),
(3, 'contenttypes', '0002_remove_content_type_name', '2025-07-18 07:45:45.217209'),
(4, 'auth', '0001_initial', '2025-07-18 07:45:45.316726'),
(5, 'auth', '0002_alter_permission_name_max_length', '2025-07-18 07:45:45.334299'),
(6, 'auth', '0003_alter_user_email_max_length', '2025-07-18 07:45:45.337318'),
(7, 'auth', '0004_alter_user_username_opts', '2025-07-18 07:45:45.340271'),
(8, 'auth', '0005_alter_user_last_login_null', '2025-07-18 07:45:45.343314'),
(9, 'auth', '0006_require_contenttypes_0002', '2025-07-18 07:45:45.344319'),
(10, 'auth', '0007_alter_validators_add_error_messages', '2025-07-18 07:45:45.347593'),
(11, 'auth', '0008_alter_user_username_max_length', '2025-07-18 07:45:45.351003'),
(12, 'auth', '0009_alter_user_last_name_max_length', '2025-07-18 07:45:45.363930'),
(13, 'auth', '0010_alter_group_name_max_length', '2025-07-18 07:45:45.374984'),
(14, 'auth', '0011_update_proxy_permissions', '2025-07-18 07:45:45.379997'),
(15, 'auth', '0012_alter_user_first_name_max_length', '2025-07-18 07:45:45.383739'),
(16, 'users', '0001_initial', '2025-07-18 07:45:45.532211'),
(17, 'admin', '0001_initial', '2025-07-18 07:45:45.592526'),
(18, 'admin', '0002_logentry_remove_auto_add', '2025-07-18 07:45:45.597556'),
(19, 'admin', '0003_logentry_add_action_flag_choices', '2025-07-18 07:45:45.603997'),
(20, 'materiels', '0001_initial', '2025-07-18 07:45:45.610162'),
(21, 'affectations', '0001_initial', '2025-07-18 07:45:45.701693'),
(22, 'materiels', '0002_materiel_status', '2025-07-18 07:45:45.723085'),
(23, 'materiels', '0003_materiel_im_materiels', '2025-07-18 07:45:45.736861'),
(24, 'materiels', '0004_materiel_qr_code', '2025-07-18 07:45:45.780936'),
(25, 'historique', '0001_initial', '2025-07-18 07:45:45.874612'),
(26, 'incidents', '0001_initial', '2025-07-18 07:45:45.969907'),
(27, 'incidents', '0002_alter_incident_options', '2025-07-18 07:45:45.975108'),
(28, 'incidents', '0003_incident_criticite_incident_date_resolution', '2025-07-18 07:45:46.016671'),
(29, 'materiels', '0005_materiel_score_risque_panne', '2025-07-18 07:45:46.044147'),
(30, 'materiels', '0006_materiel_composant_a_risque', '2025-07-18 07:45:46.067233'),
(31, 'materiels', '0007_materiel_date_acquisition', '2025-07-18 07:45:46.087863'),
(32, 'materiels', '0008_materiel_derniere_panne_and_more', '2025-07-18 07:45:46.135234'),
(33, 'sessions', '0001_initial', '2025-07-18 07:45:46.143819'),
(34, 'users', '0002_otp', '2025-07-30 11:00:04.048301'),
(35, 'audit', '0001_initial', '2025-07-31 06:26:13.079606'),
(36, 'signalements', '0001_initial', '2025-08-27 12:34:43.855046');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `emplacements_emplacement`
--

DROP TABLE IF EXISTS `emplacements_emplacement`;
CREATE TABLE IF NOT EXISTS `emplacements_emplacement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `direction` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `direction` (`direction`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `emplacements_emplacement`
--

INSERT INTO `emplacements_emplacement` (`id`, `direction`) VALUES
(1, 'Sp_ministre'),
(2, 'DAJ'),
(3, 'SAI'),
(4, 'DRM'),
(5, 'DLP'),
(6, 'DCC'),
(7, 'Dircab'),
(8, 'PRMP'),
(9, 'DAF'),
(10, 'DP'),
(11, 'DCP'),
(12, 'DIN'),
(13, 'DEG'),
(14, 'DTD'),
(15, 'DSI'),
(16, 'DGDN'),
(17, 'DGOVT'),
(18, 'DCAC');

-- --------------------------------------------------------

--
-- Structure de la table `historique_historique`
--

DROP TABLE IF EXISTS `historique_historique`;
CREATE TABLE IF NOT EXISTS `historique_historique` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `description` longtext,
  `date_action` datetime(6) NOT NULL,
  `affectation_id` bigint DEFAULT NULL,
  `materiel_id` bigint NOT NULL,
  `utilisateur_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `historique_historique_affectation_id_24a762d8` (`affectation_id`),
  KEY `historique_historique_materiel_id_45830360` (`materiel_id`),
  KEY `historique_historique_utilisateur_id_05459674` (`utilisateur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `incidents_incident`
--

DROP TABLE IF EXISTS `incidents_incident`;
CREATE TABLE IF NOT EXISTS `incidents_incident` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `composant_defectueux` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `resolu` tinyint(1) NOT NULL,
  `date_signalement` datetime(6) NOT NULL,
  `auteur_id` bigint NOT NULL,
  `materiel_id` bigint NOT NULL,
  `criticite` varchar(10) NOT NULL,
  `date_resolution` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incidents_incident_auteur_id_a68602d9` (`auteur_id`),
  KEY `incidents_incident_materiel_id_59be4465` (`materiel_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `incidents_incident`
--

INSERT INTO `incidents_incident` (`id`, `composant_defectueux`, `description`, `resolu`, `date_signalement`, `auteur_id`, `materiel_id`, `criticite`, `date_resolution`) VALUES
(21, 'processeur', 'Surchauffage', 0, '2025-09-24 03:03:17.377596', 1, 43, 'moyenne', NULL),
(22, 'disque_dur', 'Hors_service', 0, '2025-09-24 03:04:52.871573', 1, 46, 'elevee', NULL),
(20, 'encre', 'Encre presque terminer a 60%', 0, '2025-09-24 03:02:48.539217', 1, 48, 'faible', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `materiels_materiel`
--

DROP TABLE IF EXISTS `materiels_materiel`;
CREATE TABLE IF NOT EXISTS `materiels_materiel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `nom_ecran` varchar(100) DEFAULT NULL,
  `nom_unite_centrale` varchar(100) DEFAULT NULL,
  `nom_souris` varchar(100) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `modele_chargeur` varchar(100) DEFAULT NULL,
  `marque` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `im_materiels` varchar(20) NOT NULL,
  `qr_code` varchar(100) DEFAULT NULL,
  `score_risque_panne` double NOT NULL,
  `composant_a_risque` varchar(100) DEFAULT NULL,
  `date_acquisition` date DEFAULT NULL,
  `derniere_panne` datetime(6) DEFAULT NULL,
  `duree_moyenne_entre_pannes` double DEFAULT NULL,
  `nombre_incidents` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `im_materiels` (`im_materiels`)
) ;

--
-- Déchargement des données de la table `materiels_materiel`
--

INSERT INTO `materiels_materiel` (`id`, `type`, `created_at`, `updated_at`, `nom_ecran`, `nom_unite_centrale`, `nom_souris`, `nom`, `modele_chargeur`, `marque`, `status`, `im_materiels`, `qr_code`, `score_risque_panne`, `composant_a_risque`, `date_acquisition`, `derniere_panne`, `duree_moyenne_entre_pannes`, `nombre_incidents`) VALUES
(49, 'imprimante', '2025-09-24 02:27:42.658678', '2025-09-24 02:27:42.658678', NULL, NULL, NULL, NULL, NULL, 'Kyocera  Couleur', 'bon', 'IP002', 'qr_codes/IP002_qr_gyZxc9i.png', 0, NULL, '2025-09-23', NULL, NULL, 0),
(50, 'scanner', '2025-09-24 02:28:28.360705', '2025-09-24 02:28:28.360705', NULL, NULL, NULL, NULL, NULL, 'Canon', 'mauvais', 'SC001', 'qr_codes/SC001_qr_vSXjL2t.png', 0, NULL, '2025-09-16', NULL, NULL, 0),
(48, 'imprimante', '2025-09-24 02:27:10.239193', '2025-09-24 02:52:27.164723', NULL, NULL, NULL, NULL, NULL, 'Kyocera', 'mauvais', 'IP001', 'qr_codes/IP001_qr_J7TuUHX.png', 20, 'encre', '2025-09-19', NULL, NULL, 1),
(47, 'ordinateur_portable', '2025-09-24 02:26:30.541123', '2025-09-24 02:26:30.541123', NULL, NULL, NULL, 'Acer', 'KXB7U', NULL, 'bon', 'OP002', 'qr_codes/OP002_qr_Usy9Us5.png', 0, NULL, '2025-09-24', NULL, NULL, 0),
(46, 'ordinateur_portable', '2025-09-24 02:25:43.594380', '2025-09-24 02:25:43.594380', NULL, NULL, NULL, 'Asus', 'KYZ2BA', NULL, 'hors_service', 'OP001', 'qr_codes/OP001_qr_y1T3ROl.png', 100, 'disque_dur', '2025-09-24', NULL, NULL, 1),
(44, 'bureau', '2025-09-24 02:23:36.568396', '2025-09-24 02:23:36.568396', 'Asus', 'Asus', 'Asus', NULL, NULL, NULL, 'mauvais', 'B002', 'qr_codes/B002_qr_tcWMirv.png', 0, NULL, '2025-09-23', NULL, NULL, 0),
(45, 'bureau', '2025-09-24 02:24:35.024076', '2025-09-24 02:24:35.024076', 'Acer', 'Acer', 'Acer', NULL, NULL, NULL, 'hors_service', 'B003', 'qr_codes/B003_qr_yq92CpI.png', 0, NULL, '2025-09-01', NULL, NULL, 0),
(43, 'bureau', '2025-09-24 02:22:36.745070', '2025-09-24 02:52:06.617258', 'dell', 'dell', 'dell', NULL, NULL, NULL, 'mauvais', 'B001', 'qr_codes/B001_qr_Nb71mZd.png', 60, 'processeur', '2025-09-18', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `signalements_signalement`
--

DROP TABLE IF EXISTS `signalements_signalement`;
CREATE TABLE IF NOT EXISTS `signalements_signalement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `im_materiel` varchar(50) NOT NULL,
  `direction` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `date_signalement` datetime(6) NOT NULL,
  `vu_par_admin` tinyint(1) NOT NULL,
  `utilisateur_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `signalements_signalement_utilisateur_id_e1ed3a8b` (`utilisateur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `signalements_signalement`
--

INSERT INTO `signalements_signalement` (`id`, `im_materiel`, `direction`, `message`, `date_signalement`, `vu_par_admin`, `utilisateur_id`) VALUES
(10, 'IP001', 'DSI', 'SOLOFO Jaico de la direction DSI a signalé un problème sur le matériel IP001', '2025-09-24 02:44:08.568355', 0, 4),
(11, 'B001', 'DSI', 'SOLOFO Jaico de la direction DSI a signalé un problème sur le matériel B001', '2025-09-24 02:44:12.875595', 0, 4);

-- --------------------------------------------------------

--
-- Structure de la table `users_otp`
--

DROP TABLE IF EXISTS `users_otp`;
CREATE TABLE IF NOT EXISTS `users_otp` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_used` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_otp_user_id_cd09ace3` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users_otp`
--

INSERT INTO `users_otp` (`id`, `code`, `created_at`, `is_used`, `user_id`) VALUES
(1, '513744', '2025-07-30 11:04:12.201456', 1, 1),
(2, '611800', '2025-07-30 11:59:44.565700', 1, 3),
(3, '810143', '2025-07-30 12:12:20.363128', 1, 3),
(4, '534982', '2025-08-01 06:52:32.617109', 1, 4),
(5, '040447', '2025-08-01 06:55:07.018709', 1, 4),
(6, '541431', '2025-08-01 11:11:53.095093', 0, 1),
(7, '138373', '2025-08-01 11:13:52.610909', 1, 1),
(8, '097425', '2025-08-01 11:51:19.074348', 0, 1),
(9, '002672', '2025-08-27 06:00:34.075162', 1, 1),
(10, '461733', '2025-09-09 08:21:28.960292', 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
CREATE TABLE IF NOT EXISTS `users_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `role` varchar(11) NOT NULL,
  `im` varchar(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `direction_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `im` (`im`),
  KEY `users_user_direction_id_dab8c2aa` (`direction_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users_user`
--

INSERT INTO `users_user` (`id`, `password`, `last_login`, `is_superuser`, `email`, `nom`, `prenom`, `role`, `im`, `is_active`, `is_staff`, `direction_id`) VALUES
(1, 'pbkdf2_sha256$1000000$Gt79xxtAl2v8JqAddVc09M$eGakzZBScES13D89+YzIdl5jKVh8cUhYh/3AgykOOho=', NULL, 0, 'rajaonarivelonantenaina733@gmail.com', 'RAJAONARIVELO', 'Nantenaina', 'Admin', '123456', 1, 0, 15),
(2, 'pbkdf2_sha256$1000000$fpVpNfcPGUUyyBMEtTT2Yj$rWxLvBd/fo4CCgXluN8/6o9yaSr908LDyYyNKcKX3F4=', NULL, 0, 'gest@gmail.com', 'RANDRIAMBOLOLONA', 'Aina', 'Admin', '123457', 1, 0, 15),
(3, 'pbkdf2_sha256$1000000$V7LK7JwOx6aXevESm2qk5z$EmQ1RQbeAXQs6sWorB2/k8s30bUNgQ5VGPVUi8agFbM=', NULL, 0, 'ratovomaroagnessydonie@gmail.com', 'RAJAONA', 'Sisie', 'Admin', '123459', 1, 0, 14),
(4, 'pbkdf2_sha256$1000000$xXNpWPs428IySLp8k1syfd$lqZep0bO7lNPYtZMypcu4wMM24Om2eoRDA72lw8h3E8=', NULL, 0, 'handriolahsolofo@gmail.com', 'SOLOFO', 'Jaico', 'Utilisateur', '234567', 1, 0, 15);

-- --------------------------------------------------------

--
-- Structure de la table `users_user_groups`
--

DROP TABLE IF EXISTS `users_user_groups`;
CREATE TABLE IF NOT EXISTS `users_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_user_id_5f6f5a90` (`user_id`),
  KEY `users_user_groups_group_id_9afc8d0e` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users_user_user_permissions`
--

DROP TABLE IF EXISTS `users_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `users_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_permissions_user_id_20aca447` (`user_id`),
  KEY `users_user_user_permissions_permission_id_0b93982e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--
-- Base de données : `quiz_explorer_db`
--
CREATE DATABASE IF NOT EXISTS `quiz_explorer_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `quiz_explorer_db`;

-- --------------------------------------------------------

--
-- Structure de la table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE IF NOT EXISTS `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('dd30eee4696f');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `score` int DEFAULT NULL,
  `performance` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `name`, `score`, `performance`) VALUES
(1, 'Alice', 0, '{\"wrong\": 0, \"correct\": 0}');
--
-- Base de données : `service_etat_civil`
--
CREATE DATABASE IF NOT EXISTS `service_etat_civil` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `service_etat_civil`;

-- --------------------------------------------------------

--
-- Structure de la table `citoyens`
--

DROP TABLE IF EXISTS `citoyens`;
CREATE TABLE IF NOT EXISTS `citoyens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifiant_national` varchar(50) DEFAULT NULL,
  `identifiant_citoyen` varchar(10) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `date_de_naissance` date NOT NULL,
  `sexe` enum('Masculin','Féminin') NOT NULL,
  `cree_le` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant_citoyen` (`identifiant_citoyen`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `deces`
--

DROP TABLE IF EXISTS `deces`;
CREATE TABLE IF NOT EXISTS `deces` (
  `deces_id` int NOT NULL AUTO_INCREMENT,
  `citoyen_id` int NOT NULL,
  `date_de_deces` date NOT NULL,
  `lieu_de_deces` varchar(255) NOT NULL,
  PRIMARY KEY (`deces_id`),
  KEY `citoyen_id` (`citoyen_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `document_id` int NOT NULL AUTO_INCREMENT,
  `citoyen_id` int NOT NULL,
  `type_de_document` enum('Certificat de Naissance','Certificat de Mariage','Certificat de Décès') NOT NULL,
  `date_de_document` date NOT NULL,
  `numero_de_document` varchar(50) NOT NULL,
  `chemin_du_document` varchar(255) NOT NULL,
  PRIMARY KEY (`document_id`),
  UNIQUE KEY `numero_de_document` (`numero_de_document`),
  KEY `citoyen_id` (`citoyen_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mariages`
--

DROP TABLE IF EXISTS `mariages`;
CREATE TABLE IF NOT EXISTS `mariages` (
  `mariage_id` int NOT NULL AUTO_INCREMENT,
  `mari_id` int NOT NULL,
  `femme_id` int NOT NULL,
  `date_de_mariage` date NOT NULL,
  `lieu_de_mariage` varchar(255) NOT NULL,
  PRIMARY KEY (`mariage_id`),
  KEY `mari_id` (`mari_id`),
  KEY `femme_id` (`femme_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `naissances`
--

DROP TABLE IF EXISTS `naissances`;
CREATE TABLE IF NOT EXISTS `naissances` (
  `naissance_id` int NOT NULL AUTO_INCREMENT,
  `citoyen_id` int NOT NULL,
  `prenom_enfant` varchar(100) NOT NULL,
  `nom_famille_enfant` varchar(100) NOT NULL,
  `sexe_enfant` enum('masculin','féminin') NOT NULL,
  `date_de_naissance` date NOT NULL,
  `lieu_de_naissance` varchar(255) NOT NULL,
  `mere_id` int NOT NULL,
  `pere_id` int NOT NULL,
  PRIMARY KEY (`naissance_id`),
  KEY `citoyen_id` (`citoyen_id`),
  KEY `mere_id` (`mere_id`),
  KEY `pere_id` (`pere_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('administrateur','civil') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `status`) VALUES
(1, 'rajaonarivelonantenaina733@gmail.com', 'Nantenaina', '123456Rn', 'administrateur');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
