PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS sets (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    img_path TEXT,
    released_at DATE
);

CREATE TABLE IF NOT EXISTS heroes (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    set_id INTEGER,
    img_path TEXT,
    FOREIGN KEY (set_id) REFERENCES sets(id)
);

CREATE TABLE IF NOT EXISTS maps (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    set_id INTEGER,
    img_path TEXT,
    FOREIGN KEY (set_id) REFERENCES sets(id)
);

CREATE TABLE IF NOT EXISTS card_types (
    id INTEGER UNIQUE,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS cards (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    count INTEGER NOT NULL,
    img_path TEXT,
    hero_id INTEGER,
    FOREIGN KEY (hero_id) REFERENCES heroes(id)
);
ALTER TABLE cards ADD description TEXT;
ALTER TABLE cards ADD UNIQUE(hero_id, name);