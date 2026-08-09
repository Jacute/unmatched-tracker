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
),
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
    3
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
    'Son Of A Boxer',
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
)
ON CONFLICT (hero_id, name) DO UPDATE SET
    count = excluded.count,
    card_type_id = excluded.card_type_id,
    value = excluded.value,
    boost = excluded.boost,
    img_path = excluded.img_path;