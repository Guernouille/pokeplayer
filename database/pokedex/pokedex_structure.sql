-- Généré le :  Mar 14 Avril 2015 à 14:42

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `pokedex`
--

-- --------------------------------------------------------

--
-- Structure de la table `abilities`
--

CREATE TABLE IF NOT EXISTS `abilities` (
  `id` int(11) NOT NULL,
  `identifier` varchar(24) NOT NULL,
  `generation_id` int(11) NOT NULL DEFAULT '6',
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `abilities_names`
--

CREATE TABLE IF NOT EXISTS `abilities_names` (
  `ability_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(24) NOT NULL,
  PRIMARY KEY (`ability_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `abilities_texts`
--

CREATE TABLE IF NOT EXISTS `abilities_texts` (
  `ability_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `long_effect` varchar(5120) DEFAULT NULL,
  `short_effect` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`ability_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `colors`
--

CREATE TABLE IF NOT EXISTS `colors` (
  `id` int(11) NOT NULL,
  `identifier` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `colors_names`
--

CREATE TABLE IF NOT EXISTS `colors_names` (
  `color_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(6) NOT NULL,
  PRIMARY KEY (`color_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `effects`
--

CREATE TABLE IF NOT EXISTS `effects` (
  `id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `effects_151`
--

CREATE TABLE IF NOT EXISTS `effects_151` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `description_us` text NOT NULL,
  `description_fr` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `effects_texts`
--

CREATE TABLE IF NOT EXISTS `effects_texts` (
  `effect_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `short_effect` varchar(256) DEFAULT NULL,
  `long_effect` varchar(5120) DEFAULT NULL,
  PRIMARY KEY (`effect_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `egg_groups`
--

CREATE TABLE IF NOT EXISTS `egg_groups` (
  `id` int(11) NOT NULL,
  `identifier` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `egg_groups_names`
--

CREATE TABLE IF NOT EXISTS `egg_groups_names` (
  `egg_group_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`egg_group_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `generations`
--

CREATE TABLE IF NOT EXISTS `generations` (
  `id` int(11) NOT NULL,
  `complete_pokedex` int(11) NOT NULL,
  `identifier` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `generations_names`
--

CREATE TABLE IF NOT EXISTS `generations_names` (
  `generation_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`generation_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
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
  PRIMARY KEY (`language_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `metagames`
--

CREATE TABLE IF NOT EXISTS `metagames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `generation_id` int(11) NOT NULL,
  `identifier` varchar(15) NOT NULL,
  `metagame_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_151`
--

CREATE TABLE IF NOT EXISTS `moves_151` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(24) NOT NULL,
  `type_id` int(11) NOT NULL DEFAULT '0',
  `power` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pp` tinyint(3) unsigned NOT NULL,
  `accuracy` tinyint(3) unsigned DEFAULT NULL,
  `priority` tinyint(4) NOT NULL DEFAULT '0',
  `effect_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `effect_id` (`effect_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_251`
--

CREATE TABLE IF NOT EXISTS `moves_251` (
  `id` int(11) NOT NULL,
  `identifier` varchar(24) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `power` smallint(6) NOT NULL,
  `pp` smallint(6) DEFAULT NULL,
  `accuracy` smallint(6) DEFAULT NULL,
  `priority` smallint(6) NOT NULL,
  `target_id` int(11) NOT NULL,
  `damage_class_id` int(11) NOT NULL,
  `effect_id` int(11) NOT NULL,
  `effect_chance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `type_id` (`type_id`),
  KEY `target_id` (`target_id`),
  KEY `damage_class_id` (`damage_class_id`),
  KEY `effect_id` (`effect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_386`
--

CREATE TABLE IF NOT EXISTS `moves_386` (
  `id` int(11) NOT NULL,
  `identifier` varchar(24) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `power` smallint(6) NOT NULL,
  `pp` smallint(6) DEFAULT NULL,
  `accuracy` smallint(6) DEFAULT NULL,
  `priority` smallint(6) NOT NULL,
  `target_id` int(11) NOT NULL,
  `damage_class_id` int(11) NOT NULL,
  `effect_id` int(11) NOT NULL,
  `effect_chance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `type_id` (`type_id`),
  KEY `target_id` (`target_id`),
  KEY `damage_class_id` (`damage_class_id`),
  KEY `effect_id` (`effect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_493`
--

CREATE TABLE IF NOT EXISTS `moves_493` (
  `id` int(11) NOT NULL,
  `identifier` varchar(24) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `power` smallint(6) NOT NULL,
  `pp` smallint(6) DEFAULT NULL,
  `accuracy` smallint(6) DEFAULT NULL,
  `priority` smallint(6) NOT NULL,
  `target_id` int(11) NOT NULL,
  `damage_class_id` int(11) NOT NULL,
  `effect_id` int(11) NOT NULL,
  `effect_chance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `type_id` (`type_id`),
  KEY `target_id` (`target_id`),
  KEY `damage_class_id` (`damage_class_id`),
  KEY `effect_id` (`effect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_649`
--

CREATE TABLE IF NOT EXISTS `moves_649` (
  `id` int(11) NOT NULL,
  `identifier` varchar(24) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `power` smallint(6) NOT NULL,
  `pp` smallint(6) DEFAULT NULL,
  `accuracy` smallint(6) DEFAULT NULL,
  `priority` smallint(6) NOT NULL,
  `target_id` int(11) NOT NULL,
  `damage_class_id` int(11) NOT NULL,
  `effect_id` int(11) NOT NULL,
  `effect_chance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `type_id` (`type_id`),
  KEY `target_id` (`target_id`),
  KEY `damage_class_id` (`damage_class_id`),
  KEY `effect_id` (`effect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_721`
--

CREATE TABLE IF NOT EXISTS `moves_721` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(24) NOT NULL,
  `generation_id` int(11) NOT NULL DEFAULT '6',
  `type_id` int(11) NOT NULL,
  `power` smallint(6) NOT NULL,
  `pp` smallint(6) DEFAULT NULL,
  `accuracy` smallint(6) DEFAULT NULL,
  `priority` smallint(6) NOT NULL DEFAULT '0',
  `target_id` int(11) NOT NULL DEFAULT '10',
  `damage_class_id` int(11) NOT NULL,
  `effect_id` int(11) NOT NULL DEFAULT '1',
  `effect_chance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `type_id` (`type_id`),
  KEY `target_id` (`target_id`),
  KEY `damage_class_id` (`damage_class_id`),
  KEY `effect_id` (`effect_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_names`
--

CREATE TABLE IF NOT EXISTS `moves_names` (
  `move_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(24) NOT NULL,
  PRIMARY KEY (`move_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `moves_strategy`
--

CREATE TABLE IF NOT EXISTS `moves_strategy` (
  `move_id` int(11) NOT NULL,
  `generation_id` int(11) NOT NULL DEFAULT '2',
  `strategy_text` text NOT NULL,
  `other_options` text NOT NULL,
  `strategic_value` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`move_id`,`generation_id`),
  KEY `generation_id` (`generation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `move_damage_classes`
--

CREATE TABLE IF NOT EXISTS `move_damage_classes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `natures`
--

CREATE TABLE IF NOT EXISTS `natures` (
  `id` int(11) NOT NULL,
  `identifier` varchar(8) NOT NULL,
  `decreased_stat_id` int(11) NOT NULL,
  `increased_stat_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `natures_names`
--

CREATE TABLE IF NOT EXISTS `natures_names` (
  `nature_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(8) NOT NULL,
  PRIMARY KEY (`nature_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon`
--

CREATE TABLE IF NOT EXISTS `pokemon` (
  `id` int(11) NOT NULL,
  `species_id` int(11) DEFAULT NULL,
  `height` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `base_experience` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `species_id` (`species_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_abilities`
--

CREATE TABLE IF NOT EXISTS `pokemon_abilities` (
  `pokemon_id` int(11) NOT NULL,
  `ability_id` int(11) NOT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`pokemon_id`,`slot`),
  KEY `ability_id` (`ability_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_egg_groups`
--

CREATE TABLE IF NOT EXISTS `pokemon_egg_groups` (
  `species_id` int(11) NOT NULL,
  `egg_group_id` int(11) NOT NULL,
  PRIMARY KEY (`species_id`,`egg_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_moves`
--

CREATE TABLE IF NOT EXISTS `pokemon_moves` (
  `pokemon_id` int(11) NOT NULL DEFAULT '1',
  `version_group_id` int(11) NOT NULL DEFAULT '4',
  `move_id` int(11) NOT NULL,
  `pokemon_move_method_id` int(11) NOT NULL DEFAULT '9',
  `level` int(11) NOT NULL DEFAULT '0',
  `has_strategic_value` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`pokemon_id`,`version_group_id`,`move_id`,`pokemon_move_method_id`,`level`),
  KEY `pokemon_move_method_id` (`pokemon_move_method_id`),
  KEY `version_group_id` (`version_group_id`),
  KEY `pokemon_moves_ibfk_2` (`move_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_movesets`
--

CREATE TABLE IF NOT EXISTS `pokemon_movesets` (
  `pokemon_id` int(11) NOT NULL,
  `metagame_id` int(11) NOT NULL DEFAULT '5',
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `order` int(11) NOT NULL DEFAULT '0',
  `moveset_name` varchar(62) NOT NULL,
  `move1` int(11) NOT NULL,
  `move2` int(11) DEFAULT NULL,
  `move3` int(11) DEFAULT NULL,
  `move4` int(11) DEFAULT NULL,
  `move2_alt` int(11) DEFAULT NULL,
  `move3_alt` int(11) DEFAULT NULL,
  `move3_alt2` int(11) DEFAULT NULL,
  `move4_alt` int(11) DEFAULT NULL,
  `move4_alt2` int(11) DEFAULT NULL,
  `strategy_text` text NOT NULL,
  PRIMARY KEY (`pokemon_id`,`metagame_id`,`local_language_id`,`order`),
  KEY `move1` (`move1`),
  KEY `move2` (`move2`),
  KEY `move3` (`move3`),
  KEY `move4` (`move4`),
  KEY `move2_alt` (`move2_alt`),
  KEY `move3_alt` (`move3_alt`),
  KEY `move4_alt` (`move4_alt`),
  KEY `move4_alt2` (`move4_alt2`),
  KEY `metagame_id` (`metagame_id`),
  KEY `local_language_id` (`local_language_id`),
  KEY `move3_alt2` (`move3_alt2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_movesets_alt_choices`
--

CREATE TABLE IF NOT EXISTS `pokemon_movesets_alt_choices` (
  `pokemon_id` int(11) NOT NULL,
  `metagame_id` int(11) NOT NULL,
  `move_id` int(11) NOT NULL,
  `strategy_text` text NOT NULL,
  PRIMARY KEY (`pokemon_id`,`metagame_id`,`move_id`),
  KEY `metagame_id` (`metagame_id`),
  KEY `move_id` (`move_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_moves_methods`
--

CREATE TABLE IF NOT EXISTS `pokemon_moves_methods` (
  `id` int(11) NOT NULL,
  `identifier` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_names`
--

CREATE TABLE IF NOT EXISTS `pokemon_names` (
  `pokemon_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(20) DEFAULT NULL,
  `genus` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`pokemon_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_ratings`
--

CREATE TABLE IF NOT EXISTS `pokemon_ratings` (
  `pokemon_id` int(11) NOT NULL,
  `metagame_id` int(11) NOT NULL DEFAULT '19',
  `rating_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pokemon_id`,`metagame_id`),
  KEY `metagame_id` (`metagame_id`),
  KEY `tier_id` (`rating_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_species`
--

CREATE TABLE IF NOT EXISTS `pokemon_species` (
  `id` int(11) NOT NULL,
  `identifier` varchar(20) NOT NULL,
  `generation_id` int(11) DEFAULT '6',
  `evolves_from_species_id` int(11) DEFAULT NULL,
  `evolution_chain_id` int(11) DEFAULT NULL,
  `color_id` int(11) NOT NULL,
  `shape_id` int(11) NOT NULL DEFAULT '0',
  `habitat_id` int(11) DEFAULT NULL,
  `gender_rate` int(11) NOT NULL DEFAULT '0',
  `capture_rate` int(11) NOT NULL DEFAULT '255',
  `base_happiness` int(11) NOT NULL DEFAULT '70',
  `is_baby` tinyint(1) NOT NULL DEFAULT '0',
  `hatch_counter` int(11) NOT NULL DEFAULT '20',
  `has_gender_differences` tinyint(1) NOT NULL DEFAULT '0',
  `growth_rate_id` int(11) NOT NULL DEFAULT '4',
  `forms_switchable` tinyint(1) NOT NULL DEFAULT '0',
  `mega_evolution` tinyint(1) NOT NULL DEFAULT '0',
  `order` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `evolves_from_species_id` (`evolves_from_species_id`),
  KEY `color_id` (`color_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_stats`
--

CREATE TABLE IF NOT EXISTS `pokemon_stats` (
  `pokemon_id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `base_stat` int(11) NOT NULL,
  `effort` int(11) NOT NULL,
  PRIMARY KEY (`pokemon_id`,`stat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_stats_gsbw`
--

CREATE TABLE IF NOT EXISTS `pokemon_stats_gsbw` (
  `pokemon_id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `base_stat` int(11) NOT NULL,
  `effort` int(11) NOT NULL,
  PRIMARY KEY (`pokemon_id`,`stat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_stats_rby`
--

CREATE TABLE IF NOT EXISTS `pokemon_stats_rby` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `BS_HP` tinyint(3) unsigned NOT NULL,
  `BS_ATK` tinyint(3) unsigned NOT NULL,
  `BS_DEF` tinyint(3) unsigned NOT NULL,
  `BS_SPECIAL` tinyint(3) unsigned NOT NULL,
  `BS_SPEED` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_tiers`
--

CREATE TABLE IF NOT EXISTS `pokemon_tiers` (
  `pokemon_id` int(11) NOT NULL,
  `metagame_id` int(11) NOT NULL,
  `generation_id` int(11) NOT NULL,
  PRIMARY KEY (`pokemon_id`,`metagame_id`,`generation_id`),
  KEY `metagame_id` (`metagame_id`),
  KEY `generation_id` (`generation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_types`
--

CREATE TABLE IF NOT EXISTS `pokemon_types` (
  `pokemon_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL DEFAULT '18',
  `slot` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`pokemon_id`,`slot`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ratings`
--

CREATE TABLE IF NOT EXISTS `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `stats`
--

CREATE TABLE IF NOT EXISTS `stats` (
  `id` int(11) NOT NULL,
  `damage_class_id` int(11) DEFAULT NULL,
  `identifier` varchar(16) NOT NULL,
  `is_battle_only` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `stat_names`
--

CREATE TABLE IF NOT EXISTS `stat_names` (
  `stat_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`stat_id`,`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `tmhm`
--

CREATE TABLE IF NOT EXISTS `tmhm` (
  `machine_number` int(11) NOT NULL,
  `version_group_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `move_id` int(11) NOT NULL,
  PRIMARY KEY (`machine_number`,`version_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL,
  `identifier` varchar(12) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `damage_class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types_efficacy_151`
--

CREATE TABLE IF NOT EXISTS `types_efficacy_151` (
  `damage_type_id` int(11) NOT NULL,
  `target_type_id` int(11) NOT NULL,
  `damage_factor` int(11) NOT NULL,
  PRIMARY KEY (`damage_type_id`,`target_type_id`),
  KEY `target_type_id` (`target_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types_efficacy_649`
--

CREATE TABLE IF NOT EXISTS `types_efficacy_649` (
  `damage_type_id` int(11) NOT NULL,
  `target_type_id` int(11) NOT NULL,
  `damage_factor` int(11) NOT NULL,
  PRIMARY KEY (`damage_type_id`,`target_type_id`),
  KEY `target_type_id` (`target_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types_efficacy_721`
--

CREATE TABLE IF NOT EXISTS `types_efficacy_721` (
  `damage_type_id` int(11) NOT NULL,
  `target_type_id` int(11) NOT NULL,
  `damage_factor` int(11) NOT NULL,
  PRIMARY KEY (`damage_type_id`,`target_type_id`),
  KEY `target_type_id` (`target_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `types_names`
--

CREATE TABLE IF NOT EXISTS `types_names` (
  `type_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(12) NOT NULL,
  PRIMARY KEY (`type_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `versions`
--

CREATE TABLE IF NOT EXISTS `versions` (
  `id` int(11) NOT NULL,
  `versions_group_id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `version_group_id` (`versions_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `versions_groups`
--

CREATE TABLE IF NOT EXISTS `versions_groups` (
  `id` int(11) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `identifier` varchar(14) NOT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generation_id` (`generation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `versions_groups_pokemon_moves_methods`
--

CREATE TABLE IF NOT EXISTS `versions_groups_pokemon_moves_methods` (
  `versions_group_id` int(11) NOT NULL,
  `pokemon_moves_method_id` int(11) NOT NULL,
  PRIMARY KEY (`versions_group_id`,`pokemon_moves_method_id`),
  KEY `pokemon_moves_method_id` (`pokemon_moves_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `versions_names`
--

CREATE TABLE IF NOT EXISTS `versions_names` (
  `version_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`version_id`,`local_language_id`),
  KEY `local_language_id` (`local_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
