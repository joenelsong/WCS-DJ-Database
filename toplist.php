<?php
include('connectionData.txt');

$mysqli = new mysqli($server, $user, $pass, $dbname, $port, 'MySQL');
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}

/* create a prepared statement */
//$sql = "SELECT s.description as 'Item Description', sum(i.total_price) as 'Revenues' FROM stock s JOIN manufact m using(manu_code) JOIN items i using(stock_num) WHERE m.manu_name = ? group by s.description";
/* create a prepared statement */
$sql = "INSERT INTO DJ (ai, name, city, state, country, years_exp) VALUES (?, ?, ?, ?, ?, ?)";


if (!($stmt = $mysqli->prepare($sql))) {
	echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

/* Prepared statement, stage 2: bind and execute */
$ai = "";
$n = $_POST['dj_name'];
$u = $_POST['dj_url'];
$city = $_POST['dj_city'];
$s = $_POST['dj_state'];
$country= $_POST['dj_country'];
$y = $_POST['dj_years_exp'];

//$m = 'Anza';
if (!$stmt->bind_param("sssssss", $n, $u, $city, $s, $country, $y)) { // bind variables
    echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
}
 
if (!$stmt->execute()) {
	echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
}

?>

<html>
<head>
  <title>Another Simple PHP-MySQL Program</title>
  </head>
  
  <body bgcolor="white">
  
  
  <hr>
  
  
<?php
  

?>

<p>
DJ Registration:
<p>
<?php
?>

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

<p>
<a href="findCustState.txt" >Contents</a>
of the PHP program that created this page. 	 
 
</body>
</html>