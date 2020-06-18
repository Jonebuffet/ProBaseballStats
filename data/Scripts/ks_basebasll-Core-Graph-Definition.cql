CREATE KEYSPACE ks_baseball WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}  AND durable_writes = true AND graph_engine = 'Core';

CREATE TABLE ks_baseball.player_info (
    playerid text PRIMARY KEY,
    bats text,
    bbrefid text,
    birthcity text,
    birthcountry text,
    birthday int,
    birthmonth int,
    birthstate text,
    birthyear int,
    deathcity text,
    deathcountry text,
    deathday int,
    deathmonth int,
    deathstate text,
    deathyear int,
    debut date,
    finalgame date,
    height text,
    namefirst text,
    namegiven text,
    namelast text,
    retroid text,
    throws text,
    weight double
) WITH additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND VERTEX LABEL player_info_vtx;

CREATE TABLE ks_baseball.player_pitching_by_year (
    playerid text,
    yearid int,
    baopp decimal,
    bb int,
    bfp int,
    bk int,
    cg int,
    er int,
    era decimal,
    game_starts int,
    games int,
    gf int,
    gidp int,
    hbp int,
    hits int,
    hr int,
    ibb int,
    ipouts int,
    lgid text,
    loses int,
    r int,
    sf int,
    sh int,
    sho int,
    so int,
    stint int,
    sv int,
    teamid text,
    wins int,
    wp int,
    PRIMARY KEY (playerid, yearid)
) WITH CLUSTERING ORDER BY (yearid ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND VERTEX LABEL player_yearly_pitching_vtx;

CREATE TABLE ks_baseball.player_batting_by_year (
    playerid text,
    yearid int,
    ab int,
    batting_avg decimal,
    bb int,
    cs int,
    doubles int,
    games int,
    gidp int,
    hbp int,
    hits int,
    hr int,
    ibb int,
    lgid text,
    obp decimal,
    ops decimal,
    ops_plus decimal,
    rbi int,
    runs int,
    sb int,
    sf int,
    sh int,
    slg decimal,
    so int,
    stint int,
    teamid text,
    triples int,
    PRIMARY KEY (playerid, yearid)
) WITH CLUSTERING ORDER BY (yearid ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND VERTEX LABEL player_yearly_hitting_vtx;

CREATE TABLE ks_baseball.parks (
    parkid text PRIMARY KEY,
    city text,
    country text,
    parkname text,
    state text
) WITH additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND VERTEX LABEL park_info_vtx;

CREATE TABLE ks_baseball.teams (
    teamid text,
    yearid text,
    ab int,
    attendance int,
    bb int,
    bba int,
    bfe int,
    cg int,
    cs int,
    divid text,
    divwin text,
    doubles int,
    dp int,
    e int,
    er int,
    era decimal,
    fp decimal,
    franchid text,
    games int,
    ha int,
    hbp int,
    hits int,
    home_games int,
    hr int,
    hra int,
    ipouts int,
    lgid text,
    lginw text,
    loses int,
    name text,
    park text,
    ppf int,
    rank int,
    runs int,
    runs_allowed int,
    sb int,
    sf int,
    sho int,
    so int,
    soa int,
    sv int,
    teamidbr text,
    teamidlahman45 text,
    teamidretro text,
    triples int,
    wcwin text,
    wins int,
    wswin text,
    PRIMARY KEY (teamid, yearid)
) WITH CLUSTERING ORDER BY (yearid ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND VERTEX LABEL team_yearly_info_vtx;

CREATE TABLE ks_baseball.player_batting_post_season_by_year (
    playerid text,
    yearid int,
    round text,
    ab int,
    batting_avg decimal,
    bb int,
    cs int,
    doubles int,
    games int,
    gidp int,
    hbp int,
    hits int,
    hr int,
    ibb int,
    lgid text,
    obp decimal,
    ops decimal,
    ops_plus decimal,
    rbi int,
    runs int,
    sb int,
    sf int,
    sh int,
    slg decimal,
    so int,
    teamid text,
    triples int,
    PRIMARY KEY (playerid, yearid, round)
) WITH CLUSTERING ORDER BY (yearid ASC, round ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND VERTEX LABEL player_post_season_hitting_vtx;

CREATE TABLE ks_baseball.player_info_vtx__played_for__team_yearly_info_vtx (
    player_info_vtx_playerid text,
    team_yearly_info_vtx_teamid text,
    team_yearly_info_vtx_yearid text,
    PRIMARY KEY (player_info_vtx_playerid, team_yearly_info_vtx_teamid, team_yearly_info_vtx_yearid)
) WITH CLUSTERING ORDER BY (team_yearly_info_vtx_teamid ASC, team_yearly_info_vtx_yearid ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND EDGE LABEL played_for FROM player_info_vtx(player_info_vtx_playerid) TO team_yearly_info_vtx(team_yearly_info_vtx_teamid, team_yearly_info_vtx_yearid);

CREATE TABLE ks_baseball.player_info_vtx__batted_season__player_yearly_hitting_vtx (
    player_info_vtx_playerid text,
    player_yearly_hitting_vtx_playerid text,
    player_yearly_hitting_vtx_yearid int,
    PRIMARY KEY (player_info_vtx_playerid, player_yearly_hitting_vtx_playerid, player_yearly_hitting_vtx_yearid)
) WITH CLUSTERING ORDER BY (player_yearly_hitting_vtx_playerid ASC, player_yearly_hitting_vtx_yearid ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND EDGE LABEL batted_season FROM player_info_vtx(player_info_vtx_playerid) TO player_yearly_hitting_vtx(player_yearly_hitting_vtx_playerid, player_yearly_hitting_vtx_yearid);

CREATE TABLE ks_baseball.player_info_vtx__pitched_by_season__player_yearly_pitching_vtx (
    player_info_vtx_playerid text,
    player_yearly_pitching_vtx_playerid text,
    player_yearly_pitching_vtx_yearid int,
    PRIMARY KEY (player_info_vtx_playerid, player_yearly_pitching_vtx_playerid, player_yearly_pitching_vtx_yearid)
) WITH CLUSTERING ORDER BY (player_yearly_pitching_vtx_playerid ASC, player_yearly_pitching_vtx_yearid ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND EDGE LABEL pitched_by_season FROM player_info_vtx(player_info_vtx_playerid) TO player_yearly_pitching_vtx(player_yearly_pitching_vtx_playerid, player_yearly_pitching_vtx_yearid);

CREATE TABLE ks_baseball.player_info_vtx__batted_post_season__player_post_season_hitting_vtx (
    player_info_vtx_playerid text,
    player_post_season_hitting_vtx_playerid text,
    player_post_season_hitting_vtx_yearid int,
    player_post_season_hitting_vtx_round text,
    PRIMARY KEY (player_info_vtx_playerid, player_post_season_hitting_vtx_playerid, player_post_season_hitting_vtx_yearid, player_post_season_hitting_vtx_round)
) WITH CLUSTERING ORDER BY (player_post_season_hitting_vtx_playerid ASC, player_post_season_hitting_vtx_yearid ASC, player_post_season_hitting_vtx_round ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE' AND EDGE LABEL batted_post_season FROM player_info_vtx(player_info_vtx_playerid) TO player_post_season_hitting_vtx(player_post_season_hitting_vtx_playerid, player_post_season_hitting_vtx_yearid, player_post_season_hitting_vtx_round);