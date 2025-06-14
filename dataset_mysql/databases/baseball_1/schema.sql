-- Dialect: mysql | Database: baseball_1 | Table Count: 26

CREATE TABLE `baseball_1`.`team` (
    `year` INTEGER,
    `league_id` TEXT,
    `team_id` VARCHAR(50),
    `franchise_id` TEXT,
    `div_id` TEXT,
    `rank` INTEGER,
    `g` INTEGER,
    `ghome` NUMERIC,
    `w` INTEGER,
    `l` INTEGER,
    `div_win` TEXT,
    `wc_win` TEXT,
    `lg_win` TEXT,
    `ws_win` TEXT,
    `r` INTEGER,
    `ab` INTEGER,
    `h` INTEGER,
    `double` INTEGER,
    `triple` INTEGER,
    `hr` INTEGER,
    `bb` INTEGER,
    `so` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `hbp` NUMERIC,
    `sf` NUMERIC,
    `ra` INTEGER,
    `er` INTEGER,
    `era` NUMERIC,
    `cg` INTEGER,
    `sho` INTEGER,
    `sv` INTEGER,
    `ipouts` INTEGER,
    `ha` INTEGER,
    `hra` INTEGER,
    `bba` INTEGER,
    `soa` INTEGER,
    `e` INTEGER,
    `dp` NUMERIC,
    `fp` NUMERIC,
    `name` TEXT,
    `park` TEXT,
    `attendance` NUMERIC,
    `bpf` INTEGER,
    `ppf` INTEGER,
    `team_id_br` TEXT,
    `team_id_lahman45` TEXT,
    `team_id_retro` TEXT,
    INDEX idx_team_id (`team_id`)
);

CREATE TABLE `baseball_1`.`player` (
    `player_id` VARCHAR(50),
    `birth_year` NUMERIC,
    `birth_month` NUMERIC,
    `birth_day` NUMERIC,
    `birth_country` TEXT,
    `birth_state` TEXT,
    `birth_city` TEXT,
    `death_year` NUMERIC,
    `death_month` NUMERIC,
    `death_day` NUMERIC,
    `death_country` TEXT,
    `death_state` TEXT,
    `death_city` TEXT,
    `name_first` TEXT,
    `name_last` TEXT,
    `name_given` TEXT,
    `weight` NUMERIC,
    `height` NUMERIC,
    `bats` TEXT,
    `throws` TEXT,
    `debut` TEXT,
    `final_game` TEXT,
    `retro_id` TEXT,
    `bbref_id` TEXT,
    PRIMARY KEY (`player_id`)
);

CREATE TABLE `baseball_1`.`all_star` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `game_num` INTEGER,
    `game_id` TEXT,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `gp` NUMERIC,
    `starting_pos` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`appearances` (
    `year` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `player_id` VARCHAR(50),
    `g_all` NUMERIC,
    `gs` NUMERIC,
    `g_batting` INTEGER,
    `g_defense` NUMERIC,
    `g_p` INTEGER,
    `g_c` INTEGER,
    `g_1b` INTEGER,
    `g_2b` INTEGER,
    `g_3b` INTEGER,
    `g_ss` INTEGER,
    `g_lf` INTEGER,
    `g_cf` INTEGER,
    `g_rf` INTEGER,
    `g_of` INTEGER,
    `g_dh` NUMERIC,
    `g_ph` NUMERIC,
    `g_pr` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`manager_award` (
    `player_id` VARCHAR(50),
    `award_id` TEXT,
    `year` INTEGER,
    `league_id` TEXT,
    `tie` TEXT,
    `notes` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`player_award` (
    `player_id` VARCHAR(50),
    `award_id` TEXT,
    `year` INTEGER,
    `league_id` TEXT,
    `tie` TEXT,
    `notes` TEXT,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`manager_award_vote` (
    `award_id` TEXT,
    `year` INTEGER,
    `league_id` TEXT,
    `player_id` VARCHAR(50),
    `points_won` INTEGER,
    `points_max` INTEGER,
    `votes_first` INTEGER
);

CREATE TABLE `baseball_1`.`player_award_vote` (
    `award_id` TEXT,
    `year` INTEGER,
    `league_id` TEXT,
    `player_id` VARCHAR(50),
    `points_won` NUMERIC,
    `points_max` INTEGER,
    `votes_first` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`batting` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `stint` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `g` INTEGER,
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
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`batting_postseason` (
    `year` INTEGER,
    `round` TEXT,
    `player_id` VARCHAR(50),
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `g` INTEGER,
    `ab` INTEGER,
    `r` INTEGER,
    `h` INTEGER,
    `double` INTEGER,
    `triple` INTEGER,
    `hr` INTEGER,
    `rbi` INTEGER,
    `sb` INTEGER,
    `cs` NUMERIC,
    `bb` INTEGER,
    `so` INTEGER,
    `ibb` NUMERIC,
    `hbp` NUMERIC,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`college` (
    `college_id` VARCHAR(50),
    `name_full` TEXT,
    `city` TEXT,
    `state` TEXT,
    `country` TEXT,
    PRIMARY KEY (`college_id`)
);

CREATE TABLE `baseball_1`.`player_college` (
    `player_id` VARCHAR(50),
    `college_id` VARCHAR(50),
    `year` INTEGER,
    FOREIGN KEY (`college_id`) REFERENCES `baseball_1`.`college` (`college_id`),
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`fielding` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `stint` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `pos` TEXT,
    `g` INTEGER,
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
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`fielding_outfield` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `stint` INTEGER,
    `glf` NUMERIC,
    `gcf` NUMERIC,
    `grf` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`fielding_postseason` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `round` TEXT,
    `pos` TEXT,
    `g` INTEGER,
    `gs` NUMERIC,
    `inn_outs` NUMERIC,
    `po` INTEGER,
    `a` INTEGER,
    `e` INTEGER,
    `dp` INTEGER,
    `tp` INTEGER,
    `pb` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`hall_of_fame` (
    `player_id` VARCHAR(50),
    `yearid` INTEGER,
    `votedby` TEXT,
    `ballots` NUMERIC,
    `needed` NUMERIC,
    `votes` NUMERIC,
    `inducted` TEXT,
    `category` TEXT,
    `needed_note` TEXT,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`)
);

CREATE TABLE `baseball_1`.`park` (
    `park_id` VARCHAR(50),
    `park_name` TEXT,
    `park_alias` TEXT,
    `city` TEXT,
    `state` TEXT,
    `country` TEXT,
    PRIMARY KEY (`park_id`)
);

CREATE TABLE `baseball_1`.`home_game` (
    `year` INTEGER,
    `league_id` TEXT,
    `team_id` VARCHAR(50),
    `park_id` VARCHAR(50),
    `span_first` TEXT,
    `span_last` TEXT,
    `games` INTEGER,
    `openings` INTEGER,
    `attendance` INTEGER,
    FOREIGN KEY (`park_id`) REFERENCES `baseball_1`.`park` (`park_id`)
);

CREATE TABLE `baseball_1`.`manager` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `inseason` INTEGER,
    `g` INTEGER,
    `w` INTEGER,
    `l` INTEGER,
    `rank` NUMERIC,
    `plyr_mgr` TEXT
);

CREATE TABLE `baseball_1`.`manager_half` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `inseason` INTEGER,
    `half` INTEGER,
    `g` INTEGER,
    `w` INTEGER,
    `l` INTEGER,
    `rank` INTEGER
);

CREATE TABLE `baseball_1`.`pitching` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `stint` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `w` INTEGER,
    `l` INTEGER,
    `g` INTEGER,
    `gs` INTEGER,
    `cg` INTEGER,
    `sho` INTEGER,
    `sv` INTEGER,
    `ipouts` NUMERIC,
    `h` INTEGER,
    `er` INTEGER,
    `hr` INTEGER,
    `bb` INTEGER,
    `so` INTEGER,
    `baopp` NUMERIC,
    `era` NUMERIC,
    `ibb` NUMERIC,
    `wp` NUMERIC,
    `hbp` NUMERIC,
    `bk` INTEGER,
    `bfp` NUMERIC,
    `gf` NUMERIC,
    `r` INTEGER,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC
);

CREATE TABLE `baseball_1`.`pitching_postseason` (
    `player_id` VARCHAR(50),
    `year` INTEGER,
    `round` TEXT,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `w` INTEGER,
    `l` INTEGER,
    `g` INTEGER,
    `gs` INTEGER,
    `cg` INTEGER,
    `sho` INTEGER,
    `sv` INTEGER,
    `ipouts` INTEGER,
    `h` INTEGER,
    `er` INTEGER,
    `hr` INTEGER,
    `bb` INTEGER,
    `so` INTEGER,
    `baopp` TEXT,
    `era` NUMERIC,
    `ibb` NUMERIC,
    `wp` NUMERIC,
    `hbp` NUMERIC,
    `bk` NUMERIC,
    `bfp` NUMERIC,
    `gf` INTEGER,
    `r` INTEGER,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC
);

CREATE TABLE `baseball_1`.`salary` (
    `year` INTEGER,
    `team_id` VARCHAR(50),
    `league_id` TEXT,
    `player_id` VARCHAR(50),
    `salary` INTEGER
);

CREATE TABLE `baseball_1`.`postseason` (
    `year` INTEGER,
    `round` TEXT,
    `team_id_winner` TEXT,
    `league_id_winner` TEXT,
    `team_id_loser` TEXT,
    `league_id_loser` TEXT,
    `wins` INTEGER,
    `losses` INTEGER,
    `ties` INTEGER
);

CREATE TABLE `baseball_1`.`team_franchise` (
    `franchise_id` TEXT,
    `franchise_name` TEXT,
    `active` TEXT,
    `na_assoc` TEXT
);

CREATE TABLE `baseball_1`.`team_half` (
    `year` INTEGER,
    `league_id` TEXT,
    `team_id` VARCHAR(50),
    `half` INTEGER,
    `div_id` TEXT,
    `div_win` TEXT,
    `rank` INTEGER,
    `g` INTEGER,
    `w` INTEGER,
    `l` INTEGER
);
