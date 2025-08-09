<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MGU Library</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background: linear-gradient(to bottom right, #510e89, #ffebee);
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

h1 {
	margin-left: 100px;
	color: green;
}
button {
	font-size: 15px;
	border: none;
	background: none;
	margin-left: 15px;
	padding: 8px 12px;
	border-radius: 5px;
	transition: all 0.3s;
}

button:hover {
	cursor: pointer;
	background-color: #c3baba;
	font-size: 18px;
}

#addBook, #issueBook, #returnBook, #bookAvailibilty {
	display: none;
}

#homePage {
	display: block;
}

table {
	margin: 20px auto;
	padding: 10px;
	border-collapse: separate;
	border-spacing: 15px;
	color: #444;
	font-size: 16px;
}

input[type="text"] {
	padding: 5px;
	color: blue;
	border: 1px solid #ddd;
	border-radius: 5px;
}

input[type="submit"] {
	font-size: 15px;
	color: white;
	background-color: green;
	border: none;
	padding: 5px 10px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: darkgreen;
}
select[name="bCategory"] {
    width: 110%; 
    padding: 5px; 
    border: 1px solid #ccc;
border-radius: 5px;
    font-size: 16px;
}
.landingPage {
	text-align: center;
	padding: 20px;
	background-color: rgba(255, 255, 255, 0.8);
	border-radius: 15px;
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}
</style>
<script>
function home() {
    document.getElementById("addBook").style.display = "none";
    document.getElementById("homePage").style.display = "block";
    document.getElementById("issueBook").style.display = "none";
    document.getElementById("returnBook").style.display = "none";
    document.getElementById("bookAvailibilty").style.display = "none";
}
function addBook() {
    document.getElementById("addBook").style.display = "block";
    document.getElementById("homePage").style.display = "none";
    document.getElementById("issueBook").style.display = "none";
    document.getElementById("returnBook").style.display = "none";
    document.getElementById("bookAvailibilty").style.display = "none";
}
function issueBook() {
    document.getElementById("addBook").style.display = "none";
    document.getElementById("homePage").style.display = "none";
    document.getElementById("issueBook").style.display = "block";
    document.getElementById("returnBook").style.display = "none";
    document.getElementById("bookAvailibilty").style.display = "none";
}
function returnBook() {
    document.getElementById("addBook").style.display = "none";
    document.getElementById("homePage").style.display = "none";
    document.getElementById("issueBook").style.display = "none";
    document.getElementById("returnBook").style.display = "block";
    document.getElementById("bookAvailibilty").style.display = "none";
}
function bookAvailibilty() {
    document.getElementById("addBook").style.display = "none";
    document.getElementById("homePage").style.display = "none";
    document.getElementById("issueBook").style.display = "none";
    document.getElementById("returnBook").style.display = "none";
    document.getElementById("bookAvailibilty").style.display = "block";
}
</script>
</head>
<body>
	<div class="landingPage">
		<h1>MGU Central Library</h1>
		<button onclick="home()">Home</button>
		<button onclick="addBook()">Add a book</button>
		<button onclick="issueBook()">Issue a book</button>
		<button onclick="returnBook()">Return a book</button>
		<button onclick="bookAvailibilty()">Search a book</button>



		<div id="homePage">
		   
			<br>
			<h3>Welcome to MGU Library</h3>
			Explore a universe of knowledge across diverse fields in the Mahatma
			Gandhi University Library! <br> <br> Organized to suit your
			interests and academic needs, our library offers a carefully curated
			collection of books and resources.<br> <br> Whether you’re
			diving into the mysteries of science fiction, mastering mathematics,
			or exploring arts and commerce,<br> <br> we’ve got
			something for everyone.
		</div>
		<div id="addBook">
			<br>
			<form action="/addBookt" method="post" >
				<h3>Adding a book to library</h3>
				<table class="addBook">
					<tr>
						<td>Book Id:</td>
						<td><input type="text" name="bid"></td>
					</tr>
					<tr>
						<td>Book Name:</td>
						<td><input type="text" name="bName"></td>
					</tr>
					<tr>
						<td>Book Category:</td>

						<td><select name="bCategory">
						<option value="">Select  </option>
								<option value="Commerse">Commerce</option>
								<option value="Sci-Fi">Science&Fiction</option>
								<option value="Arts">Arts</option>
								<option value="Maths">Mathematics</option>
								<option value="Computers">Computers</option>
						</select></td>
					</tr>

					<tr>
						<td>Book Author:</td>
						<td><input type="text" name="bAuthor"></td>
					</tr>
				</table>
				<input type="submit" value="Submit">

			</form>
		</div>

		<div id="issueBook">
			<br>
			<form action="issueBook" method="post">
				<h3>Issuing a book</h3>
				<table class="issueBook">
					<tr>
						<td>Book Id:</td>
						<td><input type="text" name="bid"></td>
					</tr>
					<tr>
						<td>Student Id:</td>
						<td><input type="text" name="sid"></td>
					</tr>
				</table>
				<input type="submit" value="Submit">
			</form>
		</div>

		<div id="returnBook">
			<br>
			<form action="returnBook" method="post" enctype="application/json">
				<h3>Return a book</h3>
				<table class="returnBook">
					<tr>
						<td>Book Id:</td>
						<td><input type="text" name="bid"></td>
					</tr>
					<tr>
						<td>Student Id:</td>
						<td><input type="text" name="sid"></td>
					</tr>
				</table>
				<input type="submit" value="Submit">
			</form>
		</div>

		<div id="bookAvailibilty">
			<br>
			<form action="bookAvailability" method="post">
				<table class="bookAvailibilty">
					<tr>
						<td>Book Id:</td>
						<td><input type="text" name="bid"></td>
					</tr>
				</table>
				<input type="submit" value="Submit">
			</form>
		</div>
	</div>
</body>
</html>