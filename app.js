const express = require('express');
const bodyParser = require('body-parser')
const mysql = require('mysql');
const util = require('util');
require('express');
const port = 8000;

const app = express();
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json());
app.set('view engine', 'ejs');
app.use(express.static('public'));

var connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: '',
	database: 'Library',
	port: 3306
});

// promise wrapper to enable async await with MYSQL
connection.query = util.promisify(connection.query).bind(connection);

connection.connect(function (err) {
	if (err) {
		console.error('error connecting: ' + err.stack);
		return;
	}
	console.log('Booom! You are connected');

});


app.get('/', async function (req, res) {
	let values = { search: '', results: [], message: '', loans: [], urn: "" };
	if (req.query.search) {
		values.search = req.query.search;
		try {
			const results = await connection.query(`SELECT * FROM Item WHERE Item_Title LIKE '%${req.query.search}%'`);
			console.log(results);
			if (results.length) values.results = results;
			if (!results.length) values.message = 'I could not find any items!'
			res.render('index', values);
			return;

		} catch (error) {
			values.message = "error, could not run search query";
			res.render('index', values);
			throw `error could not run search query: ${error}`
		}

	}

	if (req.query.urn) {
		values.urn = req.query.urn;
		//$sql = "SELECT Item_Title, Item_ID FROM Item WHERE Item_ID IN (SELECT Item_ID FROM Loan WHERE URN='$query');";
		try {
			const results = await connection.query(`SELECT Item.Item_ID, Item.Item_Title FROM Loan  INNER JOIN ITEM ON Loan.Item_ID = Item.Item_ID WHERE Loan.URN = ${req.query.urn}`);
			console.log(results);
			if (!results.length) values.message = "I could not find that URN!"
			values.loans = results;
			res.render('index', values)
			return;
		} catch (error) {
			values.message = 'error, could not run URN query';
			res.render('index', values);
			throw `error could not run urn query: ${error}`
		}
	}

	res.render('index', values);
});

app.get('/loan', async function (req, res) {

	let values = { result: {}, message: '', item: {} }
	if (!req.query?.search) {
		res.redirect("/");
		return;
	}

	try {

		const results = await connection.query(`SELECT Item_ID, Item_Title FROM Item WHERE Item_ID=${req.query.search}`);
		if (!results.length) values.message = "I could not find that item!"
		if (results.length) values.item = results[0];
		res.render('loan', values);
		return;

	} catch (error) {
		values.message = 'error could not run query';
		res.render('loan', values);
		throw `error could not run item query: ${error}`
	}

});

app.post('/loan', async function (req, res) {
	let values = { result: {}, message: '', item: {} }


	// first get the item 
	try {
		const results = await connection.query(`SELECT Item_ID, Item_Title FROM Item WHERE Item_ID=${req.query.search}`);
		values.item = results[0];
	} catch (error) {
		values.message = 'error could not run query';
		res.render('loan', values);
		throw `error could not run item query: ${error}`
	}


	if (!req.body.URN || isNaN(req.body.URN)) {
		values.message = "Whoops! You did not enter a numerical URN";
		res.render('loan', values);
		return;
	}

	// try and find the URN and assign loan 

	try {
		const results = await connection.query(`SELECT URN FROM STUDENT WHERE URN = ${req.body.URN}`);

		if (!results.length) {
			values.message = "Whoops! There are no students with this URN";
			res.render('loan', values);
			return;
		}

		await connection.query(`INSERT INTO Loan (URN, Item_ID) VALUES (${req.body.URN}, ${req.query.search})`);
		values.message = `${values.item.Item_Title} has been added to your account`;
		res.render('loan', values);
		return;

	} catch (error) {
		values.message = 'error could not run query';
		res.render('loan', values);
		throw `error could not rub loan update query query: ${error}`
	}
})



app.listen(port, () => {
	console.log(`Library app listening at http://localhost:${port}`);
})