INSERT INTO sets (name, img_path)
VALUES
('Cobble & Fog', 'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/cover_ru.jpg'),
('Battle of Legends, Volume One', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/cover_ru.jpg'),
('Battle of Legends, Volume Two', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends2/cover_eng.jpg'),
('Robin Hood VS Bigfoot', 'qrc:/qt/qml/Tracker/ui/assets/img/set/robin_hood_vs_bigfoot/cover_ru.jpg')
ON CONFLICT(name) DO UPDATE SET
    img_path = excluded.img_path;

INSERT INTO heroes (name, set_id, img_path)
VALUES
(
    'Dracula',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/heroes/dracula/avatar.webp'
),
(
    'Sherlock Holmes',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/heroes/sherlock_holmes/avatar.webp'
),
(
    'Jekyll & Hyde',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/heroes/jekyll_hyde/avatar.webp'
),
(
    'Invisible man',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/heroes/invisible_man/avatar.webp'
),
(
    'Medusa',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/medusa/avatar.webp'
),
(
    'Sinbad',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/avatar.webp'
),
(
    'King Arthur',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/king_arthur/avatar.webp'
),
(
    'Alice',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/alice/avatar.webp'
)
ON CONFLICT(name) DO UPDATE SET
    set_id = excluded.set_id,
    img_path = excluded.img_path;