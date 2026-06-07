INSERT INTO sets (name, img_path, released_at)
VALUES
('Battle of Legends, Volume One', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/cover.jpg', '2019-09-01'),
('Bruce Lee', 'qrc:/qt/qml/Tracker/ui/assets/img/set/bruce_lee/cover.jpg', '2019-10-01'),
('Robin Hood vs Bigfoot', 'qrc:/qt/qml/Tracker/ui/assets/img/set/robin_hood_vs_bigfoot/cover.jpg', '2019-10-01'),
('Jurassic Park - Ingen vs Raptors', 'qrc:/qt/qml/Tracker/ui/assets/img/set/jurassic_park_ingen_vs_raptors/cover.webp', '2020-04-01'),
('Cobble & Fog', 'qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/cover.jpg', '2020-07-01'),
('Buffy the Vampire Slayer', 'qrc:/qt/qml/Tracker/ui/assets/img/set/buffy_the_vampire_slayer/cover.jpg', '2020-10-01'),
('Little Red Riding Hood vs Beowulf', 'qrc:/qt/qml/Tracker/ui/assets/img/set/little_red_riding_hood_vs_beowulf/cover.jpg', '2020-12-01'),
('Deadpool', 'qrc:/qt/qml/Tracker/ui/assets/img/set/deadpool/cover.jpg', '2021-07-01'),
('Battle of Legends, Volume Two', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends2/cover.jpg', '2022-01-01'),
('Hell''s Kitchen', 'qrc:/qt/qml/Tracker/ui/assets/img/set/hells_kitchen/cover.webp', '2022-04-01'),
('Redemption Row', 'qrc:/qt/qml/Tracker/ui/assets/img/set/redemption_row/cover.webp', '2022-04-01'),
('Jurassic Park - Sattler vs T-Rex', 'qrc:/qt/qml/Tracker/ui/assets/img/set/jurassic_park_settler_vs_trex/cover.jpg', '2022-05-01'),
('Houdini vs The Genie', 'qrc:/qt/qml/Tracker/ui/assets/img/set/houdini_vs_the_genie/cover.jpg', '2022-12-01'),
('Teen Spirit', 'qrc:/qt/qml/Tracker/ui/assets/img/set/teen_spirit/cover.webp', '2023-03-01'),
('For King and Country', 'qrc:/qt/qml/Tracker/ui/assets/img/set/for_king_and_country/cover.jpg', '2023-04-01'),
('Brains and Brawn', 'qrc:/qt/qml/Tracker/ui/assets/img/set/brains_and_brawn/cover.webp', '2023-06-01'),
('Adventures: Tales to Amaze', 'qrc:/qt/qml/Tracker/ui/assets/img/set/adventures/tales_to_amaze/cover.jpg', '2023-08-01'),
('Sun''s Origin', 'qrc:/qt/qml/Tracker/ui/assets/img/set/suns_origin/cover.webp', '2024-01-01'),
('Slings and Arrows', 'qrc:/qt/qml/Tracker/ui/assets/img/set/slings_and_arrows/cover.jpg', '2024-03-01'),
('The Witcher - Steel & Silver', 'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_steel_silver/cover.webp', '2024-12-01'),
('The Witcher - Realms Fall', 'qrc:/qt/qml/Tracker/ui/assets/img/set/the_witcher_realms_fall/cover.jpg', '2024-12-01'),
('Battle of Legends, Volume Three', 'qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends3/cover.jpg', '2025-07-01'),
('Adventures: Teenage Mutant Ninja Turtles', 'qrc:/qt/qml/Tracker/ui/assets/img/set/adventures/teenage_mutant_ninja_turtles/cover.webp', '2025-09-01'),
('TMNT: Shredder vs Krang', 'qrc:/qt/qml/Tracker/ui/assets/img/set/tmnt_shredder_vs_crang/cover.jpg', '2025-09-01'),
('Muhammad Ali vs Bruce Lee', 'qrc:/qt/qml/Tracker/ui/assets/img/set/muhammad_ali_vs_bruce_lee/cover.jpg', '2025-10-01'),
('Stars and Stripes', 'qrc:/qt/qml/Tracker/ui/assets/img/set/stars_and_stripes/cover.webp', '2026-03-01')
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