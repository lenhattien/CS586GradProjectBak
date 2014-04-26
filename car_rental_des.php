<html>
<?php include_once "header.php" ?>
<body>

<p align="center" style="padding-left: 8em">
	<strong>Table Description</strong>
</p>

<p align="left">
	<strong>car:</strong> This table holds the information of all the cars which this car rental company has.
</p>
<p align="left">
	car(<u>car_id</u>, make, model, number_of_doors, color, car_type_id, store_id);
</p>
<p align="left">
	The primary key is car_id, it ensure the uniqueness of each car.
</p>
<p align="left">
	Foreign key store_id references store(store_id), it shows the ownership relation between a store and a car (A car is owned by one store. A store owns many
	cars).
</p>
<p align="left">
	Foreign key car_type_id references car_type(car_type_id), it shows the type relation between a car and its type (A car has one type. A type can have zero
	or many cars).
</p>
<br>
<p align="left">
	<strong>car_type:</strong> This table holds all the information of the types of cars.
</p>
<p align="left">
	car_type(<u>car_type_id</u>, type);
</p>
<p align="left">
	The primary key is car_type_id, it ensures the uniqueness of each car type.
</p>
<p align="left">
	Constrain: type must be unique.
</p>
<br>
<p align="left">
	<strong>store:</strong> This table holds the information of the stores that are located in different places owned by the car rental company.
</p>
<p align="left">
	store(<u>store_id</u>, Address, City, Country);
</p>
<p align="left">
	The primary key is store_id, it ensures the uniqueness of each store.
</p>
<br>
<p align="left">
	<strong>employee:</strong> This table holds all the employees information and which store they work for.
</p>
<p align="left">
	employee(<u>employee_id</u>, first, middle, last, gender, age, store_id);
</p>
<p align="left">
	The primary key is employee_id, it ensures the uniqueness of each employee.
</p>
<p align="left">
	Foreign key store_id references store(store_id), it shows the relationship between an employee and a store (An employee works for one store. A store has
	many employees).
</p>
<p align="left">
	Constrain: Gender must be either 'm' or 'f'.
</p>
<br>
<p align="left">
	<strong>customer:</strong> This table holds all the information of the customers who have visited the company.
</p>
<p align="left">
	customer(<u>customer_id</u>, first, middle, last, gender);
</p>
<p align="left">
	The primary key is customer_id, it ensures the uniqueness of each customer.
</p>
<p align="left">
	Constrain: Gender must be either 'm' or 'f'.
</p>
<br>
<p align="left">
	<strong>contract:</strong> This table holds all the information of the contracts between customers and stores. And each contract is handled by an employee. This is a 3-way
	relationship, it connects the customer, car, and employee tables.
</p>
<p align="left">
	contract(<u>contract_id</u>, employee_id, customer_id, car_id, daily_rate, start_date, number_of_days, is_car_returned);
</p>
<p align="left">
	The primary key is contract_id, it ensures the uniqueness of each contract.
</p>
<p align="left">
	Foreign key employee_id references employee(employee_id), the employee that handles the contract.
</p>
<p align="left">
	Foreign key customer_id references customer(customer_id), the customer that makes the contract.
</p>
<p align="left">
	Foreign key car_id references car(car_id), the car that is rented as stated in the contract.
</p>
<p align="left">
	Constrain: is_car_returned must be not NULL. car_id must be unique.
</p>

<td>
	<img width="49%%" src="http://web.cecs.pdx.edu/~letien/CS586GradProject/img/ERD.png"/>
</td>
<td>
	<img width="50%" src="http://web.cecs.pdx.edu/~letien/CS586GradProject/img/TableList.png"/>
</td>
<br>
<button onclick="history.go(-1);">Back</button>
</body>
<?php include_once "footer.php" ?>
</html>