var MongoClient = require("mongodb").MongoClient

MongoClient.connect("mongodb://localhost:27017/child-referencing", function(err, db) {
	if(err) throw err;
	
	var product = db.collection("products").findOne({ name: "Product2" });

	// Every product has references to parts

	product.then(function(product) {

		console.log("PRODUCT:", product);
		return db.collection("parts").find({
			 _id: { 
			 	$in: product.parts
			 } 
		}).toArray();

	}).then(function(parts) {

		console.log("PARTS:", parts);
		db.close();

	}).catch(function(e) {
		console.error(e);
	});
});