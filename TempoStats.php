<?php
include('connectionData.txt');

$mysqli = new mysqli($server, $user, $pass, $dbname, $port, 'MySQL');
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
/* create a prepared statement */
$sql = "SELECT MIN(t.bpm) as min, MAX(t.bpm) as max, AVG(t.bpm) as av FROM Track t WHERE t.bpm !='' ;";

if (!($stmt = $mysqli->prepare($sql))) {
	echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

if (!$stmt->execute()) {
	echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
}

?>

<html>
	<head>
  		<title>WCS Song Tempo Statistics</title>
	</head>
  	<body bgcolor="white">
    	<hr>
  
<p>
The query: "Min, Max, and Avg Beats Per Minute of all WCS songs in the database"
<p>

<hr>
<p>
Result of query:
<p>

<?php
$out_description    = NULL;
$out_revenues = NULL;
if (!$stmt->bind_result($a, $b, $c)) {
    echo "Binding output parameters failed: (" . $stmt->errno . ") " . $stmt->error;
}

while ($stmt->fetch()) {
    printf("Minimum Beats Per Minute: %s ", $a);
    echo "\r\n"; // Newlines won't work! :(
    printf("Maximum Beats Per Minute: %s ", $b);
    echo "\r\n"; // Newlines won't work! :(
    printf("Average Beats Per Minute: %s ", $c);
    echo "\r\n"; // Newlines won't work! :(
    //print PHP_EOL;
}

?>

<p>
<hr>
</body>
</html>