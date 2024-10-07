-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 07 oct. 2024 à 00:52
-- Version du serveur : 8.2.0
-- Version de PHP : 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `your_car_your_way`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adress_adition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agence_location`
--

DROP TABLE IF EXISTS `agence_location`;
CREATE TABLE IF NOT EXISTS `agence_location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adresse_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7F1689564DE7DC5C` (`adresse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agent_service_client`
--

DROP TABLE IF EXISTS `agent_service_client`;
CREATE TABLE IF NOT EXISTS `agent_service_client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agence_id` int NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_AC8AE71BD725330D` (`agence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categorie_vehicule`
--

DROP TABLE IF EXISTS `categorie_vehicule`;
CREATE TABLE IF NOT EXISTS `categorie_vehicule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chat_conversation`
--

DROP TABLE IF EXISTS `chat_conversation`;
CREATE TABLE IF NOT EXISTS `chat_conversation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `agent_id` int NOT NULL,
  `status` enum('open','pending','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_74654F6819EB6921` (`client_id`),
  KEY `IDX_74654F683414710B` (`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE IF NOT EXISTS `chat_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `sender_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_FAB3FC169AC0396` (`conversation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adresse_id` int NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C74404554DE7DC5C` (`adresse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `disponibilite_vehicule`
--

DROP TABLE IF EXISTS `disponibilite_vehicule`;
CREATE TABLE IF NOT EXISTS `disponibilite_vehicule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehicule_id` int NOT NULL,
  `agence_future_dispo_id` int NOT NULL,
  `date_disponibilite` datetime NOT NULL,
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C1E077A94A4A3511` (`vehicule_id`),
  KEY `IDX_C1E077A9F0BDE2DD` (`agence_future_dispo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `paiement`
--

DROP TABLE IF EXISTS `paiement`;
CREATE TABLE IF NOT EXISTS `paiement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  `stripe_id` int NOT NULL,
  `amout` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B1DC7A1EB83297E7` (`reservation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `vehicule_id` int NOT NULL,
  `agence_depart_id` int NOT NULL,
  `agence_retour_id` int NOT NULL,
  `reservation_date` datetime NOT NULL,
  `start_date_location` datetime NOT NULL,
  `end_date_location` datetime NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','cancelled','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_42C8495519EB6921` (`client_id`),
  KEY `IDX_42C849554A4A3511` (`vehicule_id`),
  KEY `IDX_42C84955209D99B2` (`agence_depart_id`),
  KEY `IDX_42C84955A64964E6` (`agence_retour_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `session_visio`
--

DROP TABLE IF EXISTS `session_visio`;
CREATE TABLE IF NOT EXISTS `session_visio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `status` enum('open','pending','closed','assigned') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `agent_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1266980319EB6921` (`client_id`),
  KEY `IDX_126698033414710B` (`agent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tarif_location`
--

DROP TABLE IF EXISTS `tarif_location`;
CREATE TABLE IF NOT EXISTS `tarif_location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_day` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
CREATE TABLE IF NOT EXISTS `ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `agent_id` int NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','pending','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `creatd_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_97A0ADA319EB6921` (`client_id`),
  KEY `IDX_97A0ADA33414710B` (`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ticket_message`
--

DROP TABLE IF EXISTS `ticket_message`;
CREATE TABLE IF NOT EXISTS `ticket_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tiket_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `sender_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_BA71692D1DAA6578` (`tiket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agence_id` int NOT NULL,
  `marque` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modele` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `annee` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registration_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Available','Rented','In Maintenance') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `category_id` int NOT NULL,
  `price_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_292FFF1DD725330D` (`agence_id`),
  KEY `IDX_292FFF1D12469DE2` (`category_id`),
  KEY `IDX_292FFF1DD614C7E7` (`price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `agence_location`
--
ALTER TABLE `agence_location`
  ADD CONSTRAINT `FK_7F1689564DE7DC5C` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`id`);

--
-- Contraintes pour la table `agent_service_client`
--
ALTER TABLE `agent_service_client`
  ADD CONSTRAINT `FK_AC8AE71BD725330D` FOREIGN KEY (`agence_id`) REFERENCES `agence_location` (`id`);

--
-- Contraintes pour la table `chat_conversation`
--
ALTER TABLE `chat_conversation`
  ADD CONSTRAINT `FK_74654F6819EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_74654F683414710B` FOREIGN KEY (`agent_id`) REFERENCES `agent_service_client` (`id`);

--
-- Contraintes pour la table `chat_message`
--
ALTER TABLE `chat_message`
  ADD CONSTRAINT `FK_FAB3FC169AC0396` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversation` (`id`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `FK_C74404554DE7DC5C` FOREIGN KEY (`adresse_id`) REFERENCES `adresse` (`id`);

--
-- Contraintes pour la table `disponibilite_vehicule`
--
ALTER TABLE `disponibilite_vehicule`
  ADD CONSTRAINT `FK_C1E077A94A4A3511` FOREIGN KEY (`vehicule_id`) REFERENCES `vehicule` (`id`),
  ADD CONSTRAINT `FK_C1E077A9F0BDE2DD` FOREIGN KEY (`agence_future_dispo_id`) REFERENCES `agence_location` (`id`);

--
-- Contraintes pour la table `paiement`
--
ALTER TABLE `paiement`
  ADD CONSTRAINT `FK_B1DC7A1EB83297E7` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`);

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `FK_42C8495519EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_42C84955209D99B2` FOREIGN KEY (`agence_depart_id`) REFERENCES `agence_location` (`id`),
  ADD CONSTRAINT `FK_42C849554A4A3511` FOREIGN KEY (`vehicule_id`) REFERENCES `vehicule` (`id`),
  ADD CONSTRAINT `FK_42C84955A64964E6` FOREIGN KEY (`agence_retour_id`) REFERENCES `agence_location` (`id`);

--
-- Contraintes pour la table `session_visio`
--
ALTER TABLE `session_visio`
  ADD CONSTRAINT `FK_1266980319EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_126698033414710B` FOREIGN KEY (`agent_id`) REFERENCES `agent_service_client` (`id`);

--
-- Contraintes pour la table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `FK_97A0ADA319EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_97A0ADA33414710B` FOREIGN KEY (`agent_id`) REFERENCES `agent_service_client` (`id`);

--
-- Contraintes pour la table `ticket_message`
--
ALTER TABLE `ticket_message`
  ADD CONSTRAINT `FK_BA71692D1DAA6578` FOREIGN KEY (`tiket_id`) REFERENCES `ticket` (`id`);

--
-- Contraintes pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD CONSTRAINT `FK_292FFF1D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `categorie_vehicule` (`id`),
  ADD CONSTRAINT `FK_292FFF1DD614C7E7` FOREIGN KEY (`price_id`) REFERENCES `tarif_location` (`id`),
  ADD CONSTRAINT `FK_292FFF1DD725330D` FOREIGN KEY (`agence_id`) REFERENCES `agence_location` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
