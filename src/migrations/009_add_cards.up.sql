-- Corrections for data seeded by earlier migrations.
DROP INDEX IF EXISTS cards_hero_name_idx;

CREATE UNIQUE INDEX IF NOT EXISTS cards_hero_name_img_path_idx
ON cards(hero_id, name, img_path);

UPDATE heroes
SET
    ability = 'At the start of the game, after you place Invisible Man, place 3 fog tokens in separate spaces in his zone. When Invisible Man is on a space with a fog token, add 1 to the value of his defense cards. Invisible Man may move between two spaces with fog tokens as if they were adjacent.',
    attack_type = 'm'
WHERE name = 'Invisible man';

UPDATE maps
SET set_id = (SELECT id FROM sets WHERE name = 'Robin Hood vs Bigfoot')
WHERE name IN ('Sherwood Forest', 'Yukon');

UPDATE cards
SET value = 3
WHERE name = 'Education Never Ends'
  AND hero_id = (SELECT id FROM heroes WHERE name = 'Sherlock Holmes');

UPDATE cards
SET img_path = '/img/set/cobble_fog/heroes/dracula/cards/6.webp'
WHERE name = 'Dash'
  AND hero_id = (SELECT id FROM heroes WHERE name = 'Dracula');

UPDATE cards
SET img_path = '/img/set/cobble_fog/heroes/jekyll_hyde/cards/5.webp'
WHERE name = 'Distracted Triage'
  AND hero_id = (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde');

UPDATE cards
SET img_path = '/img/set/cobble_fog/heroes/invisible_man/cards/6.webp'
WHERE name = 'Impossible to See'
  AND hero_id = (SELECT id FROM heroes WHERE name = 'Invisible man');

UPDATE heroes
SET
    ability = 'When you take the maneuver action and BOOST, you may place Houdini in any space instead of moving. (Bess moves as normal.)',
    attack_type = 'm'
WHERE name = 'Houdini';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Bess', 1, 5, 'm'
FROM heroes
WHERE name = 'Houdini';

INSERT INTO cards (name, count, value, boost, img_path, hero_id, card_type_id)
VALUES
-- Muldoon
(
    'They Should All Be Destroyed',
    3,
    4,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    1
),
(
    'Shoot Her!',
    2,
    3,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    1
),
(
    'Rending Shot',
    4,
    3,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    1
),
(
    'Second Shot',
    2,
    2,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    1
),
(
    'Leap Away',
    3,
    4,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    2
),
(
    'Tactical Advance',
    3,
    3,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    2
),
(
    'Regroup',
    3,
    1,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    2
),
(
    'I''ve Hunted Most Things That Can Hunt You',
    2,
    4,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    3
),
(
    'Call for Backup',
    2,
    NULL,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    4
),
(
    'Remote Detonation',
    3,
    NULL,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/robert_muldoon/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Robert Muldoon'),
    4
),
-- Raptors
(
    'Eviscerate',
    2,
    5,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    1
),
(
    'Disengage',
    2,
    4,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    1
),
(
    'Pack Hunters',
    2,
    4,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    1
),
(
    'Clever Girl',
    3,
    3,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    1
),
(
    'They Remember',
    4,
    2,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    1
),
(
    'Ambush',
    3,
    2,
    3,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    1
),
(
    'Eaten Alive',
    3,
    4,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    2
),
(
    'Decoy',
    4,
    3,
    1,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    3
),
(
    'Working Things Out',
    2,
    NULL,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    4
),
(
    'Coordinated Attack Pattern',
    2,
    NULL,
    2,
    '/img/set/jurassic_park_ingen_vs_raptors/heroes/raptors/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Raptors'),
    4
),
-- Spike
(
    'Arrogance',
    1,
    4,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    1
),
(
    'The Rush',
    2,
    3,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    1
),
(
    'Leap Away',
    2,
    4,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Skirmish',
    2,
    4,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Let''s Dance',
    3,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Bloody Hell!',
    3,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Empathy',
    2,
    3,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Always Surprising',
    3,
    1,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'Regroup',
    3,
    1,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    2
),
(
    'The Sight',
    2,
    NULL,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    4
),
(
    'Seek the Shadows',
    4,
    NULL,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/spike/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Spike'),
    4
),
-- Angel
(
    'Angelus, Scourge of Europe',
    3,
    5,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    1
),
(
    'Five by Five',
    2,
    5,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    1
),
(
    'Disengage',
    3,
    4,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    1
),
(
    'Cursed with a Soul',
    2,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    1
),
(
    'Wisdom of Ages',
    2,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    1
),
(
    'Brooding',
    2,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    2
),
(
    'The Rogue Slayer',
    2,
    3,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    2
),
(
    'Regroup',
    3,
    1,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    2
),
(
    'Haunted by the Faces',
    2,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    3
),
(
    'Killer of the Dead',
    3,
    NULL,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/angel/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Angel'),
    4
),
-- Willow
(
    'Flayed Alive',
    3,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    1
),
(
    'When Good Magic Fails',
    2,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    1
),
(
    'Rending Shot',
    2,
    4,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    1
),
(
    'Swift Strike',
    2,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    1
),
(
    'Knowledge of the Craft',
    2,
    4,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    2
),
(
    'Black Magic',
    3,
    3,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    2
),
(
    'Revoke',
    2,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    2
),
(
    'Hacker',
    2,
    2,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    2
),
(
    'Regroup',
    3,
    1,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    2
),
(
    'Meditation',
    2,
    5,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    3
),
(
    'Love & Loss',
    2,
    NULL,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    4
),
(
    'Resurrect',
    2,
    NULL,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/willow/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Willow'),
    4
),
-- Buffy
(
    'Mr. Pointy',
    2,
    5,
    4,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    1
),
(
    'Daring Strike',
    3,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    1
),
(
    'Military Knowledge',
    3,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    1
),
(
    'Swift Strike',
    3,
    3,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    1
),
(
    'Skirmish',
    3,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    2
),
(
    'Slayer''s Strength',
    3,
    4,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    2
),
(
    'Rapid Recovery',
    3,
    3,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    2
),
(
    'Right-hand Man',
    2,
    2,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    2
),
(
    'Regroup',
    3,
    1,
    1,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    2
),
(
    'Cartwheel Kick',
    2,
    2,
    2,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    3
),
(
    'Insight',
    3,
    NULL,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    4
),
(
    'Training',
    2,
    NULL,
    3,
    '/img/set/buffy_the_vampire_slayer/heroes/buffy/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Buffy'),
    4
),
-- Beowulf
(
    'Fatal Struggle',
    3,
    4,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    1
),
(
    'The Ancient Heirloom',
    2,
    3,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    1
),
(
    'Hot for the Battle',
    2,
    3,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    1
),
(
    'No Contest Expecteth',
    2,
    3,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    1
),
(
    'Epic Poem',
    2,
    2,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    1
),
(
    'Skirmish',
    3,
    4,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    2
),
(
    'The War-King',
    3,
    1,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    2
),
(
    'The Equal of Grendel',
    3,
    3,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    3
),
(
    'Remnant of Valor',
    2,
    NULL,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    4
),
(
    'Golden Drinking Horn',
    2,
    NULL,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    4
),
(
    'Vigor and Courage',
    3,
    NULL,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/beowulf/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Beowulf'),
    4
),
-- Little Red
(
    'What Big Ears You Have',
    2,
    4,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    1
),
(
    'Long Have I Sought You',
    3,
    4,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    1
),
(
    'What Large Hands You Have',
    2,
    2,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    1
),
(
    'What''s That In My Basket?',
    4,
    4,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    2
),
(
    'Once Upon a Time',
    2,
    2,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    2
),
(
    'What Big Eyes You Have',
    2,
    3,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    2
),
(
    'Stones in the Belly',
    3,
    2,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    2
),
(
    'The Wolf''s Skin',
    3,
    2,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    3
),
(
    'What a Terrible Big Mouth You Have',
    2,
    2,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    3
),
(
    'Never Leave the Path',
    2,
    NULL,
    1,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    4
),
(
    'A Grimm Tale',
    2,
    NULL,
    3,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    4
),
(
    'Into the Woods',
    3,
    NULL,
    2,
    '/img/set/little_red_riding_hood_vs_beowulf/heroes/little_red/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Little Red'),
    4
),
-- Deadpool
(
    'Underrated Super Heroes',
    1,
    6,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Deadpool™ Merc For Hire, LLC',
    1,
    5,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Rob''s Pouch & Shoe Emporium',
    1,
    4,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Klunkin'' Heads',
    1,
    4,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Xavier Institute Faculty',
    1,
    3,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    '3 of Hearts',
    1,
    3,
    4,
    '/img/set/deadpool/heroes/deadpool/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Excuse me while I grow some limbs.',
    1,
    3,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Wanna bet?',
    1,
    2,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Gaze of Stone',
    1,
    2,
    4,
    '/img/set/deadpool/heroes/deadpool/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Exploding Card!',
    1,
    1,
    4,
    '/img/set/deadpool/heroes/deadpool/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Cha-Ching!',
    1,
    1,
    3,
    '/img/set/deadpool/heroes/deadpool/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    1
),
(
    'Super Feint',
    1,
    4,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Non-Retinal Scan Access to Danger Room',
    1,
    3,
    4,
    '/img/set/deadpool/heroes/deadpool/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Gimme Gimme Chimichanga',
    1,
    3,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'I Always Get The Last Word',
    1,
    3,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/15.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Call Me',
    1,
    3,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/16.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'And For My Next Move...',
    1,
    2,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/17.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Chimichanga Break!',
    1,
    2,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/18.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Feint',
    1,
    2,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/19.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'I''m Not Wearing Pants',
    1,
    2,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/20.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Push to Teleport',
    1,
    2,
    6,
    '/img/set/deadpool/heroes/deadpool/cards/21.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Time out time out time out!',
    1,
    0,
    3,
    '/img/set/deadpool/heroes/deadpool/cards/22.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    2
),
(
    'Passwords',
    1,
    5,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/23.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    3
),
(
    'They Have An Amazing Buffet',
    1,
    3,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/24.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    3
),
(
    'Transit Card',
    1,
    2,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/25.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    3
),
(
    'Eat Me',
    1,
    2,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/26.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    3
),
(
    'Sweeet!',
    1,
    NULL,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/27.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    4
),
(
    'Dumpster Divin'' Deadpool',
    1,
    NULL,
    1,
    '/img/set/deadpool/heroes/deadpool/cards/28.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    4
),
(
    'Faint',
    1,
    NULL,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/29.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    4
),
(
    'Holy Mackerel!',
    1,
    NULL,
    2,
    '/img/set/deadpool/heroes/deadpool/cards/30.webp',
    (SELECT id FROM heroes WHERE name = 'Deadpool'),
    4
),
-- Yennenga
(
    'Surprise Volley',
    3,
    3,
    3,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    1
),
(
    'Rain of Arrows',
    3,
    3,
    3,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    1
),
(
    'Skirmish',
    2,
    4,
    2,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Jaws of the Beast',
    3,
    3,
    3,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Stallion Charge',
    3,
    3,
    3,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Divide and Conquer',
    2,
    2,
    1,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Point Blank',
    3,
    2,
    2,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Pin the Prey',
    2,
    1,
    2,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    2
),
(
    'Shield Formation',
    2,
    3,
    3,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    3
),
(
    'Master of the Hunt',
    2,
    NULL,
    3,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    4
),
(
    'One With The Land',
    2,
    NULL,
    2,
    '/img/set/battle_of_legends2/heroes/yennenga/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Yennenga'),
    4
),
-- Achilles
(
    'Brothers In Arms',
    3,
    4,
    2,
    '/img/set/battle_of_legends2/heroes/achilles/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    1
),
(
    'Battle Frenzy',
    2,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/achilles/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    1
),
(
    'The Day of Your Doom',
    2,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/achilles/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    1
),
(
    'Test For Weakness',
    3,
    1,
    3,
    '/img/set/battle_of_legends2/heroes/achilles/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    1
),
(
    'Skirmish',
    3,
    4,
    1,
    '/img/set/battle_of_legends2/heroes/achilles/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    2
),
(
    'Wily Fighting',
    2,
    3,
    1,
    '/img/set/battle_of_legends2/heroes/achilles/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    2
),
(
    'Blessed By Hermes',
    2,
    3,
    1,
    '/img/set/battle_of_legends2/heroes/achilles/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/battle_of_legends2/heroes/achilles/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    2
),
(
    'Battle Hardened',
    2,
    2,
    2,
    '/img/set/battle_of_legends2/heroes/achilles/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    2
),
(
    'Achilles'' Heel',
    3,
    4,
    2,
    '/img/set/battle_of_legends2/heroes/achilles/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    3
),
(
    'Under Achilles'' Helm',
    3,
    2,
    4,
    '/img/set/battle_of_legends2/heroes/achilles/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    3
),
(
    'Spear Throw',
    2,
    NULL,
    1,
    '/img/set/battle_of_legends2/heroes/achilles/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Achilles'),
    4
),
-- Bloody Mary
(
    'Speak Three Times',
    2,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    1
),
(
    'Bloody Requiem',
    3,
    3,
    4,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    1
),
(
    'Out Of The Mirror',
    2,
    1,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    1
),
(
    'Ghostly Touch',
    2,
    1,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    1
),
(
    'Infinity Mirror',
    2,
    4,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    2
),
(
    'Broken Glass',
    3,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    2
),
(
    'Jump Scare',
    2,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    2
),
(
    'Feint',
    2,
    2,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    2
),
(
    'Trick of the Light',
    3,
    2,
    3,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    2
),
(
    'Evade',
    3,
    3,
    1,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    3
),
(
    'Mirror Image',
    2,
    0,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    3
),
(
    'Stolen Memories',
    2,
    NULL,
    3,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    4
),
(
    'Closer Than She Appears',
    2,
    NULL,
    2,
    '/img/set/battle_of_legends2/heroes/bloody_mary/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Bloody Mary'),
    4
),
-- Sun Wukong
(
    'Ox Form',
    2,
    7,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    1
),
(
    'Taunting Laughter',
    3,
    3,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    1
),
(
    'Infinite Strikes',
    3,
    2,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    1
),
(
    'Ruyi Jingo Bang',
    3,
    0,
    3,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    1
),
(
    'Wily Fighting',
    3,
    3,
    1,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    2
),
(
    '72 Transformations',
    3,
    2,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    2
),
(
    'Sly Monkey',
    4,
    2,
    3,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    2
),
(
    'Tortoise Form',
    2,
    5,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    3
),
(
    'Golden Chain Mail',
    2,
    4,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    3
),
(
    'Bewilderment',
    2,
    0,
    2,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    3
),
(
    'Fiery Eyes That See',
    2,
    NULL,
    1,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    4
),
(
    'Phoenix Form',
    1,
    NULL,
    1,
    '/img/set/battle_of_legends2/heroes/sun_wukong/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Sun Wukong'),
    4
),
-- Moon Knight
(
    'I''m Not Real',
    3,
    4,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    1
),
(
    'That''s Why I Always Win',
    3,
    3,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    1
),
(
    'Good Enough For Us',
    2,
    4,
    1,
    '/img/set/redemption_row/heroes/moon_knight/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'That''s The Part I Like',
    2,
    3,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'Fist of Khonshu',
    2,
    3,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'A Totally Sane Thing To Do',
    3,
    2,
    1,
    '/img/set/redemption_row/heroes/moon_knight/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'Past and Present Intermingle',
    3,
    2,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/redemption_row/heroes/moon_knight/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'Let Your Insanity Guide You',
    2,
    1,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    2
),
(
    'We''re All In This Together',
    3,
    3,
    2,
    '/img/set/redemption_row/heroes/moon_knight/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    3
),
(
    'Travelers of The Night',
    2,
    NULL,
    3,
    '/img/set/redemption_row/heroes/moon_knight/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    4
),
(
    'Madness Will Keep You Alive',
    2,
    NULL,
    3,
    '/img/set/redemption_row/heroes/moon_knight/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Moon Knight'),
    4
),
-- Ghost Rider
(
    'Spirit Of Vengeance',
    3,
    5,
    2,
    '/img/set/redemption_row/heroes/ghost_rider/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    1
),
(
    'I Brought The Devil With Me',
    3,
    3,
    2,
    '/img/set/redemption_row/heroes/ghost_rider/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    1
),
(
    'Blaze of Glory',
    2,
    2,
    3,
    '/img/set/redemption_row/heroes/ghost_rider/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    1
),
(
    'Penance Stare',
    2,
    3,
    2,
    '/img/set/redemption_row/heroes/ghost_rider/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    2
),
(
    'I Finally Escaped Hell',
    3,
    3,
    1,
    '/img/set/redemption_row/heroes/ghost_rider/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    2
),
(
    'The Wicked Will Burn',
    3,
    3,
    2,
    '/img/set/redemption_row/heroes/ghost_rider/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    2
),
(
    'Feint',
    2,
    2,
    1,
    '/img/set/redemption_row/heroes/ghost_rider/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    2
),
(
    'Control The Demon',
    3,
    0,
    1,
    '/img/set/redemption_row/heroes/ghost_rider/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    2
),
(
    'Deal With The Devil',
    2,
    2,
    1,
    '/img/set/redemption_row/heroes/ghost_rider/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    3
),
(
    'Stoke The Flames',
    3,
    2,
    2,
    '/img/set/redemption_row/heroes/ghost_rider/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    3
),
(
    'Hell Rides With Me',
    2,
    NULL,
    3,
    '/img/set/redemption_row/heroes/ghost_rider/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    4
),
(
    'Chains of Hellfire',
    2,
    NULL,
    2,
    '/img/set/redemption_row/heroes/ghost_rider/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Ghost Rider'),
    4
),
-- Luke Cage
(
    'Sweet Christmas!',
    2,
    6,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    1
),
(
    'Commanding Impact',
    3,
    5,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    1
),
(
    'Get Paid',
    2,
    4,
    2,
    '/img/set/redemption_row/heroes/luke_cage/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    1
),
(
    'Still Standing',
    2,
    4,
    2,
    '/img/set/redemption_row/heroes/luke_cage/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    1
),
(
    'Hero For Hire',
    3,
    3,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    1
),
(
    'Pushback',
    2,
    2,
    3,
    '/img/set/redemption_row/heroes/luke_cage/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    2
),
(
    'Daughter of the Dragon',
    2,
    2,
    2,
    '/img/set/redemption_row/heroes/luke_cage/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    2
),
(
    'Regroup',
    3,
    1,
    3,
    '/img/set/redemption_row/heroes/luke_cage/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    2
),
(
    'Trash Talk',
    3,
    2,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    3
),
(
    'Power Man',
    2,
    2,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    3
),
(
    'Got My Back?',
    2,
    1,
    2,
    '/img/set/redemption_row/heroes/luke_cage/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    3
),
(
    'Skin Like Titanium',
    2,
    0,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    3
),
(
    'Where''s My Money?',
    2,
    NULL,
    1,
    '/img/set/redemption_row/heroes/luke_cage/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Luke Cage'),
    4
),
-- Bullseye
(
    'World''s Greatest Assassin',
    2,
    4,
    3,
    '/img/set/hells_kitchen/heroes/bullseye/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    1
),
(
    'I Never Miss',
    4,
    3,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    1
),
(
    'For My Next Trick',
    3,
    2,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    1
),
(
    'I Planned To Be Here',
    2,
    2,
    3,
    '/img/set/hells_kitchen/heroes/bullseye/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    1
),
(
    'Ricochet',
    3,
    3,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    2
),
(
    'Master Strategist',
    2,
    3,
    3,
    '/img/set/hells_kitchen/heroes/bullseye/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    2
),
(
    'Right Between The Eyes',
    2,
    3,
    3,
    '/img/set/hells_kitchen/heroes/bullseye/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    2
),
(
    'I''m Better And I''ll Prove It',
    2,
    2,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    2
),
(
    'Arrogant But Effective',
    3,
    2,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    2
),
(
    'Feint',
    2,
    2,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    2
),
(
    'Tactical Retreat',
    3,
    3,
    2,
    '/img/set/hells_kitchen/heroes/bullseye/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    3
),
(
    'Study The Target',
    2,
    NULL,
    3,
    '/img/set/hells_kitchen/heroes/bullseye/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Bullseye'),
    4
),
-- Daredevil
(
    'Devil of Hell''s Kitchen',
    2,
    4,
    3,
    '/img/set/hells_kitchen/heroes/daredevil/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    1
),
(
    'Man Without Fear',
    2,
    2,
    3,
    '/img/set/hells_kitchen/heroes/daredevil/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    1
),
(
    'Take A Knee',
    3,
    3,
    3,
    '/img/set/hells_kitchen/heroes/daredevil/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    2
),
(
    'Grappling Hook',
    3,
    3,
    2,
    '/img/set/hells_kitchen/heroes/daredevil/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/hells_kitchen/heroes/daredevil/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    2
),
(
    'Son Of A Boxer',
    3,
    3,
    2,
    '/img/set/hells_kitchen/heroes/daredevil/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    3
),
(
    'Breather',
    3,
    NULL,
    2,
    '/img/set/hells_kitchen/heroes/daredevil/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    4
),
(
    'Through Adversity',
    3,
    NULL,
    2,
    '/img/set/hells_kitchen/heroes/daredevil/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Daredevil'),
    4
),
-- Elektra
(
    'Mystic Assassin',
    2,
    6,
    1,
    '/img/set/hells_kitchen/heroes/elektra/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    1
),
(
    'Hands of Red',
    2,
    4,
    2,
    '/img/set/hells_kitchen/heroes/elektra/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    1
),
(
    'The Fist',
    2,
    3,
    3,
    '/img/set/hells_kitchen/heroes/elektra/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    1
),
(
    'Sai',
    2,
    4,
    3,
    '/img/set/hells_kitchen/heroes/elektra/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    2
),
(
    'Ninjitsu',
    2,
    3,
    2,
    '/img/set/hells_kitchen/heroes/elektra/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    2
),
(
    'Cloaked In Shadow',
    2,
    2,
    1,
    '/img/set/hells_kitchen/heroes/elektra/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    2
),
(
    'Whirlwind',
    2,
    2,
    1,
    '/img/set/hells_kitchen/heroes/elektra/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    2
),
(
    'Intercept',
    2,
    3,
    4,
    '/img/set/hells_kitchen/heroes/elektra/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    3
),
(
    'Snakeroot Clan',
    2,
    1,
    2,
    '/img/set/hells_kitchen/heroes/elektra/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    3
),
(
    'Mesmerize',
    2,
    NULL,
    2,
    '/img/set/hells_kitchen/heroes/elektra/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Elektra'),
    4
),
-- Dr. Sattler
(
    'You Never Had Control, That''s the Illusion',
    3,
    2,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    1
),
(
    'Hey! Hey! Hey!',
    1,
    3,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Must Go Faster',
    1,
    3,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Violently, If Necessary',
    3,
    3,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Chaotician',
    1,
    2,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Life Finds a Way',
    2,
    2,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Woman Inherits the Earth',
    3,
    2,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Regroup',
    2,
    1,
    1,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'Sexism in Survival Situations',
    2,
    1,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'I Think We''re Back In Business',
    3,
    0,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    2
),
(
    'The Concept of Attraction',
    3,
    2,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    3
),
(
    'Lock The Doors!',
    2,
    2,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    3
),
(
    'The Future Ex-Mrs. Malcolm',
    1,
    NULL,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/dr_sattler/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Sattler'),
    4
),
-- T. Rex
(
    'Commanding Impact',
    3,
    5,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    1
),
(
    '15,000 Pounds of Muscle',
    2,
    3,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    1
),
(
    'Reckless Lunge',
    3,
    3,
    4,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    1
),
(
    'When Dinosaurs Ruled the Earth',
    4,
    2,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    1
),
(
    'Momentous Shift',
    3,
    3,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    2
),
(
    'Terrifying Roar',
    2,
    3,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    2
),
(
    'Thrash',
    3,
    2,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    2
),
(
    'You''re Just Making Her Angry',
    2,
    1,
    1,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    3
),
(
    'Ripples in the Water',
    3,
    NULL,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    4
),
(
    '65 Million Years of Gut Instinct',
    2,
    NULL,
    3,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    4
),
(
    'Closer Than She Appears',
    3,
    NULL,
    2,
    '/img/set/jurassic_park_settler_vs_trex/heroes/trex/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'T. Rex'),
    4
),
-- The Genie
(
    'Careful What You Wish For',
    3,
    4,
    2,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    1
),
(
    'I Am Freed',
    2,
    3,
    2,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    1
),
(
    'Imprisoned Wrath',
    2,
    3,
    1,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    1
),
(
    'Your Wish is My Command',
    2,
    3,
    1,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    1
),
(
    'Wishing For More Wishes',
    3,
    3,
    2,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    2
),
(
    'I''ve Made Sultans Out of Less',
    2,
    2,
    1,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    2
),
(
    'I Grant You Death',
    3,
    2,
    1,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    2
),
(
    'This is No Parlor Trick',
    2,
    1,
    2,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    2
),
(
    'Prisoner''s Torment',
    2,
    1,
    2,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    3
),
(
    'Back In The Lamp',
    3,
    0,
    1,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    3
),
(
    'Three Wishes',
    3,
    NULL,
    3,
    '/img/set/houdini_vs_the_genie/heroes/the_genie/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'The Genie'),
    4
),
-- Houdini
(
    'An Illusion of My Own Design',
    2,
    4,
    1,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    1
),
(
    'Flourish',
    4,
    3,
    2,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    1
),
(
    'The Big Reveal',
    2,
    2,
    3,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    1
),
(
    'For My Next Trick',
    2,
    2,
    2,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    1
),
(
    'Sleight of Hand',
    2,
    1,
    3,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    1
),
(
    'And the Beautiful Bess!',
    2,
    3,
    1,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    2
),
(
    'Smoke and Mirrors',
    2,
    3,
    1,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    2
),
(
    'Misdirection',
    3,
    2,
    1,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    2
),
(
    'Vanishing Act',
    3,
    2,
    2,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    2
),
(
    'All Part of the Show',
    2,
    2,
    2,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    3
),
(
    'Grand Escape',
    3,
    2,
    3,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    3
),
(
    'A Magician Never Reveals His Secrets',
    1,
    NULL,
    4,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    4
),
(
    'Set the Stage',
    2,
    NULL,
    2,
    '/img/set/houdini_vs_the_genie/heroes/houdini/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Houdini'),
    4
),
-- Cloak Dagger
(
    'Lightforce Barrage',
    2,
    7,
    3,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    1
),
(
    'Commanding Impact',
    3,
    5,
    2,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    1
),
(
    'Darkforce Dimension',
    2,
    4,
    3,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    1
),
(
    'Channel the Dark',
    3,
    2,
    2,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    1
),
(
    'Into the Void',
    3,
    2,
    1,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    1
),
(
    'Perfect Balance',
    2,
    4,
    2,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    2
),
(
    'The Living Light',
    2,
    3,
    2,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    2
),
(
    'Into Darkness',
    3,
    3,
    2,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    2
),
(
    'Traverse the Darkforce',
    2,
    2,
    1,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    2
),
(
    'Living Shadow',
    3,
    2,
    2,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    3
),
(
    'Chosen Fate',
    2,
    NULL,
    1,
    '/img/set/teen_spirit/heroes/cloak_dagger/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Cloak Dagger'),
    4
),
-- Squirrel Girl
(
    'Fuzzball Special',
    2,
    3,
    1,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    1
),
(
    'Bite of Steel',
    3,
    2,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    1
),
(
    'Kick Butts',
    3,
    1,
    1,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    1
),
(
    'Squirmish',
    2,
    4,
    1,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    2
),
(
    'Unbeatable Squirrel Girl',
    2,
    4,
    1,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    2
),
(
    'Dash',
    2,
    3,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    2
),
(
    'Get ''Em Tippy-Toe!',
    3,
    3,
    1,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    2
),
(
    'Call of the Mild',
    3,
    2,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    2
),
(
    'Feint',
    2,
    2,
    1,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    2
),
(
    'Squirgility',
    3,
    3,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    3
),
(
    'Eat Nuts',
    2,
    NULL,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    4
),
(
    'Horde of Squirrels',
    2,
    NULL,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    4
),
(
    'Nutwork of Spies',
    1,
    NULL,
    2,
    '/img/set/teen_spirit/heroes/squirrel_girl/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Squirrel Girl'),
    4
),
-- Ms. Marvel
(
    'Big Wind Up',
    3,
    4,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    1
),
(
    'I''m Not Touching You',
    3,
    4,
    1,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    1
),
(
    'Fangirl',
    3,
    0,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    1
),
(
    'Momentous Shift',
    3,
    3,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    2
),
(
    'Easy Peasy',
    3,
    3,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    2
),
(
    'Embiggen',
    3,
    3,
    3,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    2
),
(
    'Shrink! Shrink! Shrink!',
    3,
    2,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    2
),
(
    'Slingshot',
    3,
    3,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    3
),
(
    'Friends and Family',
    1,
    NULL,
    4,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    4
),
(
    'Gyro and Fries',
    2,
    NULL,
    2,
    '/img/set/teen_spirit/heroes/ms_marvel/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Ms. Marvel'),
    4
),
-- Black Widow
(
    'Widow''s Sting',
    2,
    5,
    2,
    '/img/set/for_king_and_country/heroes/black_widow/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    1
),
(
    'Widow''s Bite',
    3,
    4,
    1,
    '/img/set/for_king_and_country/heroes/black_widow/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    1
),
(
    'Fake Out',
    2,
    1,
    1,
    '/img/set/for_king_and_country/heroes/black_widow/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    1
),
(
    'Acting Director of S.H.I.E.L.D.',
    3,
    4,
    3,
    '/img/set/for_king_and_country/heroes/black_widow/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    2
),
(
    'Widow''s Kiss',
    2,
    4,
    2,
    '/img/set/for_king_and_country/heroes/black_widow/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    2
),
(
    'Widow''s Line',
    3,
    3,
    2,
    '/img/set/for_king_and_country/heroes/black_widow/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    2
),
(
    'Caught in a Web',
    3,
    3,
    2,
    '/img/set/for_king_and_country/heroes/black_widow/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    2
),
(
    'Feint',
    3,
    2,
    1,
    '/img/set/for_king_and_country/heroes/black_widow/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    2
),
(
    'Double Identity',
    3,
    3,
    2,
    '/img/set/for_king_and_country/heroes/black_widow/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    3
),
(
    'Life Model Decoy',
    2,
    0,
    2,
    '/img/set/for_king_and_country/heroes/black_widow/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    3
),
(
    'The Budapest Gambit',
    1,
    NULL,
    4,
    '/img/set/for_king_and_country/heroes/black_widow/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    4
),
(
    'The Moscow Protocol',
    1,
    NULL,
    4,
    '/img/set/for_king_and_country/heroes/black_widow/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    4
),
(
    'The Firenze Agenda',
    1,
    NULL,
    4,
    '/img/set/for_king_and_country/heroes/black_widow/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    4
),
(
    'The Kinshasa Directive',
    1,
    NULL,
    4,
    '/img/set/for_king_and_country/heroes/black_widow/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    4
),
(
    'The Madripoor Sanction',
    1,
    NULL,
    4,
    '/img/set/for_king_and_country/heroes/black_widow/cards/15.webp',
    (SELECT id FROM heroes WHERE name = 'Black Widow'),
    4
),
-- Winter Soldier
(
    'Without Remorse',
    3,
    6,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    1
),
(
    'Programmed to Kill',
    2,
    4,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    1
),
(
    'Bionic Arm',
    3,
    2,
    1,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    1
),
(
    'Marksman',
    3,
    1,
    1,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    1
),
(
    'Reflex Memories',
    2,
    5,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    2
),
(
    'Born in the Barracks',
    2,
    3,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    2
),
(
    'Wily Fighting',
    2,
    3,
    1,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    2
),
(
    'Reprogram',
    3,
    2,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    2
),
(
    'Complete the Mission',
    3,
    3,
    2,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    3
),
(
    'A Boy Named Bucky',
    2,
    NULL,
    3,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    4
),
(
    'Manipulation',
    2,
    NULL,
    3,
    '/img/set/for_king_and_country/heroes/winter_soldier/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Winter Soldier'),
    4
),
-- Black Panther
(
    'Analyze and Adjust',
    3,
    3,
    3,
    '/img/set/for_king_and_country/heroes/black_panther/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    1
),
(
    'Vibranium Shockwave',
    2,
    2,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    1
),
(
    'Ancestral Insight',
    3,
    4,
    1,
    '/img/set/for_king_and_country/heroes/black_panther/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Cat-Like Reflexes',
    2,
    3,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Wakanda Forever!',
    3,
    3,
    3,
    '/img/set/for_king_and_country/heroes/black_panther/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Feint',
    2,
    2,
    1,
    '/img/set/for_king_and_country/heroes/black_panther/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Nanotriage Processor',
    2,
    2,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Anti-Metal Claws',
    2,
    1,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Regroup',
    2,
    2,
    1,
    '/img/set/for_king_and_country/heroes/black_panther/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    2
),
(
    'Evade',
    2,
    3,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    3
),
(
    'Microweave Mesh',
    2,
    2,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    3
),
(
    'Tactical Remote Scanning',
    2,
    NULL,
    3,
    '/img/set/for_king_and_country/heroes/black_panther/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    4
),
(
    'Stalking Panther',
    3,
    NULL,
    2,
    '/img/set/for_king_and_country/heroes/black_panther/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Black Panther'),
    4
),
-- Spiderman
(
    'Swinging Kick',
    3,
    6,
    2,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    1
),
(
    'Thwip!',
    3,
    4,
    1,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    1
),
(
    'Disarming Shot',
    2,
    4,
    3,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    1
),
(
    'Right in the Face!',
    2,
    4,
    2,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    2
),
(
    'Snark',
    2,
    3,
    1,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    2
),
(
    'Wall Crawler',
    2,
    3,
    1,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    2,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    2
),
(
    'Spider-Sense Tingling!',
    3,
    2,
    1,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    2
),
(
    'Counter-Attack',
    3,
    3,
    1,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    3
),
(
    'Web Shooters',
    3,
    3,
    2,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    3
),
(
    'Friendly Neighborhood Spider-Man',
    2,
    NULL,
    3,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    4
),
(
    'With Great Power',
    2,
    NULL,
    3,
    '/img/set/brains_and_brawn/heroes/spiderman/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Spiderman'),
    4
),
-- Doctor Strange
(
    'The Winds of Watoomb',
    3,
    4,
    1,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    1
),
(
    'The Rings of Raggadorr',
    3,
    4,
    1,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    1
),
(
    'Bolts of Balthakk',
    4,
    2,
    3,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    1
),
(
    'Seven Suns of Cinnibus',
    3,
    3,
    2,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    2
),
(
    'Feint',
    2,
    2,
    1,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    2
),
(
    'Steadfast Disciple',
    3,
    2,
    2,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    2
),
(
    'Cloak of Levitation',
    2,
    2,
    1,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    2
),
(
    'Master of Kamar-Taj',
    3,
    2,
    2,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    2
),
(
    'The Mists of Munnopor',
    3,
    2,
    2,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    3
),
(
    'Eye of Agamotto',
    2,
    NULL,
    2,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    4
),
(
    'No Really, I''m a Doctor',
    2,
    NULL,
    3,
    '/img/set/brains_and_brawn/heroes/doctor_strange/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Doctor Strange'),
    4
),
-- She Hulk
(
    'Omega-Level Threat',
    2,
    5,
    2,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    1
),
(
    'Sensational',
    3,
    4,
    2,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    1
),
(
    'The Savage She-Hulk',
    2,
    3,
    3,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    1
),
(
    'Green Energy',
    3,
    4,
    1,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    2
),
(
    'Nerve Cluster Strike',
    3,
    3,
    1,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    2
),
(
    'Legalese',
    3,
    2,
    1,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    2
),
(
    'Cease and Desist',
    3,
    1,
    2,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    2
),
(
    'The Defense Rests',
    2,
    2,
    2,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    3
),
(
    'Lady Justice',
    3,
    0,
    2,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    3
),
(
    'Jennifer Walters, Esq.',
    2,
    NULL,
    1,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    4
),
(
    'Leap Toward',
    2,
    NULL,
    1,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    4
),
(
    'Double Jeopardy',
    2,
    NULL,
    2,
    '/img/set/brains_and_brawn/heroes/she_hulk/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'She Hulk'),
    4
),
-- Golden Bat
(
    'Super Strength',
    2,
    5,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    1
),
(
    'Vaporizing Eyebeams',
    3,
    2,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    1
),
(
    'A Punch to Shake the Earth',
    3,
    1,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    1
),
(
    'Skirmish',
    2,
    4,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    2
),
(
    'Terrifying Roar',
    3,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    2
),
(
    'Insight of the Ancients',
    2,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    2
),
(
    'Like a Flash of Golden Light',
    3,
    2,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    2
),
(
    'Sight Beyond Sight',
    3,
    2,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    2
),
(
    'He Laughs at Your Feebleness',
    2,
    5,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    3
),
(
    'Imposing Presence',
    2,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    3
),
(
    'Alpine Fortress',
    3,
    NULL,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    4
),
(
    'Arrive Just in Time',
    2,
    NULL,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/golden_bat/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Golden Bat'),
    4
),
-- Annie Christmas
(
    'Lagniappe',
    3,
    5,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    1
),
(
    'Bottom Dealing',
    2,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    1
),
(
    'Better Together',
    4,
    4,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    2
),
(
    'Long Shot',
    2,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    2
),
(
    'Quite a Pair',
    2,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    2
),
(
    'Keep Your Hands to Yourself',
    3,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    2
),
(
    'The Turn and the River',
    2,
    2,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    2
),
(
    'Striking Beauty',
    2,
    1,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    2
),
(
    'Slick Talker',
    2,
    3,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    3
),
(
    'Mississippi Queen',
    3,
    2,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    3
),
(
    'Captain''s Orders',
    2,
    NULL,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    4
),
(
    'A Few More Pearls',
    3,
    NULL,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/annie/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Annie Christmas'),
    4
),
-- Dr. Jill Trent
(
    'Energizing Spray',
    2,
    5,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    1
),
(
    'Battle of Wits',
    3,
    2,
    4,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    1
),
(
    'Ace Fighter',
    2,
    5,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Gyroscopic Jetpack',
    3,
    4,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Utility Belt',
    3,
    3,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Insightful Deduction',
    2,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Sisters in Arms',
    2,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Stasis Diffuser',
    2,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Laser Pen',
    3,
    2,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Caught Red-Handed',
    2,
    1,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    2
),
(
    'Indestructible Cloth',
    2,
    5,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    3
),
(
    'Hypnotist',
    2,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    3
),
(
    'Helpful Assistant',
    2,
    NULL,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/jill/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Dr. Jill Trent'),
    4
),
-- Nikola Tesla
(
    'The Alternating Current',
    2,
    5,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    1
),
(
    '7 Hertz',
    3,
    4,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    1
),
(
    'Death Ray',
    3,
    3,
    4,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    1
),
(
    'X-Ray Radiation',
    3,
    4,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    2
),
(
    'Lightning Storm',
    3,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    2
),
(
    'Polyphase Coils',
    3,
    3,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    2
),
(
    'Repulsion Blast',
    3,
    2,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    2
),
(
    'Kinetic Induction',
    3,
    2,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    2
),
(
    'Intense Experimentation',
    3,
    3,
    2,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    3
),
(
    'Fully Charged',
    2,
    NULL,
    1,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    4
),
(
    'Remote Control',
    2,
    NULL,
    3,
    '/img/set/adventures/tales_to_amaze/heroes/nikola_tesla/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Nikola Tesla'),
    4
),
-- Tomoe Gozen
(
    'Witness My Last Battle',
    2,
    7,
    4,
    '/img/set/suns_origin/heroes/tomoe/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    1
),
(
    'Five Against Thousands',
    2,
    4,
    1,
    '/img/set/suns_origin/heroes/tomoe/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    1
),
(
    'Fearsome Strength',
    2,
    3,
    1,
    '/img/set/suns_origin/heroes/tomoe/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    1
),
(
    'A Warrior''s Way',
    2,
    2,
    1,
    '/img/set/suns_origin/heroes/tomoe/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    1
),
(
    'Piercing Shot',
    3,
    2,
    1,
    '/img/set/suns_origin/heroes/tomoe/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    1
),
(
    'Skirmish',
    3,
    4,
    1,
    '/img/set/suns_origin/heroes/tomoe/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    2
),
(
    'A Worthy Opponent',
    3,
    3,
    3,
    '/img/set/suns_origin/heroes/tomoe/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    2
),
(
    'Confront Any Demon or God',
    2,
    3,
    3,
    '/img/set/suns_origin/heroes/tomoe/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    2
),
(
    'Flash of Steel',
    3,
    2,
    1,
    '/img/set/suns_origin/heroes/tomoe/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    2
),
(
    'Refuse to Retreat',
    2,
    3,
    2,
    '/img/set/suns_origin/heroes/tomoe/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    3
),
(
    'Deeds of Valor',
    3,
    2,
    2,
    '/img/set/suns_origin/heroes/tomoe/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    3
),
(
    'Lord Kiso''s Final Stand',
    3,
    NULL,
    2,
    '/img/set/suns_origin/heroes/tomoe/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Tomoe Gozen'),
    4
),
-- Oda Nobunaga
(
    'Student of War',
    2,
    5,
    2,
    '/img/set/suns_origin/heroes/oda/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    1
),
(
    'Lightning and Thunder',
    3,
    4,
    1,
    '/img/set/suns_origin/heroes/oda/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    1
),
(
    'Fire and Flames',
    3,
    3,
    3,
    '/img/set/suns_origin/heroes/oda/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    1
),
(
    'Sun and Moon',
    2,
    2,
    1,
    '/img/set/suns_origin/heroes/oda/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    1
),
(
    'Momentous Shift',
    2,
    3,
    2,
    '/img/set/suns_origin/heroes/oda/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    2
),
(
    'Battle Maneuvers',
    4,
    2,
    2,
    '/img/set/suns_origin/heroes/oda/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    2
),
(
    'Patience and Strategy',
    3,
    1,
    1,
    '/img/set/suns_origin/heroes/oda/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    2
),
(
    'Pragmatism',
    3,
    3,
    1,
    '/img/set/suns_origin/heroes/oda/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    3
),
(
    'Spring the Trap',
    3,
    2,
    2,
    '/img/set/suns_origin/heroes/oda/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    3
),
(
    'Reinforce',
    3,
    NULL,
    2,
    '/img/set/suns_origin/heroes/oda/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    4
),
(
    'Demon King of the Sixth Heaven',
    2,
    NULL,
    3,
    '/img/set/suns_origin/heroes/oda/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Oda Nobunaga'),
    4
),
-- Shakespeare
(
    'My Kingdom For a Horse',
    3,
    5,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Horror',
    1,
    4,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Horror',
    1,
    4,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Horror',
    1,
    4,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Horror',
    1,
    4,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Horror',
    1,
    4,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'All Are Punished',
    2,
    4,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Places, Places!',
    2,
    3,
    1,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    1
),
(
    'Such Sweet Sorrow',
    2,
    4,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'Once More Unto The Breach',
    2,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'Again',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'Et Tu, Brute?',
    2,
    3,
    3,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'Deceive',
    3,
    2,
    1,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'Alas',
    2,
    2,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'The Ides Of March',
    2,
    2,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/15.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
(
    'Revise',
    2,
    1,
    2,
    '/img/set/slings_and_arrows/heroes/shakespeare/cards/16.webp',
    (SELECT id FROM heroes WHERE name = 'Shakespeare'),
    2
),
-- Titania
(
    'Met By Moonlight',
    3,
    5,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    1
),
(
    'Queen Of The Fairies',
    2,
    2,
    3,
    '/img/set/slings_and_arrows/heroes/titania/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    1
),
(
    'Whisked Away',
    3,
    4,
    1,
    '/img/set/slings_and_arrows/heroes/titania/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    2
),
(
    'The Moon Looks Down',
    2,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    2
),
(
    'Fairy Song',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    2
),
(
    'As Wise As Beautiful',
    3,
    2,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    2
),
(
    'Parting Gift',
    2,
    2,
    1,
    '/img/set/slings_and_arrows/heroes/titania/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    2
),
(
    'Protection Of The Fairy Woods',
    3,
    2,
    1,
    '/img/set/slings_and_arrows/heroes/titania/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    3
),
(
    'But A Dream',
    2,
    0,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    3
),
(
    'What Fools These Mortals Be',
    2,
    NULL,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    4
),
(
    'A Momentary Glance',
    2,
    NULL,
    4,
    '/img/set/slings_and_arrows/heroes/titania/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    4
),
(
    'Gift Of The Fair Folk',
    3,
    NULL,
    2,
    '/img/set/slings_and_arrows/heroes/titania/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Titania'),
    4
),
-- The Wayward Sisters
(
    'All-Seeing Familiar',
    2,
    4,
    2,
    '/img/set/slings_and_arrows/heroes/sisters/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    1
),
(
    'Double, Double',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/sisters/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    1
),
(
    'Hurly-Burly',
    3,
    3,
    1,
    '/img/set/slings_and_arrows/heroes/sisters/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    1
),
(
    'Fire Burn And Cauldron Bubble',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/sisters/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    2
),
(
    'Ward',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/sisters/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    2
),
(
    'Curious Familiar',
    2,
    2,
    3,
    '/img/set/slings_and_arrows/heroes/sisters/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    2
),
(
    'The Stars Align',
    3,
    0,
    1,
    '/img/set/slings_and_arrows/heroes/sisters/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    2
),
(
    'Pricking Of My Thumbs',
    2,
    2,
    1,
    '/img/set/slings_and_arrows/heroes/sisters/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    3
),
(
    'Toil And Trouble',
    3,
    2,
    3,
    '/img/set/slings_and_arrows/heroes/sisters/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    3
),
(
    'Unnatural Remedy',
    2,
    1,
    2,
    '/img/set/slings_and_arrows/heroes/sisters/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    3
),
(
    'Something Wicked This Way Comes',
    2,
    NULL,
    3,
    '/img/set/slings_and_arrows/heroes/sisters/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    4
),
(
    'Prophecy',
    2,
    NULL,
    2,
    '/img/set/slings_and_arrows/heroes/sisters/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'The Wayward Sisters'),
    4
),
-- Hamlet
(
    'To Sleep, Perchance To Dream',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    1
),
(
    'Uncertain Doom',
    3,
    2,
    3,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    1
),
(
    'Cruel To Be Kind',
    2,
    2,
    4,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    1
),
(
    'The Play''s The Thing',
    3,
    3,
    2,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    2
),
(
    'The Readiness Is All',
    2,
    2,
    2,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    2
),
(
    'Blood Will Have Blood',
    3,
    2,
    1,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    2
),
(
    'Outrageous Fortune',
    2,
    1,
    2,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    2
),
(
    'Nothing Either Good Or Bad',
    3,
    2,
    1,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    3
),
(
    'The Rest Is Silence',
    2,
    2,
    3,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    3
),
(
    'Maddening Insight',
    2,
    0,
    1,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    3
),
(
    'The Ghost',
    2,
    NULL,
    1,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    4
),
(
    'Method In The Madness',
    3,
    NULL,
    3,
    '/img/set/slings_and_arrows/heroes/hamlet/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Hamlet'),
    4
),
-- Eredin
(
    'Backhand',
    3,
    4,
    3,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    1
),
(
    'Foul purpose',
    2,
    3,
    2,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    1
),
(
    'Brutal strike',
    3,
    2,
    3,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    1
),
(
    'Unyielding hordes',
    3,
    1,
    2,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    1
),
(
    'Skirmish',
    3,
    4,
    1,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    2
),
(
    'Wild hunt',
    3,
    3,
    2,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    2
),
(
    'Icy guile',
    3,
    2,
    1,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    2
),
(
    'Implacable',
    3,
    3,
    3,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    3
),
(
    'Portal defense',
    2,
    0,
    1,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    3
),
(
    'Close for the kill',
    3,
    NULL,
    4,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    4
),
(
    'Might of the Aen Elle',
    2,
    NULL,
    2,
    '/img/set/the_witcher_realms_fall/heroes/eredin/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Eredin'),
    4
),
-- Philippa
(
    'Regicide',
    2,
    4,
    2,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    1
),
(
    'Owlform',
    3,
    3,
    3,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    1
),
(
    'Lightning bolt',
    3,
    3,
    1,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    1
),
(
    'Chain lightning',
    2,
    2,
    3,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    1
),
(
    'Cunning',
    2,
    4,
    1,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    2
),
(
    'Spellbreaker',
    3,
    2,
    2,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    2
),
(
    'Redanian plot',
    3,
    2,
    1,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    2
),
(
    'Do my bidding',
    2,
    3,
    3,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    3
),
(
    'Paralyzing fetters',
    2,
    2,
    3,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    3
),
(
    'Blinding dust',
    2,
    2,
    2,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    3
),
(
    'Spymaster''s ruse',
    2,
    NULL,
    2,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    4
),
(
    'Backup plan',
    2,
    NULL,
    2,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    4
),
(
    'Polymorphy',
    2,
    NULL,
    3,
    '/img/set/the_witcher_realms_fall/heroes/philippa/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Philippa'),
    4
),
-- Yennefer & Triss
(
    'Incinerate',
    3,
    7,
    2,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    1
),
(
    'Merigold''s Hailstorm',
    2,
    4,
    3,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    1
),
(
    'Echoing blast',
    3,
    3,
    1,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    1
),
(
    'Portal to anywhere',
    3,
    1,
    2,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    1
),
(
    'Ball lightning',
    3,
    3,
    1,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    2
),
(
    'Telepathy',
    3,
    3,
    1,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    2
),
(
    'Quick and ready',
    2,
    2,
    2,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    2
),
(
    'Magical barrier',
    3,
    4,
    3,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    3
),
(
    'Paralyzing fetters',
    3,
    2,
    2,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    3
),
(
    'Lodge of sorceresses',
    2,
    NULL,
    2,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    4
),
(
    'Advisor to the king',
    3,
    NULL,
    2,
    '/img/set/the_witcher_realms_fall/heroes/yen/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Yennefer & Triss'),
    4
),
-- Geralt of Rivia
(
    'Gear: Sword of silver',
    2,
    4,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    1
),
(
    'Gear: Sword of steel',
    2,
    4,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    1
),
(
    'Igni',
    2,
    0,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    1
),
(
    'Damn, you''re ugly',
    3,
    5,
    4,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Disciplined Duelist',
    3,
    4,
    2,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Annoying tune',
    3,
    3,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Rend',
    3,
    3,
    2,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Plot twist',
    3,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Riposte',
    2,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Yrden',
    3,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    2
),
(
    'Gear: Wolf Medallion',
    2,
    3,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    3
),
(
    'Gear: Armor of the Forgotten Wolf',
    2,
    2,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    3
),
(
    'Witcher Senses',
    2,
    NULL,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    4
),
(
    'Gear: Blizzard',
    2,
    NULL,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    4
),
(
    'Gear: Tawny Owl',
    2,
    NULL,
    3,
    '/img/set/the_witcher_steel_silver/heroes/geralt_of_rivia/cards/15.webp',
    (SELECT id FROM heroes WHERE name = 'Geralt of Rivia'),
    4
),
-- Ancient Leshen
(
    'Flock of birds',
    2,
    5,
    1,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    1
),
(
    'Primeval slam',
    3,
    4,
    3,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    1
),
(
    'Command the forest',
    2,
    4,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    1
),
(
    'Nature abounds',
    3,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    1
),
(
    'Disturbing howls',
    3,
    1,
    1,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    1
),
(
    'Planted feet',
    3,
    4,
    3,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    2
),
(
    'Wily Fighting',
    3,
    3,
    1,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    2
),
(
    'Harrying strike',
    3,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    2
),
(
    'Primeval guardian',
    3,
    5,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    3
),
(
    'Strength of the pack',
    3,
    NULL,
    1,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    4
),
(
    'Vanish into murder',
    2,
    NULL,
    3,
    '/img/set/the_witcher_steel_silver/heroes/ancient_leshen/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Ancient Leshen'),
    4
),
-- Ciri
(
    'Bane of the Aen Elle',
    3,
    4,
    4,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    1
),
(
    'Lion cub of Cintra',
    3,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    1
),
(
    'Channel the source',
    3,
    2,
    3,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    1
),
(
    'Blink',
    3,
    4,
    1,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    2
),
(
    'Pushed to the brink',
    3,
    3,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    2
),
(
    'Searching strike',
    3,
    3,
    3,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    2
),
(
    'Zireael',
    3,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    2
),
(
    'The lady of space and time',
    2,
    2,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    2
),
(
    'Parry',
    3,
    3,
    1,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    3
),
(
    'Child of the Elder Blood',
    2,
    NULL,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    4
),
(
    'Unicorn ally',
    2,
    NULL,
    2,
    '/img/set/the_witcher_steel_silver/heroes/ciri/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Ciri'),
    4
),
-- Chupacabra
(
    'Blood in the air',
    3,
    4,
    4,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    1
),
(
    'Feeding',
    3,
    4,
    2,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    1
),
(
    'Ambush',
    2,
    2,
    3,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    1
),
(
    'The more they struggle',
    3,
    0,
    3,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    1
),
(
    'Wounded beast',
    3,
    3,
    1,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    2
),
(
    'Ravenous lunge',
    3,
    3,
    2,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    2
),
(
    'Tooth and tail',
    3,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    2
),
(
    'Natural toughness',
    2,
    3,
    3,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    3
),
(
    'Traveler of the night',
    3,
    NULL,
    3,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    4
),
(
    'Unsettle',
    2,
    NULL,
    2,
    '/img/set/battle_of_legends3/heroes/chupacabra/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Chupacabra'),
    4
),
-- Pandora
(
    'Hera''s Curiosity',
    3,
    3,
    4,
    '/img/set/battle_of_legends3/heroes/pandora/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    1
),
(
    'Spite',
    2,
    3,
    2,
    '/img/set/battle_of_legends3/heroes/pandora/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    1
),
(
    'Hindsight',
    3,
    3,
    2,
    '/img/set/battle_of_legends3/heroes/pandora/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    1
),
(
    'Aphrodite''s Beauty',
    3,
    0,
    3,
    '/img/set/battle_of_legends3/heroes/pandora/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    1
),
(
    'Divine Intervention',
    2,
    3,
    1,
    '/img/set/battle_of_legends3/heroes/pandora/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    2
),
(
    'Feint',
    3,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/pandora/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    2
),
(
    'Malice',
    2,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/pandora/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    2
),
(
    'Guided By The Fates',
    3,
    2,
    3,
    '/img/set/battle_of_legends3/heroes/pandora/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    2
),
(
    'Offering To The Gods',
    2,
    2,
    1,
    '/img/set/battle_of_legends3/heroes/pandora/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    3
),
(
    'Celestial Raiments',
    2,
    0,
    3,
    '/img/set/battle_of_legends3/heroes/pandora/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    3
),
(
    'Forged By Hephaestus',
    3,
    NULL,
    1,
    '/img/set/battle_of_legends3/heroes/pandora/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    4
),
(
    'Zeus''S Mischief',
    2,
    NULL,
    1,
    '/img/set/battle_of_legends3/heroes/pandora/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Pandora'),
    4
),
-- Blackbeard
(
    'Avast Ye!',
    2,
    5,
    3,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    1
),
(
    'Give no quarter',
    3,
    3,
    1,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    1
),
(
    'Light the fuse',
    3,
    2,
    3,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    1
),
(
    'A brace of primed pistols',
    2,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    1
),
(
    'Queen Anne''s revenge',
    2,
    7,
    3,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    2
),
(
    'Parley',
    3,
    3,
    2,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    2
),
(
    'Fearsome and calculating',
    3,
    3,
    1,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    2
),
(
    'Show a leg!',
    2,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    2
),
(
    'No prey, no pay',
    3,
    2,
    2,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    2
),
(
    'Intimidating visage',
    2,
    4,
    1,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    3
),
(
    'Plunder',
    3,
    NULL,
    2,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    4
),
(
    'Scourge of the seven seas',
    2,
    NULL,
    2,
    '/img/set/battle_of_legends3/heroes/blackbeard/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Blackbeard'),
    4
),
-- Loki
(
    'Trick: Baldr''s downfall',
    3,
    4,
    0,
    '/img/set/battle_of_legends3/heroes/loki/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    1
),
(
    'Looking for trouble',
    3,
    4,
    3,
    '/img/set/battle_of_legends3/heroes/loki/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    1
),
(
    'Shapershifter',
    4,
    0,
    2,
    '/img/set/battle_of_legends3/heroes/loki/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    1
),
(
    'Ragnarök',
    2,
    0,
    3,
    '/img/set/battle_of_legends3/heroes/loki/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    1
),
(
    'Malicious Flyting',
    3,
    3,
    3,
    '/img/set/battle_of_legends3/heroes/loki/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    2
),
(
    'Underhanded',
    3,
    3,
    2,
    '/img/set/battle_of_legends3/heroes/loki/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    2
),
(
    'Trick: Freyja''s Rescue',
    2,
    2,
    0,
    '/img/set/battle_of_legends3/heroes/loki/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    2
),
(
    'God Of Mischief',
    3,
    2,
    3,
    '/img/set/battle_of_legends3/heroes/loki/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    2
),
(
    'Laevateinn',
    3,
    2,
    3,
    '/img/set/battle_of_legends3/heroes/loki/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    2
),
(
    'Trick: Sindri''s Bet',
    2,
    3,
    0,
    '/img/set/battle_of_legends3/heroes/loki/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    3
),
(
    'Trick: Svadilfari''s Lure',
    2,
    NULL,
    0,
    '/img/set/battle_of_legends3/heroes/loki/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Loki'),
    4
),
-- Raphael
(
    'Batter up!',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    1
),
(
    'Turtle power!',
    2,
    3,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    1
),
(
    'Unbridled rage',
    2,
    3,
    4,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    1
),
(
    'Crowd control',
    3,
    2,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    1
),
(
    'Let''s do this!',
    3,
    1,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    1
),
(
    'Sai',
    2,
    4,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    2
),
(
    'Relentless',
    2,
    3,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    2
),
(
    'Break something',
    3,
    2,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    2
),
(
    'Payback time!',
    3,
    2,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    2
),
(
    'Slapshot',
    3,
    2,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    2
),
(
    'Heroes in a half shell',
    2,
    5,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    3
),
(
    'Raphael is cool but rude',
    2,
    NULL,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/raphael/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Raphael'),
    4
),
-- Donatello
(
    'Thinking ahead',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    1
),
(
    'Turtle power!',
    2,
    3,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    1
),
(
    'Electro grenade',
    1,
    2,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    1
),
(
    'Quick strike',
    3,
    3,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    2
),
(
    'Short circuit',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    2
),
(
    'Untested enhancements',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    2
),
(
    'Shift focus',
    3,
    2,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    2
),
(
    'Heroes in a half shell',
    2,
    5,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    3
),
(
    'Bo staff',
    2,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    3
),
(
    'Self defense grid',
    1,
    2,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    3
),
(
    'Party wagon!',
    2,
    NULL,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    4
),
(
    'Smoke bomb',
    1,
    NULL,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    4
),
(
    'Donatello does machines',
    2,
    NULL,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    4
),
(
    'The future of Ninjutsu',
    2,
    NULL,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/donatello/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Donatello'),
    4
),
-- Michelangelo
(
    'Hi-yaaaaah!!',
    3,
    4,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    1
),
(
    'Turtle power!',
    2,
    3,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    1
),
(
    'Boisterous beatdown',
    3,
    2,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    1
),
(
    'Hard-hitting investigation',
    3,
    0,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    1
),
(
    'Let''s go',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    2
),
(
    'Cowabunga!!',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    2
),
(
    'Guaranteed delivery',
    3,
    3,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    2
),
(
    'Heroes in a half shell',
    2,
    5,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    3
),
(
    'Back for seconds',
    2,
    2,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    3
),
(
    'Michelangelo is a party dude!!',
    2,
    NULL,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    4
),
(
    'Nunchaku',
    2,
    NULL,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    4
),
(
    'Shell insertion',
    2,
    NULL,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/michelangelo/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Michelangelo'),
    4
),
-- Leonardo
(
    'Katana',
    2,
    6,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    1
),
(
    'For Sensei',
    2,
    4,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    1
),
(
    'Turtle power!',
    2,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    1
),
(
    'Fearless leader',
    3,
    3,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    1
),
(
    'Quick strike',
    3,
    3,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    2
),
(
    'Spatial awareness',
    3,
    3,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    2
),
(
    'Eat, sleep, and breath ninjutsu',
    3,
    3,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    2
),
(
    'Wise beyond his years',
    3,
    2,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    2
),
(
    'I have a plan',
    3,
    2,
    1,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    2
),
(
    'Heroes in a half shell',
    2,
    5,
    3,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    3
),
(
    'Protective father',
    2,
    NULL,
    2,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    4
),
(
    'Leonardo leads',
    2,
    NULL,
    4,
    '/img/set/adventures/teenage_mutant_ninja_turtles/heroes/leonardo/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Leonardo'),
    4
),
-- Shredder
(
    'Swarming Strike',
    3,
    5,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    1
),
(
    'Gruff Escort',
    2,
    4,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    1
),
(
    'Savagery',
    3,
    4,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    1
),
(
    'Gang Up',
    2,
    3,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    1
),
(
    'Disrupting Strike',
    2,
    3,
    1,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    2
),
(
    'Think Hard',
    2,
    3,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    2
),
(
    'Long Shot',
    3,
    3,
    1,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    2
),
(
    'Master of the Foot',
    2,
    2,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    2
),
(
    'Perplexing Tactics',
    3,
    2,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    2
),
(
    'All According to Plan',
    2,
    3,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    3
),
(
    'Masterful Defense',
    2,
    2,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    3
),
(
    'Obedient Subjects',
    2,
    NULL,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    4
),
(
    'Back to work!',
    2,
    NULL,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/shredder/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Shredder'),
    4
),
-- Krang
(
    'Android arms: Powerbomb',
    3,
    3,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    1
),
(
    'Android arms: Chain Flail',
    3,
    2,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    1
),
(
    'Android arms: Missiles',
    3,
    1,
    1,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    1
),
(
    'Warlord of Dimension X',
    3,
    3,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    2
),
(
    'Pan-dimensional Portal',
    2,
    3,
    NULL,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    2
),
(
    'Molecular Amplification Unit',
    4,
    2,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    2
),
(
    'Welcome to the Technodrome!',
    3,
    2,
    2,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    2
),
(
    'Minimizer',
    3,
    0,
    1,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    3
),
(
    'Android arms: Wings',
    3,
    NULL,
    3,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    4
),
(
    'IQ of 968',
    3,
    NULL,
    NULL,
    '/img/set/tmnt_shredder_vs_crang/heroes/krang/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Krang'),
    4
),
-- Muhammad Ali
(
    'The greatest',
    2,
    4,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    1
),
(
    'Stronger than the skill',
    2,
    3,
    1,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    1
),
(
    'Ali Shuffle',
    3,
    2,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    1
),
(
    'Jab',
    2,
    1,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    1
),
(
    'Champion of the world',
    2,
    4,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    1
),
(
    'Close and clinch',
    3,
    3,
    1,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    2
),
(
    'Momentous Shift',
    2,
    3,
    1,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    2
),
(
    'Stick and move',
    3,
    2,
    1,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    2
),
(
    'Fancy footwork',
    2,
    1,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    2
),
(
    'Hard to be humble',
    3,
    2,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    3
),
(
    'Rope-a-dope',
    2,
    2,
    3,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    3
),
(
    'Answer the bell',
    2,
    NULL,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    4
),
(
    'Louisville lip',
    2,
    NULL,
    2,
    '/img/set/muhammad_ali_vs_bruce_lee/heroes/muhammad_ali/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Muhammad Ali'),
    4
),
-- Rosie The Riveter
(
    'We Can Do It!',
    2,
    4,
    2,
    '/img/set/stars_and_stripes/heroes/rosie/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    1
),
(
    'Overrun',
    3,
    3,
    1,
    '/img/set/stars_and_stripes/heroes/rosie/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    1
),
(
    'D-Day',
    3,
    3,
    1,
    '/img/set/stars_and_stripes/heroes/rosie/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    1
),
(
    'Arc Welding',
    3,
    3,
    3,
    '/img/set/stars_and_stripes/heroes/rosie/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    2
),
(
    'Technological Superiority',
    3,
    3,
    2,
    '/img/set/stars_and_stripes/heroes/rosie/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    1,
    '/img/set/stars_and_stripes/heroes/rosie/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    2
),
(
    'Loose Lips Sink Ships!',
    3,
    2,
    2,
    '/img/set/stars_and_stripes/heroes/rosie/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    2
),
(
    'Full Metal',
    3,
    1,
    3,
    '/img/set/stars_and_stripes/heroes/rosie/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    2
),
(
    'Hasty Repairs',
    3,
    1,
    2,
    '/img/set/stars_and_stripes/heroes/rosie/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    3
),
(
    '"E" Award',
    2,
    NULL,
    3,
    '/img/set/stars_and_stripes/heroes/rosie/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    4
),
(
    'Rapid Development',
    2,
    NULL,
    3,
    '/img/set/stars_and_stripes/heroes/rosie/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Rosie The Riveter'),
    4
),
-- John Henry
(
    'Eighteen-pound Hammer',
    2,
    6,
    2,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    1
),
(
    'Larger Than Life',
    2,
    6,
    4,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    1
),
(
    'Twelve-pound Hammer',
    2,
    4,
    2,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    1
),
(
    'Nine-pound Hammer',
    3,
    3,
    2,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    1
),
(
    'Hear That Cold Steel Ring',
    2,
    2,
    3,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    1
),
(
    'Knock Them Silly',
    3,
    4,
    1,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    1,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    2
),
(
    'Power Through',
    3,
    3,
    3,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    2
),
(
    'Bring Down The Mountain',
    2,
    3,
    1,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    2
),
(
    'Deeds Of Valor',
    2,
    2,
    2,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    3
),
(
    'Cool Drink Of Water',
    3,
    0,
    2,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    3
),
(
    'Striking Fire',
    3,
    NULL,
    2,
    '/img/set/stars_and_stripes/heroes/john_henry/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'John Henry'),
    4
),
-- Wyatt Earp
(
    'You Just Gonna Stand There And Bleed?',
    3,
    5,
    1,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    1
),
(
    'I Have Two Guns, One For Each Of You',
    3,
    4,
    1,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    1
),
(
    'Second Shot',
    2,
    2,
    1,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    1
),
(
    'Fan The Hammer',
    2,
    1,
    3,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    1
),
(
    'You''re A Daisy If You Do',
    2,
    4,
    3,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    2
),
(
    'A Marshal And An Outlaw',
    3,
    3,
    2,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    2
),
(
    'I''m Your Huckleberry',
    3,
    3,
    2,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    2
),
(
    'Gunfight At The O.K. Corral',
    2,
    2,
    3,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    2
),
(
    'Better Swear Me In',
    3,
    2,
    2,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    2
),
(
    'Bring ''Em To Justice',
    3,
    0,
    2,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    3
),
(
    'In Vino Veritas',
    2,
    NULL,
    3,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    4
),
(
    'You Die First',
    2,
    NULL,
    3,
    '/img/set/stars_and_stripes/heroes/wyatt_earp/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Wyatt Earp'),
    4
),
-- George Washington
(
    'Lead Astray',
    2,
    5,
    2,
    '/img/set/stars_and_stripes/heroes/washington/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    1
),
(
    'Agent 711',
    2,
    4,
    3,
    '/img/set/stars_and_stripes/heroes/washington/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    1
),
(
    'Circumvent',
    2,
    3,
    2,
    '/img/set/stars_and_stripes/heroes/washington/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    1
),
(
    'Sabotage',
    2,
    3,
    3,
    '/img/set/stars_and_stripes/heroes/washington/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    1
),
(
    'Allies Everywhere',
    3,
    1,
    3,
    '/img/set/stars_and_stripes/heroes/washington/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    1
),
(
    'Misinformation',
    3,
    4,
    2,
    '/img/set/stars_and_stripes/heroes/washington/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    2
),
(
    'Make A Stand',
    3,
    3,
    1,
    '/img/set/stars_and_stripes/heroes/washington/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    2
),
(
    'Feint',
    3,
    2,
    3,
    '/img/set/stars_and_stripes/heroes/washington/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    2
),
(
    'Recruit To The Ring',
    2,
    2,
    1,
    '/img/set/stars_and_stripes/heroes/washington/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    2
),
(
    'Network Of Spies',
    2,
    2,
    2,
    '/img/set/stars_and_stripes/heroes/washington/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    2
),
(
    'Undercover Agent',
    2,
    1,
    2,
    '/img/set/stars_and_stripes/heroes/washington/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    3
),
(
    'Sympathetic Stain',
    2,
    NULL,
    3,
    '/img/set/stars_and_stripes/heroes/washington/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    4
),
(
    'Gather Information',
    2,
    NULL,
    2,
    '/img/set/stars_and_stripes/heroes/washington/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'George Washington'),
    4
)
ON CONFLICT (hero_id, name, img_path) DO UPDATE SET
    count = excluded.count,
    card_type_id = excluded.card_type_id,
    value = excluded.value,
    boost = excluded.boost;
