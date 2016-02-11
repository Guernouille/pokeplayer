<?php
/* SEARCH ENGINE */
function cardex_search_engine($search_name, $search_text, $set_list, $rarity_list, $category_list, $type_list, $hp_min, $hp_max, $weakness, $resistance, $is_it_weak, $is_it_resist, $retreat_min, $retreat_max, $owner_id, $criteria_mode, $criteria1, $criteria2, $criteria3, $criteria4, $criteria5, $criteria6, $variable_damage1, $variable_damage2, $variable_damage3, $damage_compare, $damage_done, $energy_compare, $energy_required, $energy_required_type, $colorless_energy_required, $energy_required_extra, $primal_trait, $search_retrieve1, $search_retrieve2, $format, $order_by=NULL, $language=DEFAULT_LANGUAGE)
{
	$card_list = array();
	$order_by = htmlentities($order_by);
	$search_name = strtolower($search_name);
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT *";
	if(strlen($search_name) > 3 || $search_name === "az" || $search_name === "n") $pre_requete .= ", MATCH (t_cards_names.name) AGAINST (:search_name) AS name_relevance";
	$pre_requete .= " FROM ".SQL_TABLE_PREFIX."cards".SQL_TABLE_SUFFIX." AS t_cards, ".SQL_TABLE_PREFIX."cards_names".SQL_TABLE_SUFFIX." AS t_cards_names
					WHERE t_cards_names.local_language_id = :language
					AND t_cards.set_id = t_cards_names.set_id
					AND t_cards.number = t_cards_names.number";
	// Criteria, Variable Damage, Search / Retrieval
	if($criteria_mode=='not'){
		if(is_numeric($criteria1) && $criteria1!=0) $pre_requete .= " AND (t_cards.criterias1 | :criteria1_not) = :criteria1_not";
		if(is_numeric($criteria2) && $criteria2!=0) $pre_requete .= " AND (t_cards.criterias2 | :criteria2_not) = :criteria2_not";
		if(is_numeric($criteria3) && $criteria3!=0) $pre_requete .= " AND (t_cards.criterias3 | :criteria3_not) = :criteria3_not";
		if(is_numeric($criteria4) && $criteria4!=0) $pre_requete .= " AND (t_cards.criterias4 | :criteria4_not) = :criteria4_not";
		if(is_numeric($criteria5) && $criteria5!=0) $pre_requete .= " AND (t_cards.criterias5 | :criteria5_not) = :criteria5_not";
		if(is_numeric($criteria6) && $criteria6!=0) $pre_requete .= " AND (t_cards.criterias6 | :criteria6_not) = :criteria6_not";
	}
	elseif($criteria_mode=='or'){
		if(is_numeric($criteria1) && $criteria1!=0) $pre_requete .= " AND (t_cards.criterias1 | :criteria1_not) > :criteria1_not";
		if(is_numeric($criteria2) && $criteria2!=0) $pre_requete .= " AND (t_cards.criterias2 | :criteria2_not) > :criteria2_not";
		if(is_numeric($criteria3) && $criteria3!=0) $pre_requete .= " AND (t_cards.criterias3 | :criteria3_not) > :criteria3_not";
		if(is_numeric($criteria4) && $criteria4!=0) $pre_requete .= " AND (t_cards.criterias4 | :criteria4_not) > :criteria4_not";
		if(is_numeric($criteria5) && $criteria5!=0) $pre_requete .= " AND (t_cards.criterias5 | :criteria5_not) > :criteria5_not";
		if(is_numeric($criteria6) && $criteria6!=0) $pre_requete .= " AND (t_cards.criterias6 | :criteria6_not) > :criteria6_not";
	}
	else{
		if(is_numeric($criteria1) && $criteria1!=0) $pre_requete .= " AND (t_cards.criterias1 & :criteria1) = :criteria1";
		if(is_numeric($criteria2) && $criteria2!=0) $pre_requete .= " AND (t_cards.criterias2 & :criteria2) = :criteria2";
		if(is_numeric($criteria3) && $criteria3!=0) $pre_requete .= " AND (t_cards.criterias3 & :criteria3) = :criteria3";
		if(is_numeric($criteria4) && $criteria4!=0) $pre_requete .= " AND (t_cards.criterias4 & :criteria4) = :criteria4";
		if(is_numeric($criteria5) && $criteria5!=0) $pre_requete .= " AND (t_cards.criterias5 & :criteria5) = :criteria5";
		if(is_numeric($criteria6) && $criteria6!=0) $pre_requete .= " AND (t_cards.criterias6 & :criteria6) = :criteria6";
	}
	if(is_numeric($variable_damage1) && $variable_damage1!=0) $pre_requete .= " AND (t_cards.variable_damage1 & :variable_damage1) = :variable_damage1";
	if(is_numeric($variable_damage2) && $variable_damage2!=0) $pre_requete .= " AND (t_cards.variable_damage2 & :variable_damage2) = :variable_damage2";
	if(is_numeric($variable_damage3) && $variable_damage3!=0) $pre_requete .= " AND (t_cards.variable_damage3 & :variable_damage3) = :variable_damage3";
	if(is_numeric($search_retrieve1) && $search_retrieve1!=0) $pre_requete .= " AND (t_cards.search_retrieve1 & :search_retrieve1) = :search_retrieve1";
	if(is_numeric($search_retrieve2) && $search_retrieve2!=0) $pre_requete .= " AND (t_cards.search_retrieve2 & :search_retrieve2) = :search_retrieve2";
	// Name & Text
	if($search_name!=NULL){
		if(strlen($search_name)>1 && $search_name!="az") $pre_requete .= " AND ((MATCH (t_cards_names.name) AGAINST (:search_name)) OR (t_cards_names.name LIKE :search_name_like))";
		else $pre_requete .= " AND (t_cards_names.name LIKE :search_name)";
	}
	if($search_text!=NULL) $pre_requete .= " AND (t_cards_names.text LIKE :search_text)";
	// Types
	if(!empty($type_list)) {
		$pre_requete .= " AND (t_cards.type1_id IN (";
		foreach($type_list as $type_id)
			$pre_requete .= $type_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	if(!empty($type_list)) {
		$pre_requete .= " OR t_cards.type2_id IN (";
		foreach($type_list as $type_id)
			$pre_requete .= $type_id.",";
		$pre_requete = preg_replace('#(,{1})$#', '))', $pre_requete);
	}
	// Sets
	if(!empty($set_list)){
		$pre_requete .= " AND t_cards.set_id IN (";
		foreach($set_list as $set_id)
			$pre_requete .= $set_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	// Rarity
	if(!empty($rarity_list)){
		$pre_requete .= " AND t_cards.rarity_id IN (";
		foreach($rarity_list as $rarity_id)
			$pre_requete .= $rarity_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	// Category
	if(!empty($category_list)){
		$pre_requete .= " AND t_cards.category_id IN (";
		foreach($category_list as $category_id)
			$pre_requete .= $category_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	// HP
	if(is_numeric($hp_min) && is_numeric($hp_max)){
		if($hp_min>0 && $hp_min<=1000) $pre_requete .= " AND t_cards.hit_points BETWEEN :hp_min AND :hp_max";
		elseif($hp_max>=0 && $hp_max<1000) $pre_requete .= " AND (t_cards.hit_points IS NULL OR (t_cards.hit_points BETWEEN :hp_min AND :hp_max))";
	}
	// Weakness & Resistance no_resist_to
	if(is_numeric($weakness) && $weakness!=NULL){
		if($is_it_weak=='not_weak_to') $pre_requete .= " AND (t_cards.weakness1_id != :weakness AND (t_cards.weakness2_id != :weakness OR t_cards.weakness2_id IS NULL))";
		else $pre_requete .= " AND (t_cards.weakness1_id = :weakness OR t_cards.weakness2_id = :weakness)";
	}
	if(is_numeric($resistance) && $resistance!=NULL){
		if($is_it_resist=='no_resist_to') $pre_requete .= " AND (t_cards.resistance1_id != :resistance AND (t_cards.resistance2_id != :resistance OR t_cards.resistance2_id IS NULL))";
		else $pre_requete .= " AND (t_cards.resistance1_id = :resistance OR t_cards.resistance2_id = :resistance)";
	}
	if(is_numeric($resistance) && $resistance!=NULL) $pre_requete .= " AND (t_cards.resistance1_id = :resistance OR t_cards.resistance2_id = :resistance)";
	// Retreat Cost
	if(is_numeric($retreat_min) && is_numeric($retreat_max)) $pre_requete .= " AND t_cards.retreat_cost BETWEEN :retreat_min AND :retreat_max";
	// Owner
	if(is_numeric($owner_id) && $owner_id>0) $pre_requete .= " AND t_cards.owner_id = :owner_id";
	// Primal Trait
	if(is_numeric($primal_trait) && $primal_trait>0) $pre_requete .= " AND t_cards.primal_trait = :primal_trait";
	/************************************
	*	Regex Dégâts et Énergies POSIX	*
	************************************/
	$pattern_damage='';
	$pattern_energy='';

	/* Damage */
	if(is_numeric($damage_done) && $damage_done>=0 && $damage_done<9000 && $damage_compare!=NULL){
		$damage_thousand = floor($damage_done/1000);
		$damage_hundred = floor($damage_done/100)%10;
		$damage_decade = floor($damage_done/10)%10;
		$pattern_damage='(';
		// Supérieur ou égal
		if($damage_compare=="more_than") {
			if($damage_done>0){
				if($damage_decade<9) $pattern_damage.=''.$damage_thousand.$damage_hundred.'['.$damage_decade.'-9]';
				else $pattern_damage.=$damage_thousand.$damage_hundred.'9';
				if($damage_hundred<9){
					if($damage_hundred<8) $pattern_damage.='|'.$damage_thousand.'['.($damage_hundred+1).'-9][0-9]';
					else $pattern_damage.='|'.$damage_thousand.'9[0-9]';
				}
				if($damage_thousand<9){
					if($damage_thousand<8) $pattern_damage.='|['.($damage_thousand+1).'-9][0-9][0-9]';
					else $pattern_damage.='|9[0-9][0-9]';
				}
			}
			else $pattern_damage.='[0-9]{3}';
		}
		// Inférieur ou égal
		elseif($damage_compare=="less_than"){
			if($damage_decade>0) $pattern_damage.=''.$damage_thousand.$damage_hundred.'[0-'.$damage_decade.']';
			else $pattern_damage.=$damage_thousand.$damage_hundred.'0';
			if($damage_hundred>0){
				if($damage_hundred>1) $pattern_damage.='|'.$damage_thousand.'[0-'.($damage_hundred-1).'][0-9]';
				else $pattern_damage.='|'.$damage_thousand.'0[0-9]';
			}
			if($damage_thousand>0){
				if($damage_thousand>1) $pattern_damage.='|[0-'.($damage_thousand-1).'][0-9][0-9]';
				else $pattern_damage.='|0[0-9][0-9]';
			}
		}
		// Égal
		else{
			$pattern_damage.=$damage_thousand.$damage_hundred.$damage_decade;
		}
		$pattern_damage.=')';
	}

	/* Energies */
	if(is_numeric($energy_required) && $energy_required>=0 && $energy_required<=9 && $energy_compare!=NULL){
		if($colorless_energy_required>0) $minimum_colorless_search = 'c{'.$colorless_energy_required.'}';
		else $minimum_colorless_search = '';
		if($colorless_energy_required>$energy_required) $colorless_energy_required = $energy_required;
		$colored_search = '';
				
		// Supérieur ou égal
		if($energy_compare=="more_than"){
			if($energy_required_type!=NULL && strlen($energy_required_type)==1){
				$colored_energy_required=$energy_required-$colorless_energy_required;
				// Au moins une énergie colorée
				if($energy_required_extra=="not_fully_colorless"){
					if($energy_required_type!='c'){
						$colored_search .= '['.$energy_required_type.'c]{'.($colored_energy_required-1).',}';
						$pattern_energy=$energy_required_type.$colored_search.$minimum_colorless_search;
					}
					else{
						if($colorless_energy_required==0){
							$minimum_colorless_search = 'c';
							if($colored_energy_required>0) $colored_energy_required-=1;
						}
						$colored_search .= '[a-z]{'.($colored_energy_required-1).',}';
						$pattern_energy='(^[abd-z]'.$colored_search.$minimum_colorless_search.'|[0-9][abd-z]'.$colored_search.$minimum_colorless_search.')';
					}
				}
				else{
					// Pas d'autre couleur
					if($energy_required_extra=="no_other_color" | $energy_required_extra==""){
						if($colored_energy_required==0) $colored_energy_required++;
						if($energy_required_type!='c') $pattern_energy.='(^['.$energy_required_type.'c]{'.$colored_energy_required.',}'.$minimum_colorless_search.'|[0-9]['.$energy_required_type.'c]{'.$colored_energy_required.',}'.$minimum_colorless_search.')';
						else $pattern_energy .= '(^c{'.$colored_energy_required.',}'.$minimum_colorless_search.'|[0-9]c{'.$colored_energy_required.',}'.$minimum_colorless_search.')';
					}
					// Autoriser d'autres couleurs
					elseif($energy_required_extra=="allow_other_colors"){
						if($energy_required_type!='c'){
							if($colored_energy_required>1){
								$colored_search.='(';
								for($i=1;$i<=($colored_energy_required);$i++){
									if($i!=1) $colored_search.='|';
									if($i<$colored_energy_required) $colored_search.='[a-z]{'.($colored_energy_required-$i).',}';
									$colored_search.=$energy_required_type;
									if($i>1) $colored_search.='[a-z]{'.($i-1).'}';
								}
								$colored_search.=')';
							}
							else $colored_search.=$energy_required_type;
							$pattern_energy=$colored_search.$minimum_colorless_search;
						}
						else{
							if($colorless_energy_required==0 && $energy_required>1) $pattern_energy='[a-z]{'.($energy_required-1).',}'.$energy_required_type;
							elseif($colorless_energy_required==0) $pattern_energy=$energy_required_type;
							elseif($colored_energy_required>0) $pattern_energy.='[a-z]{'.$colored_energy_required.',}'.$minimum_colorless_search;
							else $pattern_energy.=$minimum_colorless_search;
						}
					}
					// Attaques à zéro énergies
					if($energy_required==0 && $colorless_energy_required==0){
						if($pattern_energy!='') $pattern_energy='('.$pattern_energy.'|';
						$pattern_energy.='_';
						if($pattern_energy!='_') $pattern_energy.=')';
					}
				}
			}
			// N'importe quelle couleur
			elseif($energy_required>0){
				if($energy_required_extra=="not_fully_colorless"){
					if($colorless_energy_required==$energy_required) $energy_required+=1;
					$colored_energy=$energy_required-$colorless_energy_required;
					$pattern_energy='[abd-z]';
					if($colorless_energy_required<($energy_required-1)) $pattern_energy.='[a-z]{'.($colored_energy-1).',}';
				}
				elseif($colorless_energy_required<$energy_required) $pattern_energy='[a-z]{'.($energy_required-$colorless_energy_required).',}';
				$pattern_energy.=$minimum_colorless_search;
			}
			// N'importe quel nombre d'énergies
			else $pattern_energy='[a-z_]';
		}
		
		// Zéro énergies
		elseif($energy_required==0) $pattern_energy='_';
		
		// Inférieur ou égal
		elseif($energy_compare=="less_than"){
			if($energy_required_type!=NULL && strlen($energy_required_type)==1){
				// Au moins une énergie colorée
				if($energy_required_extra=="not_fully_colorless"){
					if($colorless_energy_required==$energy_required) $colorless_energy_required-=1;
					$colored_energy_max=$energy_required-$colorless_energy_required;
					if($energy_required_type!='c'){
						if($colorless_energy_required<($energy_required-1)) $colored_search .= '['.$energy_required_type.'c]{0,'.($colored_energy_max-1).'}';
						$pattern_energy='(^'.$energy_required_type.$colored_search.$minimum_colorless_search.'|[0-9]'.$energy_required_type.$colored_search.$minimum_colorless_search.')';
					}
					else{
						$colored_search='[abd-z]';
						if($colorless_energy_required>0 && $colored_energy_max-1>0) $colored_search.='[a-z]{0,'.($colored_energy_max-1).'}';
						elseif($colorless_energy_required==0 && $colored_energy_max-2>0) $colored_search.='[a-z]{0,'.($colored_energy_max-2).'}';
						if($colorless_energy_required==0 && $energy_required>1) $colored_search.='c';
						$pattern_energy='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
					}
				}
				else{
					// Autant d'incolore que le coût total
					if($colorless_energy_required==$energy_required) $pattern_energy .= '(^c{'.$energy_required.'}|[0-9]c{'.$energy_required.'})';
					// Pas d'autre couleur
					elseif($energy_required_extra=="no_other_color" | $energy_required_extra==""){
						$colored_energy_max=$energy_required-$colorless_energy_required;
						if($energy_required_type!='c'){
							if($colorless_energy_required==0) $colored_search .= '['.$energy_required_type.'c_]{1,'.$colored_energy_max.'}';
							else $colored_search .= '['.$energy_required_type.'c_]{0,'.$colored_energy_max.'}';
						}
						elseif($colorless_energy_required<$energy_required){
							if($colorless_energy_required==0) $colored_search.='[c_]{1,'.$colored_energy_max.'}';
							else $colored_search.='[c_]{0,'.$colored_energy_max.'}';
						}
						$pattern_energy.='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
					}
					// Autoriser d'autres couleurs
					elseif($energy_required_extra=="allow_other_colors"){
						$colored_energy_allowed=$energy_required-$colorless_energy_required;
						if($energy_required_type!='c'){
							$colored_search.='(';
							for($i=1;$i<=$colored_energy_allowed;$i++){
								if($i!=1) $colored_search.='|';
								if($i<$colored_energy_allowed) $colored_search.='[a-z]{0,'.($colored_energy_allowed-$i).'}';
								$colored_search.=$energy_required_type;
								if($i!=1) $colored_search.='[a-z]{0,'.($i-1).'}';
							}
							$colored_search.=')';
						}
						else{
							if($colorless_energy_required==0) $colored_search.='[a-z]{0,'.($colored_energy_allowed-1).'}c';
							else $colored_search.='[a-z]{0,'.($colored_energy_allowed).'}';
						}
						$pattern_energy='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
					}
				}
			}
			// N'importe quelle couleur
			else{
				if($energy_required_extra=="not_fully_colorless"){
					if($colorless_energy_required==$energy_required) $colorless_energy_required-=1;
					$colored_energy=$energy_required-$colorless_energy_required;
					$colored_search.='[abd-z]';
					if($colorless_energy_required<($energy_required-1)) $colored_search.='[a-z]{0,'.($colored_energy-1).'}';
				}
				else{
					if($colorless_energy_required==0) $colored_search.='[a-z_]{1,'.($energy_required-$colorless_energy_required).'}';
					elseif($colorless_energy_required<$energy_required) $colored_search.='[a-z_]{0,'.($energy_required-$colorless_energy_required).'}';
				}
				$pattern_energy='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
			}
		}
		
		// Égal
		else{
			if($energy_required_type!=NULL && strlen($energy_required_type)==1){
				// Au moins une énergie colorée
				if($energy_required_extra=="not_fully_colorless"){
					if($colorless_energy_required==$energy_required && $colorless_energy_required>0) $minimum_colorless_search = 'c{'.($colorless_energy_required-1).'}';
					if($energy_required_type!='c'){
						$colored_energy_required=$energy_required-$colorless_energy_required;
						if($colored_energy_required>1) $colored_search='['.$energy_required_type.'c]{'.($colored_energy_required-1).'}';
						$pattern_energy='(^'.$energy_required_type.$colored_search.$minimum_colorless_search.'|[0-9]'.$energy_required_type.$colored_search.$minimum_colorless_search.')';
					}
					else{
						$colored_search='[abd-z]';
						$colored_energy_max=$energy_required-$colorless_energy_required;
						if($colorless_energy_required>0 && $colored_energy_max-1>0) $colored_search.='[a-z]{'.($colored_energy_max-1).'}';
						elseif($colorless_energy_required==0 && $colored_energy_max-2>0) $colored_search.='[a-z]{'.($colored_energy_max-2).'}';
						if($colorless_energy_required==0 && $energy_required>1) $colored_search.='c';
						$pattern_energy='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
					}
				}
				else{
					// Pas d'autre couleur
					if($energy_required_extra=="no_other_color" | $energy_required_extra==""){
						if($energy_required_type!='c'){
							if($colorless_energy_required<$energy_required) $colored_search.='['.$energy_required_type.'c]{'.($energy_required-$colorless_energy_required).'}';
							$pattern_energy.='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
						}
						else $pattern_energy='(^c{'.$energy_required.'}|[0-9]c{'.$energy_required.'})';
					}
					// Autoriser d'autres couleurs
					if($energy_required_extra=="allow_other_colors"){
						$colored_energy_allowed=$energy_required-$colorless_energy_required;
						if($energy_required_type!='c'){
							$colored_search.='(';
							for($i=1;$i<=$colored_energy_allowed;$i++){
								if($i!=1) $colored_search.='|';
								if($i<$energy_required) $colored_search.='[a-z]{'.($energy_required-$i).'}';
								$colored_search.=$energy_required_type;
								if($i!=1)$colored_search.='[a-z]{'.($i-1).'}';
							}
							$colored_search.=')';
						}
						else{
							if($colorless_energy_required==0) $colored_search.='[a-z]{'.($colored_energy_allowed-1).'}c';
							else $colored_search.='[a-z]{'.($colored_energy_allowed).'}';
						}
						$pattern_energy='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
					}
				}
			}
			// N'importe quelle couleur
			else{
				if($energy_required_extra=="not_fully_colorless"){
					if($colorless_energy_required==$energy_required) $colorless_energy_required-=1;
					$colored_energy=$energy_required-$colorless_energy_required;
					$colored_search.='[abd-z]';
					if($colorless_energy_required<($energy_required-1)) $colored_search.='[a-z]{'.($colored_energy-1).'}';
				}
				elseif($colorless_energy_required<$energy_required) $colored_search.='[a-z]{'.($energy_required-$colorless_energy_required).'}';
				$pattern_energy.='(^'.$colored_search.$minimum_colorless_search.'|[0-9]'.$colored_search.$minimum_colorless_search.')';
			}
		}
	}
	// Si seulement un nombre d'énergies incolores requises est soumis (pas de coût total en énergie)
	elseif($colorless_energy_required>0){
		if($colorless_energy_required>0) $minimum_colorless_search = 'c{'.$colorless_energy_required.'}';
		else $minimum_colorless_search = '';
		if($energy_required_type!=NULL && strlen($energy_required_type)==1){
			if($energy_required_extra=="not_fully_colorless"){
				if($energy_required_type!='c') $pattern_energy=$energy_required_type.$minimum_colorless_search;
				else $pattern_energy='[abd-z]'.$minimum_colorless_search;
			}
			else{
				if($energy_required_extra=="no_other_color" | $energy_required_extra==""){
					$pattern_energy='[^';
					if($energy_required_type=="a") $pattern_energy.='b';
					elseif($energy_required_type=="b") $pattern_energy.='a';
					else $pattern_energy.='ab';
					if($energy_required_type=="e") $pattern_energy.='d';
					elseif($energy_required_type!="c" && $energy_required_type!="d") $pattern_energy.='d-'.chr(ord($energy_required_type)-1);
					if($energy_required_type=="y") $pattern_energy.='z';
					elseif($energy_required_type!="z") $pattern_energy.=chr(ord($energy_required_type)+1).'-z';
					$pattern_energy.=']';
					if($energy_required_type!='c') $pattern_energy.='['.$energy_required_type.'c]'.$minimum_colorless_search;
					else $pattern_energy.=$minimum_colorless_search;
				}
				if($energy_required_extra=="allow_other_colors"){
					if($energy_required_type!='c') $pattern_energy='[a-z]*'.$energy_required_type.'[a-z]*'.$minimum_colorless_search;
					else $pattern_energy='[a-z]*'.$minimum_colorless_search;
				}
			}
		}
		else{
			if($energy_required_extra=="not_fully_colorless") $pattern_energy='[abd-z]'.$minimum_colorless_search;
			else $pattern_energy=$minimum_colorless_search;
		}
	}
	// Si seulement une couleur d'énergie est soumise (pas de coût en énergie)
	elseif($energy_required_type!=NULL && strlen($energy_required_type)==1){
		if($energy_required_extra=="not_fully_colorless"){
			if($energy_required_type!='c') $pattern_energy='(^'.$energy_required_type.'{1,}['.$energy_required_type.'c]{0,}|[0-9]'.$energy_required_type.'{1,}['.$energy_required_type.'c]{0,})';
			else $pattern_energy='[abd-z]c{0,}c';
		}
		else{
			if($energy_required_extra=="no_other_color" | $energy_required_extra==""){
				if($energy_required_type!='c') $pattern_energy.='(^['.$energy_required_type.'c_]{1,}|[0-9]['.$energy_required_type.'c_]{1,})';
				else $pattern_energy.='(^[c_]{1,}|[0-9][c_]{1,})';
			}
			if($energy_required_extra=="allow_other_colors"){
				if($energy_required_type!='c') $pattern_energy='[a-z]*'.$energy_required_type.'[a-z]*';
				else $pattern_energy='[a-z]*c';
			}
		}
	}
	elseif($energy_required_extra=="not_fully_colorless") $pattern_energy='[abd-z]';
	
	if($pattern_damage!='') $pre_requete .= ' AND t_cards.attacks REGEXP "('.$pattern_energy.$pattern_damage.')"';
	elseif($pattern_energy!='') $pre_requete .= ' AND t_cards.attacks REGEXP "('.$pattern_energy.'[0-9]{3})"';
	
	
	/****************
	*	Order by	*
	****************/
	if($order_by!=NULL) $pre_requete .= " ORDER BY t_cards.".$order_by." ASC LIMIT 0, 250";
	elseif(strlen($search_name) > 3) $pre_requete .= " ORDER BY name_relevance DESC LIMIT 0, 250";
	else $pre_requete .= " ORDER BY t_cards.set_id, t_cards.number ASC LIMIT 0, 250";
	
	// Prepare SQL request
	$requete = $pdo->prepare($pre_requete);
	if($search_name!=NULL) {
		$requete->bindValue(':search_name', $search_name);
		if(strlen($search_name)>1) $requete->bindValue(':search_name_like', '%'.$search_name.'%');
	}
	if($search_text!=NULL) $requete->bindValue(':search_text', '%'.$search_text.'%');
	$requete->bindValue(':language', $language);
	if($criteria1!=0) $requete->bindValue(':criteria1', $criteria1);
	if($criteria2!=0) $requete->bindValue(':criteria2', $criteria2);
	if($criteria3!=0) $requete->bindValue(':criteria3', $criteria3);
	if($criteria4!=0) $requete->bindValue(':criteria4', $criteria4);
	if($criteria5!=0) $requete->bindValue(':criteria5', $criteria5);
	if($criteria6!=0) $requete->bindValue(':criteria6', $criteria6);
	if($criteria1!=0){
		$criteria1_not=sprintf('%u', ~$criteria1);
		$requete->bindValue(':criteria1_not', $criteria1_not);
	}
	if($criteria2!=0){
		$criteria2_not=sprintf('%u', ~$criteria2);
		$requete->bindValue(':criteria2_not', $criteria2_not);
	}
	if($criteria3!=0){
		$criteria3_not=sprintf('%u', ~$criteria3);
		$requete->bindValue(':criteria3_not', $criteria3_not);
	}
	if($criteria4!=0){
		$criteria4_not=sprintf('%u', ~$criteria4);
		$requete->bindValue(':criteria4_not', $criteria4_not);
	}
	if($criteria5!=0){
		$criteria5_not=sprintf('%u', ~$criteria5);
		$requete->bindValue(':criteria5_not', $criteria5_not);
	}
	if($criteria6!=0){
		$criteria6_not=sprintf('%u', ~$criteria6);
		$requete->bindValue(':criteria6_not', $criteria6_not);
	}
	if($variable_damage1!=0) $requete->bindValue(':variable_damage1', $variable_damage1);
	if($variable_damage2!=0) $requete->bindValue(':variable_damage2', $variable_damage2);
	if($variable_damage3!=0) $requete->bindValue(':variable_damage3', $variable_damage3);
	if($search_retrieve1!=0) $requete->bindValue(':search_retrieve1', $search_retrieve1);
	if($search_retrieve2!=0) $requete->bindValue(':search_retrieve2', $search_retrieve2);
	if(($hp_min>0||$hp_max<1000) && $hp_min<=1000 && $hp_max>=0 && is_numeric($hp_min) && is_numeric($hp_max)){
		$requete->bindValue(':hp_min', $hp_min);
		$requete->bindValue(':hp_max', $hp_max);
	}
	if(is_numeric($weakness) && $weakness!=NULL) $requete->bindValue(':weakness', $weakness);
	if(is_numeric($resistance) && $resistance!=NULL) $requete->bindValue(':resistance', $resistance);
	if(is_numeric($retreat_min) && is_numeric($retreat_max)){
		$requete->bindValue(':retreat_min', $retreat_min);
		$requete->bindValue(':retreat_max', $retreat_max);
	}
	if(is_numeric($owner_id) && $owner_id>0) $requete->bindValue(':owner_id', $owner_id);
	if(is_numeric($primal_trait) && $primal_trait>0) $requete->bindValue(':primal_trait', $primal_trait);
	$requete->execute();
	
	$number_of_results = $requete->rowCount();
	
	if($number_of_results > 0){
		if($format!="standard"){
			while ($card_result = $requete->fetch(PDO::FETCH_BOTH))
				$card_list[] = $card_result;
		}
		else{
			while ($card_result = $requete->fetch(PDO::FETCH_BOTH)){
				if($card_result['set_id']!=5005 || $card_result['number']>50) $card_list[] = $card_result;
			}
		}
	}
	// var_dump($requete->errorInfo());
	$requete->closeCursor();
	return $card_list;
}


function get_card_data($set_id=NULL, $card_number=NULL)
{
	$card_data = array();
	
	if ($set_id!=NULL && is_numeric($set_id) && $card_number!=NULL && is_numeric($card_number)) {
		$pdo = PDO2_CARDEX::getInstance();
		$pre_requete = "SELECT	*
						FROM	".SQL_TABLE_PREFIX."cards".SQL_TABLE_SUFFIX."
						WHERE	set_id = :set_id
						AND		number = :card_number";
		
		$requete = $pdo->prepare($pre_requete);
		$requete->bindValue(':set_id', $set_id);
		$requete->bindValue(':card_number', $card_number);
		$requete->execute();
		
		if($result = $requete->fetch(PDO::FETCH_BOTH)) {
			$card_data['identifier'] = $result['identifier'];
			$card_data['set_id'] = $result['set_id'];
			$card_data['set_identifier'] = get_set_identifier($result['set_id']);
			$card_data['number'] = $result['number'];
			$card_data['category_id'] = $result['category_id'];
			$card_data['hit_points'] = $result['hit_points'];
			$card_data['type1_id'] = $result['type1_id'];
			$card_data['type2_id'] = $result['type2_id'];
			$card_data['weakness1_id'] = $result['weakness1_id'];
			$card_data['weakness2_id'] = $result['weakness2_id'];
			$card_data['weakness1_amount'] = $result['weakness1_amount'];
			$card_data['weakness2_amount'] = $result['weakness2_amount'];
			$card_data['resistance1_id'] = $result['resistance1_id'];
			$card_data['resistance2_id'] = $result['resistance2_id'];
			$card_data['resistance1_amount'] = $result['resistance1_amount'];
			$card_data['resistance2_amount'] = $result['resistance2_amount'];
			$card_data['retreat_cost'] = $result['retreat_cost'];
			$card_data['rarity_id'] = $result['rarity_id'];
			$card_data['owner_id'] = $result['owner_id'];
			$card_data['attacks'] = $result['attacks'];
			$card_data['criterias1'] = $result['criterias1'];
			$card_data['criterias2'] = $result['criterias2'];
			$card_data['criterias3'] = $result['criterias3'];
			$card_data['criterias4'] = $result['criterias4'];
			$card_data['criterias5'] = $result['criterias5'];
			$card_data['criterias6'] = $result['criterias6'];
			$card_data['variable_damage1'] = $result['variable_damage1'];
			$card_data['variable_damage2'] = $result['variable_damage2'];
			$card_data['search_retrieve1'] = $result['search_retrieve1'];
			$card_data['search_retrieve2'] = $result['search_retrieve2'];
			$card_data['primal_trait'] = $result['primal_trait'];
		}
		$requete->closeCursor();
	}
	return $card_data;
}

function get_card_list($set_id=NULL)
{
	$card_list = array();
	
	if ($set_id!=NULL && is_numeric($set_id)) {
		$pdo = PDO2_CARDEX::getInstance();
		$pre_requete = "SELECT	*
						FROM	".SQL_TABLE_PREFIX."cards".SQL_TABLE_SUFFIX."
						WHERE	set_id = :set_id
						ORDER BY number";
		
		$requete = $pdo->prepare($pre_requete);
		$requete->bindValue(':set_id', $set_id);
		$requete->execute();
		
		while ($result = $requete->fetch(PDO::FETCH_BOTH)){
			$card_list['identifier'][] = $result['identifier'];
			$card_list['number'][] = $result['number'];
			$card_list['category_id'][] = $result['category_id'];
			$card_list['hit_points'][] = $result['hit_points'];
			$card_list['type1_id'][] = $result['type1_id'];
			$card_list['type2_id'][] = $result['type2_id'];
			$card_list['weakness1_id'][] = $result['weakness1_id'];
			$card_list['weakness2_id'][] = $result['weakness2_id'];
			$card_list['weakness1_amount'][] = $result['weakness1_amount'];
			$card_list['weakness2_amount'][] = $result['weakness2_amount'];
			$card_list['resistance1_id'][] = $result['resistance1_id'];
			$card_list['resistance2_id'][] = $result['resistance2_id'];
			$card_list['resistance1_amount'][] = $result['resistance1_amount'];
			$card_list['resistance2_amount'][] = $result['resistance2_amount'];
			$card_list['retreat_cost'][] = $result['retreat_cost'];
			$card_list['rarity_id'][] = $result['rarity_id'];
			$card_list['name_width'][] = calc_string_width($result['identifier']);
		}
		$requete->closeCursor();
	}
	return $card_list;
}

function get_card_name_text($set_id=NULL, $card_number=NULL, $language=DEFAULT_LANGUAGE)
{
	$card_data = array();
	
	if ($set_id!=NULL && is_numeric($set_id) && $card_number!=NULL && is_numeric($card_number)) {
		$pdo = PDO2_CARDEX::getInstance();
		$pre_requete = "SELECT	*
						FROM	".SQL_TABLE_PREFIX."cards_names".SQL_TABLE_SUFFIX."
						WHERE	set_id = :set_id
						AND		number = :card_number
						AND		local_language_id = :language";
		
		$requete = $pdo->prepare($pre_requete);
		$requete->bindValue(':set_id', $set_id);
		$requete->bindValue(':card_number', $card_number);
		$requete->bindValue(':language', $language);
		$requete->execute();
		
		if($result = $requete->fetch(PDO::FETCH_BOTH)) {
			$card_data['name'] = $result['name'];
			$card_data['text'] = $result['text'];
		}
		$requete->closeCursor();
	}
	return $card_data;
}

function get_category_identifier($category_id=NULL)
{
	$category_identifier = false;
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	identifier
					FROM	".SQL_TABLE_PREFIX."categories".SQL_TABLE_SUFFIX."
					WHERE	id = :category_id";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':category_id', $category_id);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$category_identifier = $result['identifier'];
	$requete->closeCursor();
	
	return $category_identifier;
}

function get_category_list()
{
	$category_list = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	*
					FROM	".SQL_TABLE_PREFIX."categories".SQL_TABLE_SUFFIX;
	$requete = $pdo->prepare($pre_requete);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)){
		$category_list['id'][] = $result['id'];
		$category_list['identifier'][] = $result['identifier'];
	}
	$requete->closeCursor();
	
	return $category_list;
}

function get_category_name($category_id=NULL, $language=DEFAULT_LANGUAGE)
{
	$category_name = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	name
					FROM	".SQL_TABLE_PREFIX."categories_names".SQL_TABLE_SUFFIX."
					WHERE	category_id = :category_id
					AND		local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':category_id', $category_id);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$category_name = $result['name'];
	$requete->closeCursor();
	
	return $category_name;
}

function get_category_names($category_list=NULL, $language=DEFAULT_LANGUAGE)
{
	$category_names = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	category_id, name
					FROM	".SQL_TABLE_PREFIX."categories_names".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language";
	if (is_array($category_list)){
		$pre_requete .= " AND category_id IN (";
		foreach($category_list as $category_id)
			$pre_requete .= $category_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH))
		$category_names[$result['category_id']] = $result['name'];
	$requete->closeCursor();
	
	return $category_names;
}

function get_criteria_group_list($language=DEFAULT_LANGUAGE)
{
	$criteria_group_list = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id, name
					FROM	".SQL_TABLE_PREFIX."criterias_groups".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)) {
		$criteria_group_list[$result['id']]['name'] = $result['name'];
	}
	$requete->closeCursor();
	
	return $criteria_group_list;
}

function get_criteria_list($language=DEFAULT_LANGUAGE)
{
	$criteria_list = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id, group_id, name, criterias_order, format_id
					FROM	".SQL_TABLE_PREFIX."criterias".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language
					ORDER BY criterias_order";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)) {
		$criteria_list[$result['criterias_order']]['group_id'] = $result['group_id'];
		$criteria_list[$result['criterias_order']]['name'] = $result['name'];
		$criteria_list[$result['criterias_order']]['id'] = $result['id'];
		$criteria_list[$result['criterias_order']]['format_id'] = $result['format_id'];
	}
	$requete->closeCursor();
	
	return $criteria_list;
}

function get_format_id($format="unlimited")
{
	$format_id = 1;
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id
					FROM	".SQL_TABLE_PREFIX."formats".SQL_TABLE_SUFFIX."
					WHERE	identifier = :format";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':format', $format);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$format_id = $result['id'];
	$requete->closeCursor();
	
	return $format_id;
}

function get_owners($format_id=1, $language=DEFAULT_LANGUAGE)
{
	$owners_list = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id, name
					FROM	".SQL_TABLE_PREFIX."owners".SQL_TABLE_SUFFIX."
					WHERE	format_id = :format_id
					AND		local_language_id = :language
					ORDER BY name";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':format_id', $format_id);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)) {
		$owners_list[$result['id']] = $result['name'];
	}
	$requete->closeCursor();
	
	return $owners_list;
}

function get_primal_traits($language=DEFAULT_LANGUAGE)
{
	$primal_traits = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	*
					FROM	".SQL_TABLE_PREFIX."primal_traits".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)){
		$primal_traits[$result['id']] = $result['name'];
	}
	$requete->closeCursor();
	
	return $primal_traits;
}

function get_rarity_identifier($rarity_id=NULL)
{
	$rarity_identifier = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	identifier
					FROM	".SQL_TABLE_PREFIX."rarity".SQL_TABLE_SUFFIX."
					WHERE	id = :rarity_id";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':rarity_id', $rarity_id);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$rarity_identifier = $result['identifier'];
	$requete->closeCursor();
	
	return $rarity_identifier;
}

function get_rarity_list()
{
	$rarity_list = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	*
					FROM	".SQL_TABLE_PREFIX."rarity".SQL_TABLE_SUFFIX;
	$requete = $pdo->prepare($pre_requete);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)){
		$rarity_list['id'][] = $result['id'];
		$rarity_list['identifier'][] = $result['identifier'];
		$rarity_list['symbol'][] = $result['symbol'];
	}
	$requete->closeCursor();
	
	return $rarity_list;
}

function get_rarity_name($rarity_id=NULL, $language=DEFAULT_LANGUAGE)
{
	$rarity_name = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	name
					FROM	".SQL_TABLE_PREFIX."rarity_names".SQL_TABLE_SUFFIX."
					WHERE	rarity_id = :rarity_id
					AND		local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':rarity_id', $rarity_id);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$rarity_name = $result['name'];
	$requete->closeCursor();
	
	return $rarity_name;
}

function get_rarity_names($rarity_list=NULL, $language=DEFAULT_LANGUAGE)
{
	$rarity_names = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	rarity_id, name
					FROM	".SQL_TABLE_PREFIX."rarity_names".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language";
	if (is_array($rarity_list)){
		$pre_requete .= " AND rarity_id IN (";
		foreach($rarity_list as $rarity_id)
			$pre_requete .= $rarity_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH))
		$rarity_names[$result['rarity_id']] = $result['name'];
	$requete->closeCursor();
	
	return $rarity_names;
}

function get_set_card_total($identifier=NULL)
{
	$set_card_total = NULL;
	
	if ($identifier!=NULL){
		$pdo = PDO2_CARDEX::getInstance();
		$pre_requete = "SELECT	card_total
						FROM	".SQL_TABLE_PREFIX."sets".SQL_TABLE_SUFFIX."
						WHERE	identifier = :identifier";
		$requete = $pdo->prepare($pre_requete);
		$requete->bindValue(':identifier', $identifier);
		$requete->execute();
		
		if ($result = $requete->fetch(PDO::FETCH_BOTH))
			$set_card_total = $result['card_total'];
		
		$requete->closeCursor();
	}
	return $set_card_total;
}

function get_set_id($identifier=NULL)
{
	$set_id = NULL;
	
	if ($identifier!=NULL){
		$pdo = PDO2_CARDEX::getInstance();
		$pre_requete = "SELECT	id
						FROM	".SQL_TABLE_PREFIX."sets".SQL_TABLE_SUFFIX."
						WHERE	identifier = :identifier";
		$requete = $pdo->prepare($pre_requete);
		$requete->bindValue(':identifier', $identifier);
		$requete->execute();
		
		if ($result = $requete->fetch(PDO::FETCH_BOTH))
			$set_id = $result['id'];
		
		$requete->closeCursor();
	}
	return $set_id;
}

function get_set_identifier($id=NULL)
{
	$set_identifier = NULL;
	
	if ($id!=NULL){
		$pdo = PDO2_CARDEX::getInstance();
		$pre_requete = "SELECT	identifier
						FROM	".SQL_TABLE_PREFIX."sets".SQL_TABLE_SUFFIX."
						WHERE	id = :id";
		$requete = $pdo->prepare($pre_requete);
		$requete->bindValue(':id', $id);
		$requete->execute();
		
		if ($result = $requete->fetch(PDO::FETCH_BOTH))
			$set_identifier = $result['identifier'];
		
		$requete->closeCursor();
	}
	return $set_identifier;
}

function get_set_list()
{
	$set_list = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	*
					FROM	".SQL_TABLE_PREFIX."sets".SQL_TABLE_SUFFIX."
					ORDER BY set_order";
	$requete = $pdo->prepare($pre_requete);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)){
		$set_list['id'][] = $result['id'];
		$set_list['identifier'][] = $result['identifier'];
		$set_list['card_total'][] = $result['card_total'];
		$set_list['released'][] = $result['released'];
		$set_list['set_order'][] = $result['set_order'];
	}
	$requete->closeCursor();
	
	return $set_list;
}

function get_set_name($set_id=NULL, $language=DEFAULT_LANGUAGE)
{
	$set_name = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	name
					FROM	".SQL_TABLE_PREFIX."sets_names".SQL_TABLE_SUFFIX."
					WHERE	id = :set_id
					AND		local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':set_id', $set_id);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$set_name = $result['name'];
	$requete->closeCursor();
	
	return $set_name;
}

function get_set_names($set_list=NULL, $language=DEFAULT_LANGUAGE)
{
	$set_names = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id, name
					FROM	".SQL_TABLE_PREFIX."sets_names".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language";
	if(is_array($set_list)) {
		$pre_requete .= " AND id IN (";
		foreach($set_list as $set_id)
			$pre_requete .= $set_id.",";
		$pre_requete = preg_replace('#(,{1})$#', ')', $pre_requete);
	}
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while($result = $requete->fetch(PDO::FETCH_BOTH)){
		$set_names[$result['id']] = $result['name'];
	}
	$requete->closeCursor();
	
	return $set_names;
}

function get_type_identifier($type_id=NULL, $language=DEFAULT_LANGUAGE)
{
	$type_identifier = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	identifier
					FROM	".SQL_TABLE_PREFIX."types".SQL_TABLE_SUFFIX."
					WHERE	id = :type_id";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':type_id', $type_id);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$type_identifier = $result['identifier'];
	$requete->closeCursor();
	
	return $type_identifier;
}


function get_type_list()
{
	$type_list = array();
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	*
					FROM	".SQL_TABLE_PREFIX."types".SQL_TABLE_SUFFIX;
	$requete = $pdo->prepare($pre_requete);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)){
		$type_list['id'][] = $result['id'];
		$type_list['identifier'][] = $result['identifier'];
		$type_list['symbol'][] = $result['symbol'];
	}
	$requete->closeCursor();
	
	return $type_list;
}

function get_type_name($type_id=NULL, $language=DEFAULT_LANGUAGE)
{
	$type_name = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	name
					FROM	".SQL_TABLE_PREFIX."types_names".SQL_TABLE_SUFFIX."
					WHERE	type_id = :type_id
					AND		local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':type_id', $type_id);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$type_name = $result['name'];
	$requete->closeCursor();
	
	return $type_name;
}

function get_type_symbol($type_id=NULL)
{
	$type_symbol = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	symbol
					FROM	".SQL_TABLE_PREFIX."types".SQL_TABLE_SUFFIX."
					WHERE	id = :type_id";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':type_id', $type_id);
	$requete->execute();
	
	if($result = $requete->fetch(PDO::FETCH_BOTH))
		$type_symbol = $result['symbol'];
	$requete->closeCursor();
	
	return $type_symbol;
}

function get_variable_damage_group_list($language=DEFAULT_LANGUAGE)
{
	$variable_damage_group_list = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id, name
					FROM	".SQL_TABLE_PREFIX."variable_damage_groups".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)) {
		$variable_damage_group_list[$result['id']]['name'] = $result['name'];
	}
	$requete->closeCursor();
	
	return $variable_damage_group_list;
}

function get_variable_damage_list($language=DEFAULT_LANGUAGE)
{
	$variable_damage_list = '';
	
	$pdo = PDO2_CARDEX::getInstance();
	$pre_requete = "SELECT	id, group_id, name, variable_damage_order, format_id
					FROM	".SQL_TABLE_PREFIX."variable_damage".SQL_TABLE_SUFFIX."
					WHERE	local_language_id = :language
					ORDER BY variable_damage_order";
	$requete = $pdo->prepare($pre_requete);
	$requete->bindValue(':language', $language);
	$requete->execute();
	
	while ($result = $requete->fetch(PDO::FETCH_BOTH)) {
		$variable_damage_list[$result['variable_damage_order']]['group_id'] = $result['group_id'];
		$variable_damage_list[$result['variable_damage_order']]['name'] = $result['name'];
		$variable_damage_list[$result['variable_damage_order']]['id'] = $result['id'];
		$variable_damage_list[$result['variable_damage_order']]['format_id'] = $result['format_id'];
	}
	$requete->closeCursor();
	
	return $variable_damage_list;
}
