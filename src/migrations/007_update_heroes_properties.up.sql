ALTER TABLE heroes ADD COLUMN ability TEXT;
ALTER TABLE heroes ADD COLUMN attack_type TEXT
    CHECK(attack_type IN ('m', 'r'));

CREATE TABLE assistants (
    id INTEGER PRIMARY KEY,
    hero_id INTEGER NOT NULL REFERENCES heroes(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    count INTEGER NOT NULL CHECK(count > 0),
    hp_per_one INTEGER NOT NULL CHECK(hp_per_one > 0),
    attack_type TEXT NOT NULL CHECK(attack_type IN ('m', 'r')),
    UNIQUE(hero_id, name)
);

CREATE INDEX assistants_hero_idx ON assistants(hero_id);

UPDATE heroes
SET
    ability = 'At the start of your turn, you may deal 1 damage to an opposing fighter in Medusa''s zone.',
    attack_type = 'r'
WHERE name = 'Medusa';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Harpies', 3, 1, 'm'
FROM heroes
WHERE name = 'Medusa';

UPDATE heroes
SET
    ability = 'When you maneuver, you may move fighters +1 space for each VOYAGE card in your discard pile.',
    attack_type = 'm'
WHERE name = 'Sinbad';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'The Porter', 1, 6, 'm'
FROM heroes
WHERE name = 'Sinbad';

UPDATE heroes
SET
    ability = 'When you place Alice, choose whether she starts the game BIG or SMALL. When Alice is BIG, add 2 to the value of her attack cards. When Alice is SMALL, add 1 to the value of her defense cards.',
    attack_type = 'm'
WHERE name = 'Alice';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'The Jabberwock', 1, 8, 'm'
FROM heroes
WHERE name = 'Alice';

UPDATE heroes
SET
    ability = 'When you place Alice, choose whether she starts the game BIG or SMALL. When Alice is BIG, add 2 to the value of her attack cards. When Alice is SMALL, add 1 to the value of her defense cards.',
    attack_type = 'm'
WHERE name = 'King Arthur';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Merlin', 1, 7, 'r'
FROM heroes
WHERE name = 'King Arthur';

UPDATE heroes
SET
    ability = 'At the end of your turn, you may move Bruce Lee 1 space.',
    attack_type = 'm'
WHERE name = 'Bruce Lee';

UPDATE heroes
SET
    ability = 'At the end of your turn, if there are no opposing fighters in Bigfoot''s zone, you may draw 1 card.',
    attack_type = 'm'
WHERE name = 'Bigfoot';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'The Jackalope', 1, 6, 'm'
FROM heroes
WHERE name = 'Bigfoot';

UPDATE heroes
SET
    ability = 'After you attack, you may move your attacking fighter up to 2 spaces.',
    attack_type = 'r'
WHERE name = 'Robin Hood';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Outlaws', 4, 1, 'm'
FROM heroes
WHERE name = 'Robin Hood';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may place a trap. Whenever one of your traps is returned to the box, draw a card. Muldoon starts with 8 traps.',
    attack_type = 'r'
WHERE name = 'Robert Muldoon';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Ingen Worker', 3, 1, 'r'
FROM heroes
WHERE name = 'Robert Muldoon';

UPDATE heroes
SET
    ability = 'Raptors add 1 to the value of their attack cards for each of your other Raptors adjacent to the defender.',
    attack_type = 'm'
WHERE name = 'Raptors';

UPDATE heroes
SET
    ability = 'Start the game as Dr. Jekyll. At the start of your turn, you may transform into Dr. Jekyll or Mr. Hyde. While Mr. Hyde, after you maneuver, take 1 damage.',
    attack_type = 'm'
WHERE name = 'Jekyll & Hyde';

UPDATE heroes
SET
    ability = 'At the start of the game, after you place Invisible Man, place 3 fog tokens in separate spaces in his zone. When Invisible Man is on a space with a fog token, add 1 to the value of his defense cards. Invisible Man may move between two spaces with fog tokens as if they were adjacent.',
    attack_type = 'm'
WHERE name = 'Invisible Man';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may deal 1 damage to a fighter adjacent to Dracula. If you do, draw a card.',
    attack_type = 'm'
WHERE name = 'Dracula';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'The Sisters', 3, 1, 'm'
FROM heroes
WHERE name = 'Dracula';

UPDATE heroes
SET
    ability = 'Effects on HOLMES and DR. WATSON cards cannot be canceled by an opponent. Effects on ANY cards can be canceled.',
    attack_type = 'm'
WHERE name = 'Sherlock Holmes';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Dr. Watson', 1, 8, 'r'
FROM heroes
WHERE name = 'Sherlock Holmes';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may place a Shadow token in any space adjacent to Spike or Drusilla.',
    attack_type = 'm'
WHERE name = 'Spike';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Drusilla', 1, 7, 'm'
FROM heroes
WHERE name = 'Spike';

UPDATE heroes
SET
    ability = 'After Angel or Faith attacks, if you lost the combat, draw 1 card.',
    attack_type = 'm'
WHERE name = 'Angel';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Faith', 1, 8, 'm'
FROM heroes
WHERE name = 'Angel';

UPDATE heroes
SET
    ability = 'When Willow or Tara is dealt damage, Willow becomes Dark Willow. At the end of your turn, if Dark Willow is adjacent to Tara, she becomes Willow.',
    attack_type = 'r'
WHERE name = 'Willow';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Tara', 1, 6, 'r'
FROM heroes
WHERE name = 'Willow';

UPDATE heroes
SET
    ability = 'Buffy may move through spaces containing opposing fighters (including when she is moved by effects).',
    attack_type = 'm'
WHERE name = 'Buffy';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Giles/Xander', 1, 6, 'm'
FROM heroes
WHERE name = 'Buffy';

UPDATE heroes
SET
    ability = 'Beowulf starts with 1 Rage. When Beowulf is dealt damage, he gains 1 Rage. Beowulf has a maximum of 3 rage.',
    attack_type = 'm'
WHERE name = 'Beowulf';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Wiglaf', 1, 9, 'm'
FROM heroes
WHERE name = 'Beowulf';

UPDATE heroes
SET
    ability = 'Resolve an effect on a card you play if the symbol next to the effect matches the item in your basket. At the start of the game, place LITTLE RED''s BASKET in your discard pile. Little Red''s Basket: This starts in your discard pile. It does not count as a card. Card with all symbols counts as any one 🐺🌹⚔️ symbol.',
    attack_type = 'm'
WHERE name = 'Little Red';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Huntsman', 1, 9, 'r'
FROM heroes
WHERE name = 'Little Red';

UPDATE heroes
SET
    ability = 'After you attack, Deadpool recovers 1 health. Also, if your opponent''s real name is Logan, all your attacks are +5.',
    attack_type = 'm'
WHERE name = 'Deadpool';

UPDATE heroes
SET
    ability = 'If Yennenga would take damage, you may assign any amount of that damage to one or more Archers in her zone instead. (You may not assign more damage to an Archer that their remaining health.)',
    attack_type = 'r'
WHERE name = 'Yennenga';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Archers', 2, 2, 'r'
FROM heroes
WHERE name = 'Yennenga';

UPDATE heroes
SET
    ability = 'When Patroclus is defeated, discard 2 random cards.' || char(10) || char(10) || 'While Patroclus is defeated:' || char(10) || '- Add +2 to the value of all Achilles'' attacks.' || char(10) || '- If Achilles wins combat, draw 1 card.',
    attack_type = 'm'
WHERE name = 'Achilles';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Patroclus', 1, 6, 'm'
FROM heroes
WHERE name = 'Achilles';

UPDATE heroes
SET
    ability = 'At the start of your turn, if you have exactly 3 cards in hand, gain 1 action.',
    attack_type = 'm'
WHERE name = 'Bloody Mary';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may take 1 damage to summon a Clone in an empty space adjacent to Sun Wukong. Do not start with any Clones on the board.',
    attack_type = 'm'
WHERE name = 'Sun Wukong';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Clones', 3, 1, 'm'
FROM heroes
WHERE name = 'Sun Wukong';

UPDATE heroes
SET
    ability = 'Bullseye can attack from up to 5 spaces away (ignoring zones).',
    attack_type = 'r'
WHERE name = 'Bullseye';

UPDATE heroes
SET
    ability = 'DURING COMBAT: If you have 2 or fewer cards in your hand, you may BLIND BOOST your attack or defense. (If you have other DURING COMBAT effects, choose the order.)',
    attack_type = 'm'
WHERE name = 'Daredevil';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may take 1 damage to summon a Clone in an empty space adjacent to Sun Wukong. Do not start with any Clones on the board.',
    attack_type = 'm'
WHERE name = 'Elektra';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'The Hand', 4, 1, 'm'
FROM heroes
WHERE name = 'Elektra';

UPDATE heroes
SET
    ability = 'Moon Knight' || char(10) ||
    'At the start of your turn, move up to 2 spaces.' || char(10) ||
    'Khonshu' || char(10) ||
    'Khonshu adds +2 to the value of his attack cards. He does not take damage from effects other than combat damage.' || char(10) ||
    'Mr. Knight' || char(10) ||
    'Mr. Knight adds +1 to all his defense values.' || char(10) ||
    'At the end of your turn, change to your next identity (In order, Moon Knight -> Khonshu -> Mr. Knight, repeating).',
    attack_type = 'm'
WHERE name = 'Moon Knight';

UPDATE heroes
SET
    ability = 'Ghost Rider starts the game with 5 Hellfire. When you maneuver you may spend 1 Hellfire. If you do, increase Ghost Rider''s move value to 4, and he mave move through opposing fighters. Then deal 1 damage to each opposing fighter he moved through.',
    attack_type = 'm'
WHERE name = 'Ghost Rider';

UPDATE heroes
SET
    ability = 'Luke Cage takes 2 less combat damage from attacks.',
    attack_type = 'm'
WHERE name = 'Luke Cage';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Misty Knight', 1, 6, 'r'
FROM heroes
WHERE name = 'Luke Cage';

UPDATE heroes
SET
    ability = 'After Dr. Sattler or Dr. Malcolm move, place an insight token in their new space. You have 5 insight tokens. Whenever either of your fighters moves to a new space, place and insight token in their new space. Tokens may be placed in spaces with other tokens, including other insight tokens. There tokens have no effect themselves but any of your cards interact with them. When you remove insight tokens from the board, return them to your supply. You can place them on the board again in the future. If you would place an insight token but don''t have any in your supply, nothing happens.',
    attack_type = 'm'
WHERE name = 'Dr. Sattler';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Dr. Malcolm', 1, 7, 'm'
FROM heroes
WHERE name = 'Dr. Sattler';

UPDATE heroes
SET
    ability = 'T-Rex is a large fighter. (She can attack up to 2 spaces away.) At the end of your turn, draw a card. Large fighters have an extended base that can occupy up to two spaces. Large fighters may start moving from any space they are in. When they do, rotate them so that the head is moving into the new space. Their tail always follows behind their head, entering the space the left. Large fighters also ignore one-way arrows on maps and cannot use secret passages. Large fighters can attack up to 2 spaces away, even over fighters that occupy one of those spaces.',
    attack_type = 'm'
WHERE name = 'T. Rex';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may discard 1 card to gain 1 action.',
    attack_type = 'r'
WHERE name = 'The Genie';

UPDATE heroes
SET
    ability = 'When you take the maneuver action and BOOST, you may place Houdini in any space instead of moving. (Bess moves as normal.)',
    attack_type = 'm'
WHERE name = 'Harry Houdini';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Bess', 1, 5, 'm'
FROM heroes
WHERE name = 'Harry Houdini';

UPDATE heroes
SET
    ability = 'After you attack, if Cloak dealt at least 2 combat damage, your opponent discards 1 card.' || char(10) ||
    'After you attack, if Dagger dealt at least 2 combat damage, gain 1 action.',
    attack_type = 'm'
WHERE name = 'Cloak Dagger';

UPDATE heroes
SET
    ability = 'At the start of your turn, summon a squirrel in a space adjacent to Squirrel Girl. Squirrels are small fighters. Do not start with any squirrels on the board.',
    attack_type = 'm'
WHERE name = 'Squirrel Girl';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may move Ms. Marvel 1 space. Ms. Marvel can attack from up to 2 spaces away (ignoring zones).',
    attack_type = 'm'
WHERE name = 'Ms. Marvel';

UPDATE heroes
SET
    ability = 'Before drawing your starting hand, add THE MOSCOW PROTOCOL card to your hand. Then, shuffle your deck and draw 5 cards. (Your starting hand is 6 cards instead of 5.)',
    attack_type = 'r'
WHERE name = 'Black Widow';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Maria Hill', 1, 6, 'r'
FROM heroes
WHERE name = 'Black Widow';

UPDATE heroes
SET
    ability = 'Effects on Winter Soldier''s cards cannot be canceled.',
    attack_type = 'r'
WHERE name = 'Winter Soldier';

UPDATE heroes
SET
    ability = 'Whenever you BOOST, draw 1 card. Cards stored in your VIBRANIUM SUIT can only be used to BOOST.',
    attack_type = 'm'
WHERE name = 'Black Panther';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Shuri', 1, 6, 'r'
FROM heroes
WHERE name = 'Black Panther';

UPDATE heroes
SET
    ability = 'When an opponent attacks Spider-Man, before you play a defense card, they must tell you the printed value of their card.',
    attack_type = 'm'
WHERE name = 'Spiderman';

UPDATE heroes
SET
    ability = 'After each combat, if Doctor Strange played a card, you may deal 1 damage to him. If you do, put that card on the bottom of your deck and draw 1 card.',
    attack_type = 'r'
WHERE name = 'Doctor Strange';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Wong', 1, 6, 'r'
FROM heroes
WHERE name = 'Doctor Strange';

UPDATE heroes
SET
    ability = 'At the start of your turn, you may discard a card to deal damage equal to its BOOST value to a fighter in your zone.',
    attack_type = 'm'
WHERE name = 'She Hulk';

UPDATE heroes
SET
    ability = 'If you haven''t taken a Maneuver action this turn, add +2 to the value of Golden Bat''s attacks.',
    attack_type = 'm'
WHERE name = 'Golden Bat';

UPDATE heroes
SET
    ability = 'Add +2 to the value of Annie''s attacks if she has less health than the defender.',
    attack_type = 'm'
WHERE name = 'Annie Christmas';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Charlie', 1, 8, 'r'
FROM heroes
WHERE name = 'Annie Christmas';

UPDATE heroes
SET
    ability = 'At the start of your turn, activate one of your gadgets.' || char(10) ||
    'Whenever Jill Trent attacks, resolve the active gadget''s effect.' || char(10) || char(10) ||
    'Hypnoray Blaster' || char(10) ||
    'DURING COMBAT: If your card's printed value is lower than your opponent's, reveal the top card of your opponent''s deck. Increase the value of your attack by the BOOST value of the revealed card.' || char(10) || char(10) ||
    'Ultrabiotic Tonic' || char(10) ||
    'AFTER COMBAT: If your card''s printed value is higher than your opponent''s, Jill Trent Recovers 1 health.',
    attack_type = 'm'
WHERE name = 'Dr. Jill Trent';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Daisy', 1, 8, 'm'
FROM heroes
WHERE name = 'Dr. Jill Trent';

UPDATE heroes
SET
    ability = 'Start the game with 1 coil charged.' || char(10) ||
    'At the end of your turn, charge 1 coil.' || char(10) ||
    'At the start of your turn, if both coils are charged, deal 1 damage to each opposing fighter adjacent to Tesla and move them up to 1 space.',
    attack_type = 'r'
WHERE name = 'Nikola Tesla';

UPDATE heroes
SET
    ability = 'When an opposing hero leaves Tomoe Gozen''s zone, deal 1 damage to that hero. If only I could find a worthy foe.',
    attack_type = 'r'
WHERE name = 'Tomoe Gozen';

UPDATE heroes
SET
    ability = 'Other friendly fighters in Oda Nobunaga''s zone add +1 to the value of their played combat cards. (Oda Nobunaga does not benefit from this ability.)',
    attack_type = 'm'
WHERE name = 'Oda Nobunaga';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Honor Guard', 2, 6, 'm'
FROM heroes
WHERE name = 'Oda Nobunaga';

UPDATE heroes
SET
    ability = 'After you attack or defend, add your card to your line. When your line has 10 or more syllables, discard your line. If there are exactly 10 syllables, resolve the completion effect on the last card.',
    attack_type = 'm'
WHERE name = 'Shakespeare';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Actor', 3, 1, 'm'
FROM heroes
WHERE name = 'Shakespeare';

UPDATE heroes
SET
    ability = 'If you do not have a face-up glamour at the start of your turn, flip the top card of your glamour deck face-up. Its effect is ongoing while it remains face-up.',
    attack_type = 'r'
WHERE name = 'Titania';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Oberon', 1, 6, 'm'
FROM heroes
WHERE name = 'Titania';

UPDATE heroes
SET
    ability = 'Your cards go into your cauldron instead of your discard pile. After you attack, you may cast one spell that you have the ingredients for If you do, discard all the cards in your cauldron.',
    attack_type = 'm'
WHERE name = 'The Wayward Sisters';

UPDATE heroes
SET
    ability = 'At the start of your turn, choose TO BE or NOT TO BE. If you choose NOT TO BE, deal 2 damage to one of your fighters.' || char(10) ||
    'TO BE: When you maneuver, draw 1 additional card.' || char(10) ||
    'NOT TO BE: Add +2 to the value of Hamlet''s attacks.',
    attack_type = 'm'
WHERE name = 'Hamlet';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Rosencrantz & Guildenstern', 1, 6, 'm'
FROM heroes
WHERE name = 'Hamlet';

UPDATE heroes
SET
    ability = 'While all of your Red Riders are defeated, Eredin is ENRAGED. If Eredin is ENRAGED, add +1 to the value of your combat cards, and your move value is 3.'
    attack_type = 'm'
WHERE name = 'Eredin';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Red Rider', 4, 1, 'm'
FROM heroes
WHERE name = 'Eredin';

UPDATE heroes
SET
    ability = 'At the end of your turn, you may draw until you have a hand of 4 cards.'
    attack_type = 'r'
WHERE name = 'Philippa';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Dijkstra', 1, 6, 'm'
FROM heroes
WHERE name = 'Philippa';

UPDATE heroes
SET
    ability = 'At the beginning of the game, choose Yennefer or Triss to be your hero.' || char(10) || char(10) ||
    'Sorceress of Vengerberg' || char(10) ||
    'IMMEDIATELY: If Yennefer is attacking, you may BOOST her attack. (This effect cannot be canceled.)' || char(10) || char(10) ||
    'Merigold the Fearless' || char(10) ||
    'After Triss plays a scheme, deal 2 damage to a fighter adjacent to Triss.',
    attack_type = 'r'
WHERE name = 'Yennefer & Triss';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Yennefer/Triss', 1, 6, 'r'
FROM heroes
WHERE name = 'Yennefer & Triss';

UPDATE heroes
SET
    ability = 'At the start of the game, choose your gear. Select a POTION, ARMOR, and SWORD, and shuffle 2 copies of each into your deck.',
    attack_type = 'm'
WHERE name = 'Geralt of Rivia';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Dandelion', 1, 5, 'r'
FROM heroes
WHERE name = 'Geralt of Rivia';

UPDATE heroes
SET
    ability = 'Add +3 to the value of the Leshen''s attacks if it already attacked this turn. Your Wolves have a move value of 3.',
    attack_type = 'r'
WHERE name = 'Ancient Leshen';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Wolf', 2, 1, 'm'
FROM heroes
WHERE name = 'Ancient Leshen';

UPDATE heroes
SET
    ability = '🔵 x7 | Effects on Ciri''s cards cannot be canceled.',
    attack_type = 'm'
WHERE name = 'Ciri';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Ihuarraquax', 1, 7, 'm'
FROM heroes
WHERE name = 'Ciri';

UPDATE heroes
SET
    ability = 'After you attack, you may draw a card.',
    attack_type = 'm'
WHERE name = 'Chupacabra';

UPDATE heroes
SET
    ability = 'PRIVATEER TURNED PIRATE' || char(10) ||
    'Start the game with 1 doubloon in the treasury, you have the other 2.' || char(10) ||
    '- At the start of your turn, you may pay 1 doubloon to gain 1 action.' || char(10) ||
    '- When Blackbeard takes combat damage, pay 1 doubloon.' || char(10) || char(10) ||
    'BLACKBEARD''S DOUBLOONS' || char(10) ||
    'Doubloons that Blackbeard doesn''t have are kept in the Treasury.' || char(10) || char(10) ||
    'Blackbeard pays a doubloon to the Treasury when he takes combat damage. He may also pay a doubloon at the start of his turn to gain an extra action.' || char(10) || char(10) ||
    'The effects on many of Blackbeard''s cards can be ignored by paying a ransom. Any opponent can pay the amount of doubloons shown at the end of an effect to ignore that effect. These doubloons are taken from the Treasury and given to Blackbeard.',
    attack_type = 'r'
WHERE name = 'Blackbeard';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Seadog', 2, 1, 'm'
FROM heroes
WHERE name = 'Blackbeard';

UPDATE heroes
SET
    ability = 'PANDORA''S BOX' || char(10) ||
    'Do not start with any Kakodamons on the board.' || char(10) ||
    'At the start of your turn, open Pandora''s Box.' || char(10) || char(10) ||
    'Pandora''s Box is a deck of seven cards called MISERIES.' || char(10) ||
    'When you open Pandora''s Box, reveal the top card and resolve its effect if any). You may keep revealing and resolving additional cards, one at a time, until you choose to stop.' || char(10) ||
    'If there are three or more total feathers on revealed cards, you must stop revealing, then Pandora takes 1 damage for each revealed MISERY.' || char(10) ||
    'At the end of your turn, shuffle all revealed MISERIES back into Pandora''s Box.',
    attack_type = 'm'
WHERE name = 'Pandora';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Kakodaemon', 2, 1, 'm'
FROM heroes
WHERE name = 'Pandora';

UPDATE heroes
SET
    ability = 'After you play a TRICK, put that card into your opponent''s hand instead of your discard pile.' || char(10) ||
    'If an opponent discards a TRICK from their hand, return that card to your hand or the top of your deck.' || char(10) ||
    'Add +1 to your move value for each' || char(10) ||
    'TRICK in your opponents hands.',
    attack_type = 'm'
WHERE name = 'Loki';

UPDATE heroes
SET
    ability = 'On each of your turns, the first time you lose combat, gain 1 action.',
    attack_type = 'm'
WHERE name = 'Raphael';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Casey Jones', 1, 8, 'r'
FROM heroes
WHERE name = 'Raphael';

UPDATE heroes
SET
    ability = 'When you maneuver, you may draw 2 cards instead of 1. If you do, put a card in your hand on the bottom of your deck. After you play an invention, tuck it under this card. For the rest of the game, its invention bonus applies.',
    attack_type = 'm'
WHERE name = 'Donatello';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Metalhead', 1, 7, 'm'
FROM heroes
WHERE name = 'Donatello';

UPDATE heroes
SET
    ability = 'After you attack or scheme, draw 1 card. Your starting and maximum hand size is 3.',
    attack_type = 'm'
WHERE name = 'Michelangelo';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, ' April O''neil', 1, 6, 'r'
FROM heroes
WHERE name = 'Michelangelo';

UPDATE heroes
SET
    ability = 'At the start of your turn, move any fighter up to 1 space.',
    attack_type = 'm'
WHERE name = 'Leonardo';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Splinter', 1, 9, 'm'
FROM heroes
WHERE name = 'Leonardo';

UPDATE heroes
SET
    ability = 'At the start of your turn, deploy a Foot soldier to a path adjacent to a friendly fighter.' || char(10) ||
    'You may attack opposing fighters adjacent to Foot soldiers.' || char(10) ||
    'If an opponents boosts their maneuver, they may remove any Foot soldier their hero moves through.',
    attack_type = 'm'
WHERE name = 'Shredder';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Bebop & Rocksteady', 1, 7, 'm'
FROM heroes
WHERE name = 'Shredder';

UPDATE heroes
SET
    ability = 'Krang has 3 doomsday machines. Start with one machine active. After you roll the Dice of Ultimate Destruction, you can deactivate an active machine to reroll the die. Add +1 to your move value for each active machine.',
    attack_type = 'm'
WHERE name = 'Krang';

UPDATE heroes
SET
    ability = 'Begin the game with your stance on Float Like a Butterfly. After you attack, if you won the combat, change stances.' || char(10) || char(10) ||
    'FLOAT LIKE A BUTTERFLY' || char(10) ||
    'You can attack from 2 spaces away.' || char(10) || char(10) ||
    'STING LIKE A BEE' || char(10) ||
    'Add +2 to your attacks.',
    attack_type = 'm'
WHERE name = 'Muhammad Ali';

UPDATE heroes
SET
    ability = 'You have 4 upgrade tokens. Start the game with all 4 inactive. At the start of your turn, activate an upgrade. At the end of your turn, if all 4 upgrades are active, deactivate all of them.',
    attack_type = 'm'
WHERE name = 'Rosie The Riveter';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Wendy The Welder', 1, 7, 'm'
FROM heroes
WHERE name = 'Rosie The Riveter';

UPDATE heroes
SET
    ability = 'You have 10 track tokens. At the start of your turn, summon a track token in a space in John Henry''s zone. When you move John Henry, do not count spaces with track tokens.',
    attack_type = 'm'
WHERE name = 'John Henry';

UPDATE heroes
SET
    ability = 'After you attack and win combat, choose one effect. You cannot choose the same effect twice in a turn.' || char(10) ||
    '• draw 1 card' || char(10) ||
    '• gain 1 free action to attack' || char(10) ||
    '• move your fighter up to 1 space',
    attack_type = 'r'
WHERE name = 'Wyatt Earp';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Doc Holliday', 1, 8, 'r'
FROM heroes
WHERE name = 'Wyatt Earp';

UPDATE heroes
SET
    ability = 'You start with 4 ruse tokens. When you attack, you may use a ruse token, placing it next to the card. Before your opponent chooses whether or not to defend, they may discard 1 random card to remove the ruse token.',
    attack_type = 'm'
WHERE name = 'George Washington';

INSERT INTO assistants (hero_id, name, count, hp_per_one, attack_type)
SELECT id, 'Culper spy', 3, 1, 'm'
FROM heroes
WHERE name = 'George Washington';