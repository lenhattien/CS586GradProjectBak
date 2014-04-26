<html>
<?php  include_once "header.php"; ?>
<body>
<?php

//connect to the database
$dbconn = pg_Connect("host=rabbit.cs.pdx.edu dbname=query_practice user=censoredUser password=censored");
if (!$dbconn) {
	die;
}

//print the data from query_practice
function printResult($query){
	$sql_query = "";
	$result = pg_query($query);

	$i = 0;
	echo '<html><body><table id="content" border="1"><tr>';
	while ($i < pg_num_fields($result))
	{
		$fieldName = pg_field_name($result, $i);
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
			}elseif (strpos($c_row, ';') != FALSE){
				$sql_query = $c_row;
				echo '<td>' . $c_row . '</td>';
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
	return $sql_query;
}

function printResultFromCarRental($query){
	//connect to the database
	$dbconn1 = pg_Connect("host=rabbit.cs.pdx.edu dbname=car_rental user=censoredUser password=censored");
	if (!$dbconn1) {
		die;
	}


	$result = pg_query($query);


	$i = 0;
	echo '<html><body><table id="result" border="2"><tr>';
	while ($i < pg_num_fields($result))
	{
		$fieldName = pg_field_name($result, $i);
		echo '<td><strong>' . $fieldName . '<strong></td>';
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
			echo '<td>' . $c_row . '</td>';
			next($row);
			$y = $y + 1;
		}
		echo '</tr>';
		$i = $i + 1;
	}
	pg_free_result($result);

	echo '</table></body></html>';
}


if (isset($_GET['q_id']))
{
	$q_id = pg_escape_string($_GET['q_id']); // remove spec char
	$query = "select q.eng_stmt, q.sql, q.ra from query q where q.q_id=".$q_id;
	$sql_query = printResult($query);
	echo '<br><span style="color: green"><strong>Result:</strong><br>';
	printResultFromCarRental(str_replace('<br>','',$sql_query ));
	echo '<br><br><span style="color: #8a2be2;"><strong>All data:</strong>';
	echo '<br><br><span style="color: #4169e1;">car<br>';
	$sql_query1 = "select * from car;";
	printResultFromCarRental($sql_query1);
	echo '<br><br><span style="color: #4169e1;">car_type<br>';
	$sql_query2 = "select * from car_type;";
	printResultFromCarRental($sql_query2);
	echo '<br><br><span style="color: #4169e1;">store<br>';
	$sql_query3 = "select * from store;";
	printResultFromCarRental($sql_query3);
	echo '<br><br><span style="color: #4169e1;">employee<br>';
	$sql_query4 = "select * from employee;";
	printResultFromCarRental($sql_query4);
	echo '<br><br><span style="color: #4169e1;">customer<br>';
	$sql_query5 = "select * from customer;";
	printResultFromCarRental($sql_query5);
	echo '<br><br><span style="color: #4169e1;">contract<br>';
	$sql_query6 = "select * from contract;";
	printResultFromCarRental($sql_query6);
}else{
	echo "<span style='color: red'>Please go back to where you came!";
}

?>



<br><br>
<button onclick="history.go(-1);">Back </button>
</body>
<?php  include_once "footer.php"; ?>
</html>