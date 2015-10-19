var express = require("express"),
	jade = require("jade"),
	bodyParser = require("body-parser"),
	MongoClient = require("mongodb").MongoClient;

var app = express();

app.set("view engine", "jade");
app.set("views", __dirname + "/views")
app.use(bodyParser.urlencoded( { extended: true } ))


var mdb = undefined

MongoClient.connect("mongodb://localhost:27017/webapp", function(err, db) {
	if(err) throw err;

	console.log("Server listening to localhost:3000");

	mdb = db;

	app.listen(3000);
});

app.get("/", function(req, res) {
	
	fruits = mdb.collection("fruits").find().toArray();

	fruits.then(function(fruits) {
		res.render("index", { fruits: fruits });
	});
})

app.get("/fruit/new", function(req, res) {
	res.render("new");
})

app.post("/fruit/new", function(req, res) {
	var fruit = req.body.fruitName;

	mdb.collection("fruits").insert({ "name": fruit })

	res.redirect(301, "http://localhost:3000");
})
