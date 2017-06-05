CREATE TABLE IF NOT EXISTS `blocks` (
  `id` int(11) NOT NULL,
  `identifier` varchar(63) NOT NULL,
  `name` varchar(63) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `blocks_sets` (
  `block_id` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  `set_order` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cards` (
  `identifier` varchar(63) NOT NULL,
  `set_id` int(11) NOT NULL DEFAULT '5007',
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
  `rarity_id` int(11) NOT NULL DEFAULT '7',
  `criterias1` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias2` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias3` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias4` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias5` int(11) unsigned NOT NULL DEFAULT '0',
  `criterias6` int(11) unsigned NOT NULL DEFAULT '0',
  `variable_damage1` int(11) unsigned NOT NULL DEFAULT '0',
  `variable_damage2` int(11) unsigned NOT NULL DEFAULT '0',
  `variable_damage3` int(11) NOT NULL DEFAULT '0',
  `search_retrieve1` int(11) unsigned NOT NULL DEFAULT '0',
  `search_retrieve2` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_id` int(11) NOT NULL DEFAULT '0',
  `primal_trait` int(11) DEFAULT NULL,
  `reprint_set_id` int(11) DEFAULT NULL,
  `reprint_number` smallint(6) DEFAULT NULL,
  `text_change` tinyint(1) NOT NULL DEFAULT '0',
  `full_art` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `cards_names` (
  `set_id` int(11) NOT NULL DEFAULT '5007',
  `number` smallint(6) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  `text` text NOT NULL,
  `description` varchar(63) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL,
  `identifier` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `categories_names` (
  `category_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL,
  `alpha3` varchar(3) NOT NULL,
  `name` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `criterias` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  `criterias_order` int(11) NOT NULL,
  `format_id` int(11) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `criterias_groups` (
  `id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `decks_archetypes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `decks_lists` (
  `deck_id` int(11) NOT NULL,
  `set_id` int(11) NOT NULL DEFAULT '1',
  `card_number` int(11) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  `card_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `decks_names` (
  `deck_id` int(11) NOT NULL,
  `identifier` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `decks_results` (
  `deck_id` int(11) NOT NULL,
  `archetype_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `place` smallint(6) NOT NULL,
  `player_name` varchar(127) NOT NULL,
  `country_id` int(11) NOT NULL,
  `significance` tinyint(4) NOT NULL DEFAULT '7'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL,
  `identifier` varchar(127) NOT NULL,
  `level_id` smallint(6) NOT NULL DEFAULT '7',
  `format_id` int(11) NOT NULL DEFAULT '1',
  `category_id` int(11) NOT NULL DEFAULT '1',
  `country_id` int(11) NOT NULL DEFAULT '840',
  `players` mediumint(9) NOT NULL DEFAULT '0',
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `events_categories` (
  `id` int(11) NOT NULL,
  `identifier` varchar(31) NOT NULL,
  `name` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `events_levels` (
  `id` int(11) NOT NULL,
  `identifier` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `events_names` (
  `event_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `formats` (
  `id` int(11) NOT NULL,
  `identifier` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `formats_names` (
  `format_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '3',
  `name` varchar(14) NOT NULL,
  `season` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `format_sets` (
  `format_id` int(11) NOT NULL DEFAULT '2',
  `set_id` int(11) NOT NULL,
  `number_start` smallint(6) DEFAULT NULL,
  `number_end` smallint(6) DEFAULT NULL,
  `set_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(11) NOT NULL,
  `iso639` varchar(2) NOT NULL,
  `iso3166` varchar(2) NOT NULL,
  `identifier` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `languages_names` (
  `language_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `owners` (
  `id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(31) NOT NULL,
  `format_id` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `primal_traits` (
  `id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rarity` (
  `id` int(11) NOT NULL,
  `identifier` varchar(31) NOT NULL,
  `symbol` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rarity_names` (
  `rarity_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sets` (
  `id` int(11) NOT NULL,
  `identifier` tinytext NOT NULL,
  `card_total` smallint(6) NOT NULL,
  `released` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `set_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sets_names` (
  `id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(63) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL,
  `identifier` varchar(14) NOT NULL,
  `symbol` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `types_names` (
  `type_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `variable_damage` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL,
  `variable_damage_order` int(11) NOT NULL,
  `format_id` int(11) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `variable_damage_groups` (
  `id` int(11) NOT NULL,
  `local_language_id` int(11) NOT NULL DEFAULT '2',
  `name` varchar(63) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
