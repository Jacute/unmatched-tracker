INSERT INTO sets (name, img_path)
VALUES
('Cobble & Fog', 'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/cover_ru.jpg'),
('Battle of Legends, Volume One', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/cover_ru.jpg'),
('Battle of Legends, Volume Two', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends2/cover_eng.jpg'),
('Robin Hood VS Bigfoot', 'qrc:/qt/qml/Tracker/ui/assets/img/set/robin_hood_vs_bigfoot/cover_ru.jpg'),
('The Witcher - Steel & Silver', 'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/cover_eng.webp'),
('The Witcher - Realms Fall', 'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fail/cover_eng.jpg')
ON CONFLICT(name) DO UPDATE SET
    img_path = excluded.img_path;

INSERT INTO heroes (name, set_id, img_path)
VALUES
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
),
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
    'Geralt of Rivia',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/avatar.webp'
),
(
    'Ciri',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/heroes/ciri/avatar.webp'
),
(
    'Ancient Leshen',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/heroes/ancient_leshen/avatar.webp'
),
(
    'Philippa',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fall/heroes/philippa/avatar.webp'
),
(
    'Yennefer & Triss',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fall/heroes/yen/avatar.webp'
),
(
    'Eredin',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fall/heroes/eredin/avatar.webp'
)
ON CONFLICT(name) DO UPDATE SET
    set_id = excluded.set_id,
    img_path = excluded.img_path;

INSERT INTO maps (name, set_id, img_path)
VALUES
(
    'Marmoreal',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/maps/marmoreal.webp' 
),
(
    'Sarpedon',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/maps/sarpedon.webp' 
),
(
    'Baskerville Manor',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/maps/baskerville_manor.webp' 
),
(
    'Soho',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/maps/soho.webp' 
),
(
    'Sherwood Forest',
    (SELECT id FROM sets WHERE name = 'Robin Hood VS Bigfoot'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/robin_hood_vs_bigfoot/maps/sherwood_forest.webp' 
),
(
    'Yukon',
    (SELECT id FROM sets WHERE name = 'Robin Hood VS Bigfoot'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/robin_hood_vs_bigfoot/maps/yukon.webp' 
),
(
    'Hanging Gardens',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends2/maps/hanging_gardens.webp' 
),
(
    'Kaer Morhen',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/maps/kaer_morhen.webp' 
),
(
    'Fayrlund Forest',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/maps/fayrlund_forest.webp' 
),
(
    'Streets of Novigrad',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fall/maps/streets_of_novigrad.webp' 
),
(
    'Naglfar',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fall/maps/naglfar.webp' 
)
ON CONFLICT(name) DO UPDATE SET
    set_id = excluded.set_id,
    img_path = excluded.img_path;