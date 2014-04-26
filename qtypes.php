<html>
<?php include_once "header.php"; ?>
<body>

<?php

//connect to the database
$dbconn = pg_Connect("host=rabbit.cs.pdx.edu dbname=query_practice user=censoredUser password=censored");
if (!$dbconn) {
	die;
}

//print the data from query_practice
function printResult($query){
	$result = pg_query($query);

	$i = 0;
	echo '<html><body><table id="content" border="1"><tr>';
	while ($i < pg_num_fields($result))
	{
		$fieldName = pg_field_name($result, $i);
		if($fieldName == 'q_id'){
			$fieldName = "";
		}elseif($fieldName == 'eng_stmt'){
			$fieldName = "English";
		}elseif($fieldName == 'ra'){
			$fieldName = "Relational Algebra";
		}
		echo '<td><strong>' . $fieldName . '</strong></td>';
		$i = $i + 1;
	}
	echo '</tr>';
	$i = 0;

	while ($row = pg_fetch_row($result))
	{
		echo '<tr>';
		$count = count($row);

		$y = 0;
		while ($y < $count)
		{
			$c_row = current($row);
			if (strpos($c_row, '.png') != FALSE){
				echo '<td><img src="http://web.cecs.pdx.edu/~letien/CS586GradProject/img/'.$c_row.'"/></td>';
			}elseif (strlen($c_row) < 3){
				echo '<td><a href="http://web.cecs.pdx.edu/~letien/CS586GradProject/result.php?q_id='. $c_row .'">Result</a></td>';
			}
			else{
				echo '<td>' . $c_row . '</td>';
			}
			next($row);
			$y = $y + 1;
		}
		echo '</tr>';
		$i = $i + 1;
	}
	pg_free_result($result);

	echo '</table></body></html>';

}

$checkvar2 = $_POST['checkboxvar2'];   // checkbox of hiding aspect
$countvar2 = count($checkvar2);

if (isset($_POST['checkboxvar']) ){ // chose 1 or more query types

	$check = $_POST['checkboxvar'];  // checkbox of query types
	$count = count($check);
	$condition = implode(",",$check); // these chosen query types to be represented

	// handle hiding aspect
	if($countvar2 == 1){
		if($checkvar2[0] == '123'){
			echo "<span style='color: blue; font-size: 8pt'>Hide English Statement<br>";
			$query = "select q.q_id, q.sql, q.ra from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
			printResult($query);
		}elseif ($checkvar2[0] == '124'){
			echo "<span style='color: blue; font-size: 8pt'>Hide SQL<br>";
			$query = "select q.q_id, q.eng_stmt, q.ra from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
			printResult($query);
		}elseif ($checkvar2[0] == '125'){
			echo "<span style='color: blue; font-size: 8pt'>Hide Relational Algebra<br>";
			$query = "select q.q_id, q.eng_stmt, q.sql from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
			printResult($query);
		}
	}elseif ($countvar2 == 2){
		if ( ($checkvar2[0] == '123') && ($checkvar2[1] == '124') ) {
			echo "<span style='color: blue; font-size: 8pt'>Hide English Statement and SQL<br>";
			$query = "select q.q_id, q.ra from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
			printResult($query);
		}elseif ( ($checkvar2[0] == '123') && ($checkvar2[1] == '125')  ) {
			echo "<span style='color: blue; font-size: 8pt'>Hide English Statement and Relational Algebra<br>";
			$query = "select q.q_id, q.sql from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
			printResult($query);
		}elseif ( ($checkvar2[0] == '124') && ($checkvar2[1] == '125')  ) {
			echo "<span style='color: blue; font-size: 8pt'>Hide SQL and Relational Algebra<br>";
			$query = "select q.q_id, q.eng_stmt from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
			printResult($query);
		}
	}elseif ($countvar2 == 3){
		echo "<span style='color: red'>You can only hide maximum 2 out of 3! Please choose again";
	}else{
		$query = "select * from query q where q.q_id IN (select qr.q_id from queryqtyperel qr where qr.qt_id IN (".$condition.") group by qr.q_id having count(1) = ".$count.");";
		printResult($query);
	}

}else{ // not choose any query type, default option is ALL query types will be chosen
	if($countvar2 == 1){
		if($checkvar2[0] == '123'){
			echo "<span style='color: blue; font-size: 8pt'>Hide English Statement<br>";
			$query = "select q.q_id, q.sql, q.ra from query q;";
			printResult($query);
		}elseif ($checkvar2[0] == '124'){
			echo "<span style='color: blue; font-size: 8pt'>Hide SQL<br>";
			$query = "select q.q_id, q.eng_stmt, q.ra from query q;";
			printResult($query);
		}elseif ($checkvar2[0] == '125'){
			echo "<span style='color: blue; font-size: 8pt'>Hide Relational Algebra<br>";
			$query = "select q.q_id, q.eng_stmt, q.sql from query q;";
			printResult($query);
		}
	}elseif ($countvar2 == 2){
		if ( ($checkvar2[0] == '123') && ($checkvar2[1] == '124') ) {
			echo "<span style='color: blue; font-size: 8pt'>Hide English Statement and SQL<br>";
			$query = "select q.q_id, q.ra from query q;";
			printResult($query);
		}elseif ( ($checkvar2[0] == '123') && ($checkvar2[1] == '125')  ) {
			echo "<span style='color: blue; font-size: 8pt'>Hide English Statement and Relational Algebra<br>";
			$query = "select q.q_id, q.sql from query q;";
			printResult($query);
		}elseif ( ($checkvar2[0] == '124') && ($checkvar2[1] == '125')  ) {
			echo "<span style='color: blue; font-size: 8pt'>Hide SQL and Relational Algebra<br>";
			$query = "select q.q_id, q.eng_stmt from query q;";
			printResult($query);

		}
	}elseif ($countvar2 == 3){
		echo "<span style='color: red'>You can only hide maximum 2 out of 3! Please choose again";
	}else{
		$query = "select * from query q;";
		printResult($query);
	}
}

?>

<td>
	<img width="50%" src="http://web.cecs.pdx.edu/~letien/CS586GradProject/img/TableList.png"/>
</td>

<br>
<button onclick="history.go(-1);">Back</button>
</body>
<?php include_once"footer.php" ?>
</html>