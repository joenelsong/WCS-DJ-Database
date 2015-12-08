<?php
include('connectionData.txt');

$mysqli = new mysqli($server, $user, $pass, $dbname, $port, 'MySQL');
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
/* create a prepared statement */
$sql = "SELECT track_artist, cs as 'Count'
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
ORDER BY t1.cs DESC";


if (!($stmt = $mysqli->prepare($sql))) {
	echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

if (!$stmt->execute()) {
	echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
}

?>

<html>
	<head>
  		<title>Most Popular WCS Artists</title>
	</head>
  	<body bgcolor="white">
    	<hr>
  
<p>
The query: "Artist Name" Followed by "Number of times Played"
<p>

<hr>
<p>
Result of query:
<p>

<?php
$out_description    = NULL;
$out_revenues = NULL;
if (!$stmt->bind_result($out_description, $out_revenues)) {
    echo "Binding output parameters failed: (" . $stmt->errno . ") " . $stmt->error;
}

while ($stmt->fetch()) {
    printf("%20s %12s", $out_description, $out_revenues);
    echo "\r\n"; // Newlines won't work! :(
    //print PHP_EOL;
}

?>

<p>
<hr>
</body>
</html>