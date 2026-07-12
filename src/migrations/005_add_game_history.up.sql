CREATE TABLE game_modes (
    code TEXT PRIMARY KEY,
    player_count INTEGER NOT NULL CHECK(player_count BETWEEN 2 AND 4),
    team_count INTEGER NOT NULL CHECK(team_count BETWEEN 2 AND player_count)
);

INSERT INTO game_modes (code, player_count, team_count) VALUES
    ('1v1', 2, 2),
    ('1v1v1', 3, 3),
    ('1v1v1v1', 4, 4),
    ('2v2', 4, 2);

CREATE TABLE game_records (
    id TEXT PRIMARY KEY,
    mode TEXT NOT NULL REFERENCES game_modes(code),
    map_id INTEGER REFERENCES maps(id),
    winning_team INTEGER NOT NULL CHECK(winning_team > 0),
    played_at TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE game_record_participants (
    game_id TEXT NOT NULL REFERENCES game_records(id) ON DELETE CASCADE,
    position INTEGER NOT NULL CHECK(position > 0),
    team INTEGER NOT NULL CHECK(team > 0),
    profile_id INTEGER NOT NULL REFERENCES player_profiles(id),
    hero_id INTEGER REFERENCES heroes(id),
    hero_remaining_hp INTEGER CHECK(hero_remaining_hp >= 0),
    PRIMARY KEY (game_id, position),
    UNIQUE (game_id, profile_id)
);

CREATE INDEX game_records_created_at_idx ON game_records(created_at DESC);
CREATE INDEX game_records_played_at_idx ON game_records(played_at DESC);
CREATE INDEX game_record_participants_profile_idx
    ON game_record_participants(profile_id);
