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
    '/img/set/battle_of_legends1/heroes/sinbad/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'By Fortune and Fate',
    3,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Cannibals With the Root of Madness',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Creature With Eyes Like Coals of Fire',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the City of the King of Serendib',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Valley of the Giant Snakes',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage Home',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the City of the Man-Eating Apes',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Voyage to the Island That Was a Whale',
    1,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    1
),
(
    'Exploit',
    2,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Leap Away',
    2,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Momentous Shift',
    3,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/12.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Toil and Danger',
    4,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/13.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Feint',
    3,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/14.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Regroup',
    3,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/15.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    3
),
(
    'Riches Beyond Compare',
    2,
    '/img/set/battle_of_legends1/heroes/sinbad/cards/16.png',
    (SELECT id FROM heroes WHERE name = 'Sinbad'),
    4
),
-- Medusa
(
    'Second Shot',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    1
),
(
    'Gaze of Stone',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    1
),
(
    'Hiss and Slither',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    2
),
(
    'A Momentary Glance',
    2,
    '/img/set/battle_of_legends1/heroes/medusa/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    4
),
(
    'Clutching Claws',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    3
),
(
    'The Hounds of Mighty Zeus',
    2,
    '/img/set/battle_of_legends1/heroes/medusa/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    3
),
(
    'Winged Frenzy',
    2,
    '/img/set/battle_of_legends1/heroes/medusa/cards/11.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    4
),
(
    'Feint',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    3
),
(
    'Regroup',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    3
),
(
    'Dash',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    3
),
(
    'Snipe',
    3,
    '/img/set/battle_of_legends1/heroes/medusa/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Medusa'),
    3
)
ON CONFLICT (hero_id, name) DO UPDATE SET
    count = excluded.count,
    img_path = excluded.img_path,
    card_type_id = excluded.card_type_id;

INSERT INTO cards (name, count, value, img_path, hero_id, card_type_id)
VALUES
-- Battle of Legends, Volume One: King Arthur
(
    'Excalibur',
    1,
    6,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    1
),
(
    'The Lady of the Lake',
    1,
    NULL,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/13.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    4
),
(
    'Noble Sacrifice',
    3,
    2,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    1
),
(
    'The Aid of Morgana',
    1,
    4,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    1
),
(
    'The Holy Grail',
    1,
    1,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/11.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    2
),
(
    'Divine Intervention',
    2,
    3,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    3
),
(
    'Swift Strike',
    2,
    3,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    1
),
(
    'Prophecy',
    1,
    NULL,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/14.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    4
),
(
    'Command the Storms',
    2,
    NULL,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/15.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    4
),
(
    'Restless Spirits',
    1,
    NULL,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/16.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    4
),
(
    'Aid the Chosen One',
    1,
    4,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    1
),
(
    'Bewilderment',
    2,
    0,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/12.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    2
),
(
    'Momentous Shift',
    3,
    3,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    3
),
(
    'Regroup',
    3,
    1,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    3
),
(
    'Skirmish',
    3,
    4,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    3
),
(
    'Feint',
    3,
    2,
    '/img/set/battle_of_legends1/heroes/king_arthur/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'King Arthur'),
    3
),

-- Battle of Legends, Volume One: Alice
(
    'Snicker-Snack',
    1,
    3,
    '/img/set/battle_of_legends1/heroes/alice/cards/5.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    1
),
(
    'The Other Side of the Mushroom',
    1,
    3,
    '/img/set/battle_of_legends1/heroes/alice/cards/3.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    1
),
(
    'O Frabjous Day!',
    1,
    4,
    '/img/set/battle_of_legends1/heroes/alice/cards/2.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    1
),
(
    'I''m Late, I''m Late',
    3,
    2,
    '/img/set/battle_of_legends1/heroes/alice/cards/11.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),
(
    'Mad as a Hatter',
    2,
    3,
    '/img/set/battle_of_legends1/heroes/alice/cards/7.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),
(
    'Looking Glass',
    2,
    2,
    '/img/set/battle_of_legends1/heroes/alice/cards/13.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    2
),
(
    'Eat Me',
    2,
    NULL,
    '/img/set/battle_of_legends1/heroes/alice/cards/15.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    4
),
(
    'Drink Me',
    2,
    NULL,
    '/img/set/battle_of_legends1/heroes/alice/cards/14.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    4
),
(
    'Claws That Catch',
    2,
    3,
    '/img/set/battle_of_legends1/heroes/alice/cards/4.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    1
),
(
    'Jaws That Bite',
    2,
    4,
    '/img/set/battle_of_legends1/heroes/alice/cards/1.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    1
),
(
    'Manxome Foe',
    2,
    3,
    '/img/set/battle_of_legends1/heroes/alice/cards/9.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),
(
    'Momentous Shift',
    2,
    3,
    '/img/set/battle_of_legends1/heroes/alice/cards/8.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),
(
    'Regroup',
    3,
    1,
    '/img/set/battle_of_legends1/heroes/alice/cards/12.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),
(
    'Skirmish',
    2,
    4,
    '/img/set/battle_of_legends1/heroes/alice/cards/6.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),
(
    'Feint',
    3,
    2,
    '/img/set/battle_of_legends1/heroes/alice/cards/10.png',
    (SELECT id FROM heroes WHERE name = 'Alice'),
    3
),

-- Cobble & Fog: Dracula
(
    'Beastform',
    2,
    6,
    '/img/set/cobble_fog/heroes/dracula/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    1
),
(
    'Feeding Frenzy',
    2,
    2,
    '/img/set/cobble_fog/heroes/dracula/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    1
),
(
    'Do My Bidding',
    2,
    3,
    '/img/set/cobble_fog/heroes/dracula/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    2
),
(
    'Look Into My Eyes',
    2,
    1,
    '/img/set/cobble_fog/heroes/dracula/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    2
),
(
    'Mistform',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/dracula/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    4
),
(
    'Baptism of Blood',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/dracula/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    4
),
(
    'Prey Upon',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/dracula/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    4
),
(
    'Thirst for Sustenance',
    3,
    3,
    '/img/set/cobble_fog/heroes/dracula/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    1
),
(
    'Ambush',
    2,
    2,
    '/img/set/cobble_fog/heroes/dracula/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    1
),
(
    'Ravening Seduction',
    3,
    NULL,
    '/img/set/cobble_fog/heroes/dracula/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    4
),
(
    'Feint',
    3,
    2,
    '/img/set/cobble_fog/heroes/dracula/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    3
),
(
    'Dash',
    3,
    3,
    '/img/set/cobble_fog/heroes/dracula/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    3
),
(
    'Exploit',
    2,
    4,
    '/img/set/cobble_fog/heroes/dracula/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Dracula'),
    3
),

-- Cobble & Fog: Sherlock Holmes
(
    'Counterpunch',
    3,
    3,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    3
),
(
    'Deduce Strategy',
    3,
    3,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    3
),
(
    'The Game Is Afoot',
    2,
    5,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    1
),
(
    'Elementary',
    2,
    3,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    2
),
(
    'Confirm Suspicion',
    3,
    NULL,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    4
),
(
    'Eliminate the Impossible',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    4
),
(
    'Master of Disguise',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    4
),
(
    'Service Revolver',
    2,
    5,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    1
),
(
    'Fixed Point in a Changing Age',
    2,
    3,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    3
),
(
    'Administer Aid',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    4
),
(
    'Feint',
    3,
    2,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    3
),
(
    'Study Methods',
    2,
    3,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    3
),
(
    'Education Never Ends',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/sherlock_holmes/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Sherlock Holmes'),
    3
),

-- Cobble & Fog: Jekyll & Hyde
(
    'Succumb to Compulsion',
    3,
    2,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    3
),
(
    'Distracted Triage',
    2,
    3,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    3
),
(
    'With Haste!',
    2,
    4,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    2
),
(
    'Scientific Method',
    2,
    2,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    2
),
(
    'Calming Research',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    4
),
(
    'Recoiling Blow',
    2,
    5,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    1
),
(
    'Forever Hyde',
    2,
    5,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    1
),
(
    'Madness Relents',
    2,
    4,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    3
),
(
    'Pure Evil',
    3,
    NULL,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    4
),
(
    'Strange Case',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    4
),
(
    'Feint',
    3,
    2,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    3
),
(
    'Skirmish',
    3,
    4,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    3
),
(
    'Duality of Man',
    2,
    3,
    '/img/set/cobble_fog/heroes/jekyll_hyde/cards/6.webp',
    (SELECT id FROM heroes WHERE name = 'Jekyll & Hyde'),
    3
),

-- Cobble & Fog: Invisible Man
(
    'Slip Away',
    3,
    3,
    '/img/set/cobble_fog/heroes/invisible_man/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    1
),
(
    'Surprise Attack',
    2,
    5,
    '/img/set/cobble_fog/heroes/invisible_man/cards/1.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    1
),
(
    'Emerge from Mist',
    2,
    3,
    '/img/set/cobble_fog/heroes/invisible_man/cards/2.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    1
),
(
    'Coded Notes',
    2,
    3,
    '/img/set/cobble_fog/heroes/invisible_man/cards/9.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    2
),
(
    'Into Thin Air',
    2,
    4,
    '/img/set/cobble_fog/heroes/invisible_man/cards/8.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    2
),
(
    'Lurking',
    2,
    2,
    '/img/set/cobble_fog/heroes/invisible_man/cards/10.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    2
),
(
    'Rolling Fog',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/invisible_man/cards/11.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    4
),
(
    'Reign of Terror',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/invisible_man/cards/14.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    4
),
(
    'Vanish',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/invisible_man/cards/13.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    4
),
(
    'Step Lightly',
    2,
    NULL,
    '/img/set/cobble_fog/heroes/invisible_man/cards/12.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    4
),
(
    'Covert Preparation',
    3,
    2,
    '/img/set/cobble_fog/heroes/invisible_man/cards/7.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    3
),
(
    'Impossible to See',
    2,
    2,
    '/img/set/cobble_fog/heroes/invisible_man/cards/3.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    3
),
(
    'Confound',
    2,
    3,
    '/img/set/cobble_fog/heroes/invisible_man/cards/4.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    3
),
(
    'Dreaming of Revenge',
    2,
    3,
    '/img/set/cobble_fog/heroes/invisible_man/cards/5.webp',
    (SELECT id FROM heroes WHERE name = 'Invisible man'),
    3
)
ON CONFLICT (hero_id, name) DO UPDATE SET
    count = excluded.count,
    card_type_id = excluded.card_type_id,
    value = excluded.value,
    img_path = excluded.img_path;
