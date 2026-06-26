CREATE TABLE IF NOT EXISTS game_records (
    id TEXT PRIMARY KEY,
    player1_profile_id INTEGER NOT NULL REFERENCES player_profiles(id),
    player1_hero_id INTEGER NOT NULL REFERENCES heroes(id),
    player2_profile_id INTEGER NOT NULL REFERENCES player_profiles(id),
    player2_hero_id INTEGER NOT NULL REFERENCES heroes(id),
    map_id INTEGER REFERENCES maps(id),
    player1_won INTEGER NOT NULL CHECK(player1_won IN (0, 1)),
    hero1_remaining_hp INTEGER CHECK(hero1_remaining_hp >= 0),
    hero2_remaining_hp INTEGER CHECK(hero2_remaining_hp >= 0),
    played_at TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
