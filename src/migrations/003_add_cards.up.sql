INSERT INTO card_types (id, name)
VALUES
(
    1, 'attack'
),
(
    2, 'defense'
),
(
    3, 'versatile'
),
(
    4, 'scheme'
) ON CONFLICT(name) DO UPDATE SET
    id = excluded.id;

ALTER TABLE cards ADD COLUMN card_type_id INTEGER REFERENCES card_types(id);

INSERT INTO cards (name, count, img_path, hero_id, card_type_id)
VALUES
-- Battle of Legends: Tom 1
-- Sinbad
(
    'Commanding Impact',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'By Fortune and Fate',
    3,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Cannibals With the Root of Madness',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Creature With Eyes Like Coals of Fire',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the City of the King of Serendib',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Valley of the Giant Snakes',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage Home',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the City of the Man-Eating Apes',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Island That Was a Whale',
    1,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Exploit',
    2,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Leap Away',
    2,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Momentous Shift',
    3,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/12.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Toil and Danger',
    4,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/13.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Feint',
    3,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/14.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Regroup',
    3,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/15.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Riches Beyond Compare',
    2,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/16.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    4
),
-- Medusa
(
    'Second Shot',
    3,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/medusa/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    1
),
(
    'Gaze of Stone',
    3,
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/medusa/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    1
)
ON CONFLICT (hero_id, name) DO UPDATE SET
    name = excluded.name,
    count = excluded.count,
    img_path = excluded.img_path,
    hero_id = excluded.hero_id,
    card_type_id = excluded.card_type_id;
