drop table if exists `baseball_1`.`team`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`team` (
    `year` INT,
    `league_id` STRING,
    `team_id` STRING,
    `franchise_id` STRING,
    `div_id` STRING,
    `rank` INT,
    `g` INT,
    `ghome` NUMERIC,
    `w` INT,
    `l` INT,
    `div_win` STRING,
    `wc_win` STRING,
    `lg_win` STRING,
    `ws_win` STRING,
    `r` INT,
    `ab` INT,
    `h` INT,
    `double` INT,
    `triple` INT,
    `hr` INT,
    `bb` INT,
    `so` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `hbp` NUMERIC,
    `sf` NUMERIC,
    `ra` INT,
    `er` INT,
    `era` NUMERIC,
    `cg` INT,
    `sho` INT,
    `sv` INT,
    `ipouts` INT,
    `ha` INT,
    `hra` INT,
    `bba` INT,
    `soa` INT,
    `e` INT,
    `dp` NUMERIC,
    `fp` NUMERIC,
    `name` STRING,
    `park` STRING,
    `attendance` NUMERIC,
    `bpf` INT,
    `ppf` INT,
    `team_id_br` STRING,
    `team_id_lahman45` STRING,
    `team_id_retro` STRING,
    UNIQUE (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/team.csv' INTO TABLE `baseball_1`.`team`;


drop table if exists `baseball_1`.`player`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player` (
    `player_id` STRING,
    `birth_year` NUMERIC,
    `birth_month` NUMERIC,
    `birth_day` NUMERIC,
    `birth_country` STRING,
    `birth_state` STRING,
    `birth_city` STRING,
    `death_year` NUMERIC,
    `death_month` NUMERIC,
    `death_day` NUMERIC,
    `death_country` STRING,
    `death_state` STRING,
    `death_city` STRING,
    `name_first` STRING,
    `name_last` STRING,
    `name_given` STRING,
    `weight` NUMERIC,
    `height` NUMERIC,
    `bats` STRING,
    `throws` STRING,
    `debut` STRING,
    `final_game` STRING,
    `retro_id` STRING,
    `bbref_id` STRING,
    UNIQUE (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player.csv' INTO TABLE `baseball_1`.`player`;


drop table if exists `baseball_1`.`all_star`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`all_star` (
    `player_id` STRING,
    `year` INT,
    `game_num` INT,
    `game_id` STRING,
    `team_id` STRING,
    `league_id` STRING,
    `gp` NUMERIC,
    `starting_pos` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/all_star.csv' INTO TABLE `baseball_1`.`all_star`;


drop table if exists `baseball_1`.`appearances`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`appearances` (
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `player_id` STRING,
    `g_all` NUMERIC,
    `gs` NUMERIC,
    `g_batting` INT,
    `g_defense` NUMERIC,
    `g_p` INT,
    `g_c` INT,
    `g_1b` INT,
    `g_2b` INT,
    `g_3b` INT,
    `g_ss` INT,
    `g_lf` INT,
    `g_cf` INT,
    `g_rf` INT,
    `g_of` INT,
    `g_dh` NUMERIC,
    `g_ph` NUMERIC,
    `g_pr` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/appearances.csv' INTO TABLE `baseball_1`.`appearances`;


drop table if exists `baseball_1`.`manager_award`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager_award` (
    `player_id` STRING,
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `tie` STRING,
    `notes` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager_award.csv' INTO TABLE `baseball_1`.`manager_award`;


drop table if exists `baseball_1`.`player_award`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player_award` (
    `player_id` STRING,
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `tie` STRING,
    `notes` STRING,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player_award.csv' INTO TABLE `baseball_1`.`player_award`;


drop table if exists `baseball_1`.`manager_award_vote`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager_award_vote` (
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `player_id` STRING,
    `points_won` INT,
    `points_max` INT,
    `votes_first` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager_award_vote.csv' INTO TABLE `baseball_1`.`manager_award_vote`;


drop table if exists `baseball_1`.`player_award_vote`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player_award_vote` (
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `player_id` STRING,
    `points_won` NUMERIC,
    `points_max` INT,
    `votes_first` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player_award_vote.csv' INTO TABLE `baseball_1`.`player_award_vote`;


drop table if exists `baseball_1`.`batting`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`batting` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `team_id` STRING,
    `league_id` STRING,
    `g` INT,
    `ab` NUMERIC,
    `r` NUMERIC,
    `h` NUMERIC,
    `double` NUMERIC,
    `triple` NUMERIC,
    `hr` NUMERIC,
    `rbi` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `bb` NUMERIC,
    `so` NUMERIC,
    `ibb` NUMERIC,
    `hbp` NUMERIC,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/batting.csv' INTO TABLE `baseball_1`.`batting`;


drop table if exists `baseball_1`.`batting_postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`batting_postseason` (
    `year` INT,
    `round` STRING,
    `player_id` STRING,
    `team_id` STRING,
    `league_id` STRING,
    `g` INT,
    `ab` INT,
    `r` INT,
    `h` INT,
    `double` INT,
    `triple` INT,
    `hr` INT,
    `rbi` INT,
    `sb` INT,
    `cs` NUMERIC,
    `bb` INT,
    `so` INT,
    `ibb` NUMERIC,
    `hbp` NUMERIC,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/batting_postseason.csv' INTO TABLE `baseball_1`.`batting_postseason`;


drop table if exists `baseball_1`.`college`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`college` (
    `college_id` STRING,
    `name_full` STRING,
    `city` STRING,
    `state` STRING,
    `country` STRING,
    UNIQUE (`college_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/college.csv' INTO TABLE `baseball_1`.`college`;


drop table if exists `baseball_1`.`player_college`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player_college` (
    `player_id` STRING,
    `college_id` STRING,
    `year` INT,
    FOREIGN KEY (`college_id`) REFERENCES `baseball_1`.`college` (`college_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player_college.csv' INTO TABLE `baseball_1`.`player_college`;


drop table if exists `baseball_1`.`fielding`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`fielding` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `team_id` STRING,
    `league_id` STRING,
    `pos` STRING,
    `g` INT,
    `gs` NUMERIC,
    `inn_outs` NUMERIC,
    `po` NUMERIC,
    `a` NUMERIC,
    `e` NUMERIC,
    `dp` NUMERIC,
    `pb` NUMERIC,
    `wp` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `zr` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/fielding.csv' INTO TABLE `baseball_1`.`fielding`;


drop table if exists `baseball_1`.`fielding_outfield`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`fielding_outfield` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `glf` NUMERIC,
    `gcf` NUMERIC,
    `grf` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/fielding_outfield.csv' INTO TABLE `baseball_1`.`fielding_outfield`;


drop table if exists `baseball_1`.`fielding_postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`fielding_postseason` (
    `player_id` STRING,
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `round` STRING,
    `pos` STRING,
    `g` INT,
    `gs` NUMERIC,
    `inn_outs` NUMERIC,
    `po` INT,
    `a` INT,
    `e` INT,
    `dp` INT,
    `tp` INT,
    `pb` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/fielding_postseason.csv' INTO TABLE `baseball_1`.`fielding_postseason`;


drop table if exists `baseball_1`.`hall_of_fame`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`hall_of_fame` (
    `player_id` STRING,
    `yearid` INT,
    `votedby` STRING,
    `ballots` NUMERIC,
    `needed` NUMERIC,
    `votes` NUMERIC,
    `inducted` STRING,
    `category` STRING,
    `needed_note` STRING,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/hall_of_fame.csv' INTO TABLE `baseball_1`.`hall_of_fame`;


drop table if exists `baseball_1`.`park`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`park` (
    `park_id` STRING,
    `park_name` STRING,
    `park_alias` STRING,
    `city` STRING,
    `state` STRING,
    `country` STRING,
    UNIQUE (`park_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/park.csv' INTO TABLE `baseball_1`.`park`;


drop table if exists `baseball_1`.`home_game`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`home_game` (
    `year` INT,
    `league_id` STRING,
    `team_id` STRING,
    `park_id` STRING,
    `span_first` STRING,
    `span_last` STRING,
    `games` INT,
    `openings` INT,
    `attendance` INT,
    FOREIGN KEY (`park_id`) REFERENCES `baseball_1`.`park` (`park_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/home_game.csv' INTO TABLE `baseball_1`.`home_game`;


drop table if exists `baseball_1`.`manager`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager` (
    `player_id` STRING,
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `inseason` INT,
    `g` INT,
    `w` INT,
    `l` INT,
    `rank` NUMERIC,
    `plyr_mgr` STRING,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager.csv' INTO TABLE `baseball_1`.`manager`;


drop table if exists `baseball_1`.`manager_half`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager_half` (
    `player_id` STRING,
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `inseason` INT,
    `half` INT,
    `g` INT,
    `w` INT,
    `l` INT,
    `rank` INT,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager_half.csv' INTO TABLE `baseball_1`.`manager_half`;


drop table if exists `baseball_1`.`pitching`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`pitching` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `team_id` STRING,
    `league_id` STRING,
    `w` INT,
    `l` INT,
    `g` INT,
    `gs` INT,
    `cg` INT,
    `sho` INT,
    `sv` INT,
    `ipouts` NUMERIC,
    `h` INT,
    `er` INT,
    `hr` INT,
    `bb` INT,
    `so` INT,
    `baopp` NUMERIC,
    `era` NUMERIC,
    `ibb` NUMERIC,
    `wp` NUMERIC,
    `hbp` NUMERIC,
    `bk` INT,
    `bfp` NUMERIC,
    `gf` NUMERIC,
    `r` INT,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/pitching.csv' INTO TABLE `baseball_1`.`pitching`;


drop table if exists `baseball_1`.`pitching_postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`pitching_postseason` (
    `player_id` STRING,
    `year` INT,
    `round` STRING,
    `team_id` STRING,
    `league_id` STRING,
    `w` INT,
    `l` INT,
    `g` INT,
    `gs` INT,
    `cg` INT,
    `sho` INT,
    `sv` INT,
    `ipouts` INT,
    `h` INT,
    `er` INT,
    `hr` INT,
    `bb` INT,
    `so` INT,
    `baopp` STRING,
    `era` NUMERIC,
    `ibb` NUMERIC,
    `wp` NUMERIC,
    `hbp` NUMERIC,
    `bk` NUMERIC,
    `bfp` NUMERIC,
    `gf` INT,
    `r` INT,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/pitching_postseason.csv' INTO TABLE `baseball_1`.`pitching_postseason`;


drop table if exists `baseball_1`.`salary`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`salary` (
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `player_id` STRING,
    `salary` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/salary.csv' INTO TABLE `baseball_1`.`salary`;


drop table if exists `baseball_1`.`postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`postseason` (
    `year` INT,
    `round` STRING,
    `team_id_winner` STRING,
    `league_id_winner` STRING,
    `team_id_loser` STRING,
    `league_id_loser` STRING,
    `wins` INT,
    `losses` INT,
    `ties` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/postseason.csv' INTO TABLE `baseball_1`.`postseason`;


drop table if exists `baseball_1`.`team_franchise`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`team_franchise` (
    `franchise_id` STRING,
    `franchise_name` STRING,
    `active` STRING,
    `na_assoc` STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/team_franchise.csv' INTO TABLE `baseball_1`.`team_franchise`;


drop table if exists `baseball_1`.`team_half`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`team_half` (
    `year` INT,
    `league_id` STRING,
    `team_id` STRING,
    `half` INT,
    `div_id` STRING,
    `div_win` STRING,
    `rank` INT,
    `g` INT,
    `w` INT,
    `l` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/team_half.csv' INTO TABLE `baseball_1`.`team_half`;

