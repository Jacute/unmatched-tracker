INSERT INTO sets (name, img_path, released_at)
VALUES
('Battle of Legends, Volume One', '/img/set/battle_of_legends1/cover.jpg', '2019-09-01'),
('Bruce Lee', '/img/set/bruce_lee/cover.jpg', '2019-10-01'),
('Robin Hood vs Bigfoot', '/img/set/robin_hood_vs_bigfoot/cover.jpg', '2019-10-01'),
('Jurassic Park - Ingen vs Raptors', '/img/set/jurassic_park_ingen_vs_raptors/cover.webp', '2020-04-01'),
('Cobble & Fog', '/img/set/cobble_fog/cover.jpg', '2020-07-01'),
('Buffy the Vampire Slayer', '/img/set/buffy_the_vampire_slayer/cover.jpg', '2020-10-01'),
('Little Red Riding Hood vs Beowulf', '/img/set/little_red_riding_hood_vs_beowulf/cover.jpg', '2020-12-01'),
('Deadpool', '/img/set/deadpool/cover.jpg', '2021-07-01'),
('Battle of Legends, Volume Two', '/img/set/battle_of_legends2/cover.jpg', '2022-01-01'),
('Hell''s Kitchen', '/img/set/hells_kitchen/cover.webp', '2022-04-01'),
('Redemption Row', '/img/set/redemption_row/cover.webp', '2022-04-01'),
('Jurassic Park - Sattler vs T-Rex', '/img/set/jurassic_park_settler_vs_trex/cover.jpg', '2022-05-01'),
('Houdini vs The Genie', '/img/set/houdini_vs_the_genie/cover.jpg', '2022-12-01'),
('Teen Spirit', '/img/set/teen_spirit/cover.webp', '2023-03-01'),
('For King and Country', '/img/set/for_king_and_country/cover.jpg', '2023-04-01'),
('Brains and Brawn', '/img/set/brains_and_brawn/cover.webp', '2023-06-01'),
('Adventures: Tales to Amaze', '/img/set/adventures/tales_to_amaze/cover.jpg', '2023-08-01'),
('Sun''s Origin', '/img/set/suns_origin/cover.webp', '2024-01-01'),
('Slings and Arrows', '/img/set/slings_and_arrows/cover.jpg', '2024-03-01'),
('The Witcher - Steel & Silver', '/img/set/the_witcher_steel_silver/cover.webp', '2024-12-01'),
('The Witcher - Realms Fall', '/img/set/the_witcher_realms_fall/cover.jpg', '2024-12-01'),
('Battle of Legends, Volume Three', '/img/set/battle_of_legends3/cover.jpg', '2025-07-01'),
('Adventures: Teenage Mutant Ninja Turtles', '/img/set/adventures/teenage_mutant_ninja_turtles/cover.webp', '2025-09-01'),
('TMNT: Shredder vs Krang', '/img/set/tmnt_shredder_vs_crang/cover.jpg', '2025-09-01'),
('Muhammad Ali vs Bruce Lee', '/img/set/muhammad_ali_vs_bruce_lee/cover.jpg', '2025-10-01'),
('Stars and Stripes', '/img/set/stars_and_stripes/cover.webp', '2026-03-01')
ON CONFLICT(name) DO UPDATE SET
    img_path = excluded.img_path;

INSERT INTO heroes (name, hp, move, set_id, img_path)
VALUES
-- Battle of Legends, Volume One
(
    'Medusa',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    '/img/set/battle_of_legends1/heroes/medusa/avatar.webp'
),
(
    'Sinbad',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    '/img/set/battle_of_legends1/heroes/sinbad/avatar.webp'
),
(
    'King Arthur',
    18,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    '/img/set/battle_of_legends1/heroes/king_arthur/avatar.webp'
),
(
    'Alice',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    '/img/set/battle_of_legends1/heroes/alice/avatar.webp'
),
-- Cobble & Fog
(
    'Dracula',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    '/img/set/cobble_fog/heroes/dracula/avatar.webp'
),
(
    'Sherlock Holmes',
    16,
    2,
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    '/img/set/cobble_fog/heroes/sherlock_holmes/avatar.webp'
),
(
    'Jekyll & Hyde',
    16,
    2,
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    '/img/set/cobble_fog/heroes/jekyll_hyde/avatar.webp'
),
(
    'Invisible man',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    '/img/set/cobble_fog/heroes/invisible_man/avatar.webp'
),
-- The Witcher - Steel & Silver
(
    'Geralt of Rivia',
    16,
    2,
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/avatar.webp'
),
(
    'Ciri',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    '/img/set/the_witcher_steel_silver/heroes/ciri/avatar.webp'
),
(
    'Ancient Leshen',
    13,
    1,
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/avatar.webp'
),
-- The Witcher - Realms Fall
(
    'Philippa',
    12,
    2,
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    '/img/set/the_witcher_realms_fall/heroes/philippa/avatar.webp'
),
(
    'Yennefer & Triss',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    '/img/set/the_witcher_realms_fall/heroes/yen/avatar.webp'
),
(
    'Eredin',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    '/img/set/the_witcher_realms_fall/heroes/eredin/avatar.webp'
),
-- TMNT
(
    'Raphael',
    17,
    2,
    (SELECT id FROM sets WHERE name = 'Adventures: Teenage Mutant Ninja Turtles'),
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/avatar.webp'
),
(
    'Michelangelo',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Adventures: Teenage Mutant Ninja Turtles'),
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/avatar.webp'
),
(
    'Leonardo',
    16,
    2,
    (SELECT id FROM sets WHERE name = 'Adventures: Teenage Mutant Ninja Turtles'),
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/avatar.webp'
),
(
    'Donatello',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Adventures: Teenage Mutant Ninja Turtles'),
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/avatar.webp'
),
-- Robin Hood VS Big Foot
(
    'Bigfoot',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Robin Hood vs Bigfoot'),
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/avatar.webp'
),
(
    'Robin Hood',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Robin Hood vs Bigfoot'),
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/avatar.webp'
),
(
    'Robert Muldoon',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Jurassic Park - Ingen vs Raptors'),
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/avatar.webp'
),
(
    'Raptors',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Jurassic Park - Ingen vs Raptors'),
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/avatar.webp'
),
-- Bruce Lee VS Muhammad Ali
(
    'Bruce Lee',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Muhammad Ali vs Bruce Lee'),
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/avatar.webp'
),
(
    'Muhammad Ali',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Muhammad Ali vs Bruce Lee'),
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/avatar.webp'
),
-- Buffy the Vampire Slayer
(
    'Spike',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Buffy the Vampire Slayer'),
    '/img/set/buffy_the_vampire_slayer/heroes/spike/avatar.webp'
),
(
    'Angel',
    16,
    2,
    (SELECT id FROM sets WHERE name = 'Buffy the Vampire Slayer'),
    '/img/set/buffy_the_vampire_slayer/heroes/angel/avatar.webp'
),
(
    'Willow',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Buffy the Vampire Slayer'),
    '/img/set/buffy_the_vampire_slayer/heroes/willow/avatar.webp'
),
(
    'Buffy',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Buffy the Vampire Slayer'),
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/avatar.webp'
),
-- Little Red Riding Hood vs. Beowulf
(
    'Beowulf',
    17,
    2,
    (SELECT id FROM sets WHERE name = 'Little Red Riding Hood vs Beowulf'),
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/avatar.webp'
),
(
    'Little Red',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Little Red Riding Hood vs Beowulf'),
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/avatar.webp'
),
-- Deadpool
(
    'Deadpool',
    10,
    2,
    (SELECT id FROM sets WHERE name = 'Deadpool'),
    '/img/set/deadpool/heroes/deadpool/avatar.webp'
),
-- Battle of Legends, Volume Two
(
    'Yennenga',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Two'),
    '/img/set/battle_of_legends2/heroes/yennenga/avatar.webp'
),
(
    'Achilles',
    18,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Two'),
    '/img/set/battle_of_legends2/heroes/achilles/avatar.webp'
),
(
    'Bloody Mary',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Two'),
    '/img/set/battle_of_legends2/heroes/bloody_mary/avatar.webp'
),
(
    'Sun Wukong',
    17,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Two'),
    '/img/set/battle_of_legends2/heroes/sun_wukong/avatar.webp'
),
-- Hell's Kitchen
(
    'Bullseye',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Hell''s Kitchen'),
    '/img/set/hells_kitchen/heroes/bullseye/avatar.webp'
),
(
    'Daredevil',
    17,
    3,
    (SELECT id FROM sets WHERE name = 'Hell''s Kitchen'),
    '/img/set/hells_kitchen/heroes/daredevil/avatar.webp'
),
(
    'Elektra',
    7,
    2,
    (SELECT id FROM sets WHERE name = 'Hell''s Kitchen'),
    '/img/set/hells_kitchen/heroes/elektra/avatar.webp'
),
-- Redemption Row
(
    'Moon Knight',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Redemption Row'),
    '/img/set/redemption_row/heroes/moon_knight/avatar.webp'
),
(
    'Ghost Rider',
    17,
    2,
    (SELECT id FROM sets WHERE name = 'Redemption Row'),
    '/img/set/redemption_row/heroes/ghost_rider/avatar.webp'
),
(
    'Luke Cage',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Redemption Row'),
    '/img/set/redemption_row/heroes/luke_cage/avatar.webp'
),
-- Jurassic Park - Sattler vs T-Rex
(
    'Dr. Sattler',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Jurassic Park - Sattler vs T-Rex'),
    '/img/set/redemption_row/heroes/dr_sattler/avatar.webp'
),
(
    'T. Rex',
    27,
    1,
    (SELECT id FROM sets WHERE name = 'Jurassic Park - Sattler vs T-Rex'),
    '/img/set/redemption_row/heroes/trex/avatar.webp'
),
-- Houdini vs The Genie
(
    'The Genie',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Houdini vs The Genie'),
    '/img/set/houdini_vs_the_genie/heroes/the_genie/avatar.webp'
),
(
    'Houdini',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Houdini vs The Genie'),
    '/img/set/houdini_vs_the_genie/heroes/houdini/avatar.webp'
),
-- Teen Spirit
(
    'Cloak Dagger',
    16,
    2,
    (SELECT id FROM sets WHERE name = 'Teen Spirit'),
    '/img/set/teen_spirit/heroes/cloak_dagger/avatar.webp'
),
(
    'Squirrel Girl',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Teen Spirit'),
    '/img/set/teen_spirit/heroes/squirrel_girl/avatar.webp'
),
(
    'Ms. Marvel',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Teen Spirit'),
    '/img/set/teen_spirit/heroes/ms_marvel/avatar.webp'
),
(
    'Black Widow',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'For King and Country'),
    '/img/set/for_king_and_country/heroes/black_widow/avatar.webp'
),
(
    'Black Panther',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'For King and Country'),
    '/img/set/for_king_and_country/heroes/black_panther/avatar.webp'
),
(
    'Winter Soldier',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'For King and Country'),
    '/img/set/for_king_and_country/heroes/winter_soldier/avatar.webp'
),
-- Stars and Stripes
(
    'George Washington',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Stars and Stripes'),
    '/img/set/stars_and_stripes/heroes/washington/avatar.webp'
),
(
    'Wyatt Earp',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Stars and Stripes'),
    '/img/set/stars_and_stripes/heroes/wyatt_earp/avatar.webp'
),
(
    'John Henry',
    17,
    2,
    (SELECT id FROM sets WHERE name = 'Stars and Stripes'),
    '/img/set/stars_and_stripes/heroes/john_henry/avatar.webp'
),
(
    'Rosie The Riveter',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Stars and Stripes'),
    '/img/set/stars_and_stripes/heroes/rosie/avatar.webp'
),
-- Muhammad Ali vs Bruce Lee
(
    'Muhammad Ali',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Muhammad Ali vs Bruce Lee'),
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/avatar.webp'
),
(
    'Bruce Lee',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Muhammad Ali vs Bruce Lee'),
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/avatar.webp'
),
(
    'Shredder',
    15,
    3,
    (SELECT id FROM sets WHERE name = 'TMNT: Shredder vs Krang'),
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/avatar.webp'
),
(
    'Krang',
    16,
    1,
    (SELECT id FROM sets WHERE name = 'TMNT: Shredder vs Krang'),
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/avatar.webp'
),
-- Battle of Legends, Volume Three
(
    'Chupacabra',
    14,
    3,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Three'),
    '/img/set/battle_of_legends3/heroes/chupacabra/avatar.webp'
),
(
    'Blackbeard',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Three'),
    '/img/set/battle_of_legends3/heroes/blackbeard/avatar.webp'
),
(
    'Pandora',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Three'),
    '/img/set/battle_of_legends3/heroes/pandora/avatar.webp'
),
(
    'Loki',
    16,
    3,
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Three'),
    '/img/set/battle_of_legends3/heroes/loki/avatar.webp'
),
-- Slings and Arrows
(
    'Shakespeare',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Slings and Arrows'),
    '/img/set/slings_and_arrows/heroes/shakespeare/avatar.webp'
),
(
    'Titania',
    12,
    2,
    (SELECT id FROM sets WHERE name = 'Slings and Arrows'),
    '/img/set/slings_and_arrows/heroes/titania/avatar.webp'
),
(
    'The Wayward Sisters',
    18,
    2,
    (SELECT id FROM sets WHERE name = 'Slings and Arrows'),
    '/img/set/slings_and_arrows/heroes/sisters/avatar.webp'
),
(
    'Hamlet',
    15,
    2,
    (SELECT id FROM sets WHERE name = 'Slings and Arrows'),
    '/img/set/slings_and_arrows/heroes/hamlet/avatar.webp'
),
-- Sun's Origin
(
    'Tomoe Gozen',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Sun''s Origin'),
    '/img/set/suns_origin/heroes/tomoe/avatar.webp'
),
(
    'Oda Nobunaga',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Sun''s Origin'),
    '/img/set/suns_origin/heroes/oda/avatar.webp'
),
-- Adventures: Tales to Amaze
(
    'Golden Bat',
    18,
    3,
    (SELECT id FROM sets WHERE name = 'Adventures: Tales to Amaze'),
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/avatar.webp'
),
(
    'Annie Christmas',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Adventures: Tales to Amaze'),
    '/img/set/adventures/tales_to_amaze/heroes/annie/avatar.webp'
),
(
    'Dr. Jill Trent',
    13,
    2,
    (SELECT id FROM sets WHERE name = 'Adventures: Tales to Amaze'),
    '/img/set/adventures/tales_to_amaze/heroes/jill/avatar.webp'
),
(
    'Nikola Tesla',
    14,
    2,
    (SELECT id FROM sets WHERE name = 'Adventures: Tales to Amaze'),
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/avatar.webp'
)
ON CONFLICT(name) DO UPDATE SET
    set_id = excluded.set_id,
    img_path = excluded.img_path;

INSERT INTO maps (name, set_id, img_path)
VALUES
-- Battle of Legends, Volume One
(
    'Marmoreal',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    '/img/set/battle_of_legends1/maps/marmoreal.webp' 
),
(
    'Sarpedon',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume One'),
    '/img/set/battle_of_legends1/maps/sarpedon.webp' 
),
-- Cobble & Fog
(
    'Baskerville Manor',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    '/img/set/cobble_fog/maps/baskerville_manor.webp' 
),
(
    'Soho',
    (SELECT id FROM sets WHERE name = 'Cobble & Fog'),
    '/img/set/cobble_fog/maps/soho.webp' 
),
-- Robin Hood VS Bigfoot
(
    'Sherwood Forest',
    (SELECT id FROM sets WHERE name = 'Robin Hood VS Bigfoot'),
    '/img/set/robin_hood_vs_bigfoot/maps/sherwood_forest.webp' 
),
(
    'Yukon',
    (SELECT id FROM sets WHERE name = 'Robin Hood VS Bigfoot'),
    '/img/set/robin_hood_vs_bigfoot/maps/yukon.webp' 
),
-- Battle of Legends, Volume Two
(
    'Hanging Gardens',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Two'),
    '/img/set/battle_of_legends2/maps/hanging_gardens.webp' 
),
-- The Witcher - Steel & Silver
(
    'Kaer Morhen',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    '/img/set/the_witcher_steel_silver/maps/kaer_morhen.webp' 
),
(
    'Fayrlund Forest',
    (SELECT id FROM sets WHERE name = 'The Witcher - Steel & Silver'),
    '/img/set/the_witcher_steel_silver/maps/fayrlund_forest.webp' 
),
-- The Witcher - Realms Fall
(
    'Streets of Novigrad',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    '/img/set/the_witcher_realms_fall/maps/streets_of_novigrad.webp' 
),
(
    'Naglfar',
    (SELECT id FROM sets WHERE name = 'The Witcher - Realms Fall'),
    '/img/set/the_witcher_realms_fall/maps/naglfar.webp' 
),
(
    'Raptor Paddock',
    (SELECT id FROM sets WHERE name = 'Jurassic Park - Ingen vs Raptors'),
    '/img/set/jurassic_park_ingen_vs_raptors/maps/raptor_paddock.webp' 
),
(
    'Sunnydale High',
    (SELECT id FROM sets WHERE name = 'Buffy the Vampire Slayer'),
    '/img/set/buffy_the_vampire_slayer/maps/sunnydale_high.webp'
),
(
    'The Bronze',
    (SELECT id FROM sets WHERE name = 'Buffy the Vampire Slayer'),
    '/img/set/buffy_the_vampire_slayer/maps/the_bronze.webp'
),
(
    'Heorot',
    (SELECT id FROM sets WHERE name = 'Little Red Riding Hood vs Beowulf'),
    '/img/set/little_red_riding_hood_vs_beowulf/maps/heorot.webp'
),
(
    'Hell''s Kitchen',
    (SELECT id FROM sets WHERE name = 'Hell''s Kitchen'),
    '/img/set/hells_kitchen/maps/hells_kitchen.webp'
),
(
    'The Raft',
    (SELECT id FROM sets WHERE name = 'Redemption Row'),
    '/img/set/redemption_row/maps/the_raft.webp'
),
(
    'T. Rex Paddock',
    (SELECT id FROM sets WHERE name = 'Jurassic Park - Sattler vs T-Rex'),
    '/img/set/jurassic_park_settler_vs_trex/maps/trex_paddock.webp'
),
(
    'King Solomon''s Mine',
    (SELECT id FROM sets WHERE name = 'Houdini vs The Genie'),
    '/img/set/houdini_vs_the_genie/maps/king_solomons_mine.webp'
),
(
    'Navy Pier',
    (SELECT id FROM sets WHERE name = 'Teen Spirit'),
    '/img/set/teen_spirit/maps/navy_pier.webp'
),
(
    'Helicarrier',
    (SELECT id FROM sets WHERE name = 'For King and Country'),
    '/img/set/for_king_and_country/maps/helicarrier.webp'
),
(
    'Sanctum Sanctorum',
    (SELECT id FROM sets WHERE name = 'Brains and Brawn'),
    '/img/set/brains_and_brawn/maps/sanctum_sanctorum.webp'
),
(
    'McMinnville OR',
    (SELECT id FROM sets WHERE name = 'Adventures: Tales to Amaze'),
    '/img/set/adventures/tales_to_amaze/maps/mcminnville_or.webp'
),
(
    'Point Pleasant',
    (SELECT id FROM sets WHERE name = 'Adventures: Tales to Amaze'),
    '/img/set/adventures/tales_to_amaze/maps/point_pleasant.webp'
),
(
    'Azuchi Castle',
    (SELECT id FROM sets WHERE name = 'Sun''s Origin'),
    '/img/set/suns_origin/maps/azuchi_castle.webp'
),
(
    'Globe Theatre',
    (SELECT id FROM sets WHERE name = 'Slings and Arrows'),
    '/img/set/slings_and_arrows/maps/globe_theatre.webp'
),
(
    'Venice',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Three'),
    '/img/set/battle_of_legends3/maps/venice.webp'
),
(
    'Santa''s Workshop',
    (SELECT id FROM sets WHERE name = 'Battle of Legends, Volume Three'),
    '/img/set/battle_of_legends3/maps/santas_workshop.webp'
),
(
    'Technodrome',
    (SELECT id FROM sets WHERE name = 'Adventures: Teenage Mutant Ninja Turtles'),
    '/img/set/adventures/teenage_mutant_ninja_turtles/maps/technodrome.webp'
),
(
    'New York City',
    (SELECT id FROM sets WHERE name = 'Adventures: Teenage Mutant Ninja Turtles'),
    '/img/set/adventures/teenage_mutant_ninja_turtles/maps/new_york_city.webp'
),
(
    'Thrilla In Manilla',
    (SELECT id FROM sets WHERE name = 'Muhammad Ali vs Bruce Lee'),
    '/img/set/muhammad_ali_vs_bruce_lee/maps/thrilla_in_manilla.webp'
),
(
    'Tsing Shan Monastery',
    (SELECT id FROM sets WHERE name = 'Muhammad Ali vs Bruce Lee'),
    '/img/set/muhammad_ali_vs_bruce_lee/maps/tsing_shan_monastery.webp'
),
(
    'The Alamo',
    (SELECT id FROM sets WHERE name = 'Stars and Stripes'),
    '/img/set/stars_and_stripes/maps/the_alamo.webp'
),
(
    'The White House',
    (SELECT id FROM sets WHERE name = 'Stars and Stripes'),
    '/img/set/stars_and_stripes/maps/the_white_house.webp'
)
ON CONFLICT (name) DO UPDATE SET
    set_id = excluded.set_id,
    img_path = excluded.img_path;
