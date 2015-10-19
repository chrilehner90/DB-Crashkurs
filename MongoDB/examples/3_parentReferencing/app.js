var MongoClient = require("mongodb").MongoClient

MongoClient.connect("mongodb://localhost:27017/parent-referencing", function(err, db) {
	if(err) throw err;
	
	var hostPromise = db.collection("hosts").findOne({ "name": "Host1" });

	// Every log has a reference to the host where it was captured

	hostPromise.then(function(host) {

		console.log(host);
		return db.collection("logs").find({
			host: host._id
		}).limit(3).toArray()

	}).then(function(logs) {

		console.log(logs)
		db.close();

	})
});