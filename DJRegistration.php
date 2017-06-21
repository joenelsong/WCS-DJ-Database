<?php
include('./Private/connectionData.txt');

try {
$pdo = new PDO("mysql:host=$server;dbname=$dbname", $user, $pass);
 echo "Connected to $dbname at $host successfully.";
} catch (PDOException $pe) {
    die("Could not connect to the database $dbname :" . $pe->getMessage());
}

/* create a prepared statement */
//$sql = "INSERT INTO DJ (dj_id, dj_name, dj_city, dj_state, dj_country, dj_experience, dj_url) VALUES (?, ?, ?, ?, ?, ?, ?)";


// if (!($stmt = $mysqli->prepare($sql))) {
// 	echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
// }

/* Prepared statement, stage 2: bind and execute */
$ai = "";
$n = $_POST['dj_name'];
$city = $_POST['dj_city'];
$s = $_POST['dj_state'];
$country= $_POST['dj_country'];
$y = $_POST['dj_years_exp'];
$u = $_POST['dj_url'];

// Bind Parameters
$task = array(':dj_id' => $ai,
							':dj_name' => $n,
							':dj_city' => $city,
							':dj_state' => $s,
							':dj_country' => $country,
							':dj_experience' => $y,
							':dj_url' => $u);


$sql = 'INSERT INTO DJ (
							dj_id,
							dj_name,
							dj_city,
							dj_state,
							dj_country,
							dj_experience,
							dj_url
						)
						VALUES (
									:dj_id,
									:dj_name,
									:dj_city,
									:dj_state,
									:dj_country,
									:dj_experience,
									:dj_url
						);';


$q = $pdo->prepare($sql); // prepare statement

$q->execute($task);

$pdo=null; // Close PDO connection to database like using mysqli.close();
?>

<html>
<head>
  <title>DJ Database Registration</title>
  </head>
  
  <body bgcolor="white">
  
  
  <hr>
  


<p>
DJ Registration Complete. ( We will check you out soon! )
<p>
<hr>


</body>
</html>