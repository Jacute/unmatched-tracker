ALTER TABLE heroes ADD COLUMN ability TEXT;
ALTER TABLE heroes ADD COLUMN attack_type TEXT; -- 'm' (melee) or 'r' (range)

CREATE TABLE IF NOT EXISTS assistants (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    count INTEGER NOT NULL,
    hp_per_one INTEGER NOT NULL
);

ALTER TABLE heroes ADD COLUMN ability TEXT;

UPDATE heroes SET ability = 'At the start of your turn, you may deal 1 damage to an opposing fighter in Medusa''s zone.';