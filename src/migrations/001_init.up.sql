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