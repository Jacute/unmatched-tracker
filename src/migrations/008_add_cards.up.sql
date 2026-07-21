ALTER TABLE cards ADD COLUMN boost INTEGER;

INSERT INTO cards (name, count, value, boost, img_path, hero_id, card_type_id)
VALUES
-- Bruce Lee
(
    'Jeet Kune Do: Corkscrew Finger Jab',
    1,
    3,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    1
),
(
    'Jeet Kune Do: Downward Side Kick',
    1,
    3,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    1
),
(
    'Jeet Kune Do: Intercepting Fist',
    1,
    3,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    1
),
(
    'Jeet Kune Do: Wrist Lock',
    1,
    3,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    1
),
(
    'Jeet Kune Do: High Straight Lead',
    1,
    3,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    1
),
(
    'Jeet Kune Do: Short Lead Hook',
    1,
    3,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    1
),
(
    'Skirmish',
    3,
    4,
    1,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    1,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    2
),
(
    'Little Dragon',
    2,
    2,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    2
),
(
    'Regroup',
    3,
    1,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/11.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    2
),
(
    'Be Like Water',
    4,
    3,
    4,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/12.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    3
),
(
    'Taste of Blood',
    1,
    3,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/13.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    3
),
(
    'One-Inch Punch',
    1,
    NULL,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/14.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    4
),
(
    '"HOO! WHAAAAAA!"',
    1,
    NULL,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/15.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    4
),
(
    'Bring It On',
    1,
    NULL,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/16.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    4
),
(
    'Nunchaku',
    2,
    NULL,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/bruce_lee/cards/17.png',
    (SELECT id FROM heroes WHERE name = 'Bruce Lee'),
    4
),
-- Bigfoot
(
    'Larger Than Life',
    3,
    6,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    1
),
(
    'Savagery',
    3,
    4,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    1
),
(
    'Disengage',
    2,
    4,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    1
),
(
    'Hoax',
    3,
    4,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    2
),
(
    'Skirmish',
    3,
    4,
    1,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    1,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    2
),
(
    'Regroup',
    3,
    1,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    2
),
(
    'It''s Just Your Imagination',
    2,
    3,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    3
),
(
    'Jackalope Horns',
    3,
    NULL,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    4
),
(
    'Crash Through the Trees',
    2,
    NULL,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/bigfoot/cards/11.png',
    (SELECT id FROM heroes WHERE name = 'Bigfoot'),
    4
),
-- Robin Hood
(
    'A Hunter''s Eye',
    3,
    5,
    4,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    1
),
(
    'Disarming Shot',
    2,
    4,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    1
),
(
    'Highway Robbery',
    4,
    2,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    1
),
(
    'Ambush',
    2,
    2,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    1
),
(
    'Piercing Shot',
    2,
    2,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    1
),
(
    'Snark',
    3,
    3,
    1,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    2
),
(
    'Wily Fighting',
    3,
    3,
    1,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    2
),
(
    'Regroup',
    3,
    1,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    2
),
(
    'Defenders of Sherwood',
    2,
    3,
    2,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    3
),
(
    'Steal From the Rich',
    3,
    NULL,
    3,
    '/img/set/robin_hood_vs_bigfoot/heroes/robin_hood/cards/11.png',
    (SELECT id FROM heroes WHERE name = 'Robin Hood'),
    4
)
ON CONFLICT (hero_id, name) DO UPDATE SET
    count = excluded.count,
    card_type_id = excluded.card_type_id,
    value = excluded.value,
    boost = excluded.boost,
    img_path = excluded.img_path;