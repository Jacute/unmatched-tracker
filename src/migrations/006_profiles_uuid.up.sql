ALTER TABLE player_profiles RENAME TO player_profiles_legacy;

CREATE TEMP TABLE profile_uuid_map (
    old_id INTEGER PRIMARY KEY,
    new_id TEXT NOT NULL UNIQUE
);

INSERT INTO profile_uuid_map (old_id, new_id)
SELECT
    id,
    lower(hex(randomblob(4))) || '-' ||
    lower(hex(randomblob(2))) || '-' ||
    '4' || substr(lower(hex(randomblob(2))), 2) || '-' ||
    substr('89ab', 1 + abs(random() % 4), 1) ||
    substr(lower(hex(randomblob(2))), 2) || '-' ||
    lower(hex(randomblob(6)))
FROM player_profiles_legacy;

CREATE TABLE player_profiles (
    id TEXT PRIMARY KEY CHECK(
        length(id) = 36 AND
        substr(id, 9, 1) = '-' AND
        substr(id, 14, 1) = '-' AND
        substr(id, 19, 1) = '-' AND
        substr(id, 24, 1) = '-'
    ),
    name VARCHAR(256) NOT NULL UNIQUE,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO player_profiles (id, name, created_at)
SELECT id_map.new_id, profiles.name, profiles.created_at
FROM player_profiles_legacy AS profiles
JOIN profile_uuid_map AS id_map ON id_map.old_id = profiles.id;

CREATE TABLE game_record_participants_uuid (
    game_id TEXT NOT NULL REFERENCES game_records(id) ON DELETE CASCADE,
    position INTEGER NOT NULL CHECK(position > 0),
    team INTEGER NOT NULL CHECK(team > 0),
    profile_id TEXT NOT NULL REFERENCES player_profiles(id),
    hero_id INTEGER REFERENCES heroes(id),
    hero_remaining_hp INTEGER CHECK(hero_remaining_hp >= 0),
    PRIMARY KEY (game_id, position),
    UNIQUE (game_id, profile_id)
);

INSERT INTO game_record_participants_uuid (
    game_id,
    position,
    team,
    profile_id,
    hero_id,
    hero_remaining_hp
)
SELECT
    participants.game_id,
    participants.position,
    participants.team,
    id_map.new_id,
    participants.hero_id,
    participants.hero_remaining_hp
FROM game_record_participants AS participants
JOIN profile_uuid_map AS id_map ON id_map.old_id = participants.profile_id;

DROP TABLE game_record_participants;
DROP TABLE player_profiles_legacy;

ALTER TABLE game_record_participants_uuid RENAME TO game_record_participants;

CREATE INDEX game_record_participants_profile_idx
    ON game_record_participants(profile_id);

DROP TABLE profile_uuid_map;
