var MongoClient = require("mongodb").MongoClient

MongoClient.connect("mongodb://localhost:27017/test", function(err, db) {
	if(err) throw err;
	
	var person = db.collection("persons").findOne({ name: "Chri" });

	person.then(function(person) {
		console.log("PERSON:", person);
		return db.collection("addresses").findOne({ _id: person.address_id });
	}).then(function(address) {
		console.log("ADDRESS:", address);
		db.close();
	}).catch(function(e) {
		console.error(e);
	});
});