<html>
<?php include_once "header.php" ?>
<body>

<?php
//connect to the database
$dbconn = pg_Connect("host=rabbit.cs.pdx.edu dbname=query_practice user=censoredUser password=censored");
if (!$dbconn) {
	die;
}

function printCheckbox(){
	$query = "select qt_name from qtype";
	$result = pg_query($query);

	$i = 0;
	while ($row = pg_fetch_row($result))
	{
		$count = count($row);

		$y = 0;
		$i = $i + 1;
		while ($y < $count)
		{
			$c_row = current($row);
			$y = $y + 1;
			echo "<input type='checkbox' name='checkboxvar[]' value='$i'>$c_row<br>";
			next($row);
		}
	}
	pg_free_result($result);
}


?>
<table><tr>
	<td>
<form method='post' id='userform' action='qtypes.php'>
	<input type='submit' class='buttons'> <br>
	<br><strong>Choose at most 2 aspects to hide: </strong><br>
	<input type='checkbox' name='checkboxvar2[]' value='123'>English Statement<br>
	<input type='checkbox' name='checkboxvar2[]' value='124'>SQL<br>
	<input type='checkbox' name='checkboxvar2[]' value='125'>Relation Algebra<br><br>

	<strong>
	Select the query types you would like to see. If you don't choose any types, you'll see all the queries: </strong>
	<br>


	<?php printCheckbox() ?>

    </form>
    </td>

</tr>
</table>
</body>
<?php include_once "footer.php" ?>
</html>