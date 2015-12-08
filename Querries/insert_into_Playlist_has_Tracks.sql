-- Insert Into playlist_has_tracks

INSERT INTO Playlist_has_Tracks VALUES (1, 'Freedom', 'Akon');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Let\'s Stay Together', 'Al Green');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Not For Long (feat. Trey Songz)', 'B.o.B');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Missing You', 'Betty Who');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Treasure', 'Bruno Mars');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Why Did You Lie to Me', 'Bryan Lee');
INSERT INTO Playlist_has_Tracks VALUES (1, 'In the Dark', 'Charlie Puth');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Some Type of Love', 'Charlie Puth');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Get Lucky (Radio Edit) [feat. Pharrell Williams]', 'Daft Punk');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Don\'t', 'Ed Sheeran');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Love Me Like You Do (From "Fifty Shades Of Grey")', 'Ellie Goulding');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Let Me Blow Ya Mind', 'Eve');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Worth It (feat. Kid Ink)', 'Fifth Harmony');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Some Nights', 'Fun.');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Hazey', 'Glass Animals');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Fancy (feat. Charli XCX)', 'Iggy Azalea');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Fast Car (Prod by J.R Rotem)', 'Ilya');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Shots', 'Imagine Dragons');
INSERT INTO Playlist_has_Tracks VALUES (1, 'SexyBack', 'Justin Timberlake');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Thrift Shop (feat. Wanz)', 'Macklemore & Ryan Lewis');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Beautiful', 'Mali Music');
INSERT INTO Playlist_has_Tracks VALUES (1, 'How Do I Breathe', 'Mario');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Uptown Funk (feat. Bruno Mars)', 'Mark Ronson');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Because of You', 'Ne-Yo');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Down In the Valley', 'Otis Redding');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Time of Our Lives', 'Pitbull & Ne-Yo');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Nobody\'s Business (feat. Chris Brown)', 'Rihanna');
INSERT INTO Playlist_has_Tracks VALUES (1, 'FourFiveSeconds', 'Rihanna and Kanye West and Paul McCartney');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Shoop', 'Salt-n-Pepa');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Style', 'Taylor Swift');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Blank Space', 'Taylor Swift');
INSERT INTO Playlist_has_Tracks VALUES (1, 'Can\'t Feel My Face', 'The Weeknd');
INSERT INTO Playlist_has_Tracks VALUES (1, 'All Hands On Deck', 'Tinashe');
Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`WCS`.`Playlist_has_Tracks`, CONSTRAINT `fk_Playlist_has_tracks_Playlist` FOREIGN KEY (`playlist_id`) REFERENCES `Playlist` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION)
