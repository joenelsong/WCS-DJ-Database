SELECT track_artist, cs as 'Count'
FROM
	(
	SELECT track_artist, COUNT(*) as cs
	FROM Toplist_has_Tracks
    GROUP BY track_artist

	UNION ALL

	SELECT track_artist, COUNT(*) as cs
	FROM RadioStation_has_Tracks
    GROUP BY track_artist
    
    UNION ALL

	SELECT track_artist, COUNT(*) as cs
	FROM RadioStation_has_Tracks
    GROUP BY track_artist
    
    UNION ALL

	SELECT track_artist, COUNT(*) as cs
	FROM Playlist_has_Tracks
    GROUP BY track_artist
	) t1
GROUP BY t1.track_artist
ORDER BY t1.cs DESC
;

