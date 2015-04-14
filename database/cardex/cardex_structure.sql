-- Généré le :  Mar 14 Avril 2015 à 14:38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `cardex`
--

-- --------------------------------------------------------

--
-- Structure de la table `cards`
--

CREATE TABLE IF NOT EXISTS `cards` (
  `identifier` varchar(63) NOT NULL,
  `set_id` int(11) NOT NULL DEFAULT '64',
  `number` smallint(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  `hit_points` int(11) DEFAULT NULL,
  `type1_id` int(11) DEFAULT NULL,
  `type2_id` int(11) DEFAULT NULL,
  `attacks` tinytext,
  `weakness1_id` int(11) DEFAULT NULL,
  `weakness1_amount` varchar(6) NOT NULL,
  `weakness2_id` int(11) DEFAULT NULL,
  `weakness2_amount` varchar(6) NOT NULL,
  `resistance1_id` int(11) DEFAULT NULL,
  `resistance1_amount` varchar(6) NOT NULL,
  `resistance2_id` int(11) DEFAULT NULL,
  `resistance2_amount` varchar(6) NOT NULL,
  `retreat_cost` int(11) DEFAULT NULL,
  `rarity_id` int(11) NOT NULL,
  `criterias1` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias2` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias3` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias4` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias5` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias6` int(11) unsigned NOT NULL DEFAULT '0',
  `variable_damage1` int(11) unsigned NOT NULL DEFAULT '0',
  `variable_damage2` int(11) unsigned NOT NULL DEFAULT '0',
  `search_retrieve1` int(11) unsigned NOT NULL DEFAULT '0',
  `search_retrieve2` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_id` int(11) NOT NULL DEFAULT '0',
  `primal_trait` int(11) DEFAULT NULL,
  PRIMARY KEY (`set_id`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cards_names`
--

CREATE TABLE IF NOT EXISTS `cards_names` (
  `set_id` int(11) NOT NULL DEFAULT '64',
  `number` smallint(6) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`set_id`,`number`,`local_language_id`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `text` (`text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `categories_names`
--

CREATE TABLE IF NOT EXISTS `categories_names` (
  `category_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`category_id`,`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL,
  `alpha3` varchar(3) NOT NULL,
  `name` varchar(127) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `criterias`
--

CREATE TABLE IF NOT EXISTS `criterias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  `criterias_order` int(11) NOT NULL,
  `format_id` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `criterias_groups`
--

CREATE TABLE IF NOT EXISTS `criterias_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  PRIMARY KEY (`id`,`local_language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `decks_archetypes`
--

CREATE TABLE IF NOT EXISTS `decks_archetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `decks_lists`
--

CREATE TABLE IF NOT EXISTS `decks_lists` (
  `deck_id` int(11) NOT NULL,
  `set_id` int(11) NOT NULL DEFAULT '1',
  `card_number` int(11) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  `card_order` int(11) NOT NULL,
  PRIMARY KEY (`deck_id`,`card_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `decks_names`
--

CREATE TABLE IF NOT EXISTS `decks_names` (
  `deck_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`deck_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `decks_results`
--

CREATE TABLE IF NOT EXISTS `decks_results` (
  `deck_id` int(11) NOT NULL AUTO_INCREMENT,
  `archetype_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `place` smallint(6) NOT NULL,
  `player_name` varchar(127) NOT NULL,
  `country_id` int(11) NOT NULL,
  `significance` tinyint(4) NOT NULL DEFAULT '7',
  PRIMARY KEY (`deck_id`),
  KEY `archetype_id` (`archetype_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(127) NOT NULL,
  `level_id` smallint(6) NOT NULL DEFAULT '7',
  `format_id` int(11) NOT NULL DEFAULT '1',
  `category_id` int(11) NOT NULL DEFAULT '1',
  `country_id` int(11) NOT NULL DEFAULT '840',
  `players` mediumint(9) NOT NULL DEFAULT '0',
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `events_categories`
--

CREATE TABLE IF NOT EXISTS `events_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(31) NOT NULL,
  `name` varchar(127) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `events_levels`
--

CREATE TABLE IF NOT EXISTS `events_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `events_names`
--

CREATE TABLE IF NOT EXISTS `events_names` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `formats`
--

CREATE TABLE IF NOT EXISTS `formats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `formats_names`
--

CREATE TABLE IF NOT EXISTS `formats_names` (
  `format_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '3',
  `name` varchar(14) NOT NULL,
  `season` varchar(9) NOT NULL,
  PRIMARY KEY (`format_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `format_sets`
--

CREATE TABLE IF NOT EXISTS `format_sets` (
  `format_id` int(11) NOT NULL DEFAULT '2',
  `set_id` int(11) NOT NULL,
  `number_start` smallint(6) DEFAULT NULL,
  `number_end` smallint(6) DEFAULT NULL,
  `set_order` int(11) NOT NULL,
  PRIMARY KEY (`format_id`,`set_id`),
  KEY `set_id` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(11) NOT NULL,
  `iso639` varchar(2) NOT NULL,
  `iso3166` varchar(2) NOT NULL,
  `identifier` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `languages_names`
--

CREATE TABLE IF NOT EXISTS `languages_names` (
  `language_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`language_id`,`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `owners`
--

CREATE TABLE IF NOT EXISTS `owners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(31) NOT NULL,
  `format_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `primal_traits`
--

CREATE TABLE IF NOT EXISTS `primal_traits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(127) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rarity`
--

CREATE TABLE IF NOT EXISTS `rarity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(31) NOT NULL,
  `symbol` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rarity_names`
--

CREATE TABLE IF NOT EXISTS `rarity_names` (
  `rarity_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`rarity_id`,`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `sets`
--

CREATE TABLE IF NOT EXISTS `sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` tinytext NOT NULL,
  `card_total` smallint(6) NOT NULL,
  `released` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `set_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `set_order` (`set_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `sets_names`
--

CREATE TABLE IF NOT EXISTS `sets_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY (`id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(14) NOT NULL,
  `symbol` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types_names`
--

CREATE TABLE IF NOT EXISTS `types_names` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY (`type_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `variable_damage`
--

CREATE TABLE IF NOT EXISTS `variable_damage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  `variable_damage_order` int(11) NOT NULL,
  `format_id` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `variable_damage_groups`
--

CREATE TABLE IF NOT EXISTS `variable_damage_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  PRIMARY KEY (`id`,`local_language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
