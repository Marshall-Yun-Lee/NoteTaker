const express = require('express')
const mongoose = require('mongoose')

var Data = require('./noteSchema')
var app = express();

mongoose.connect("mongodb://localhost/newDB")
mongoose.connection.once("open", () => {
	console.log("successfully connected to the database")
}).on("error", (error) => {
	console.log("failed to connect: " + error);
})

// https://10.0.0.26:8080
var server = app.listen(8080, "10.0.0.26", () => {
	console.log("Server is running!");
})

// create - post
app.post('/create', (req, res) => {
	var note = new Data({
		title: req.get("title"),
		date: req.get("date"),
		note: req.get("note")
	})

	note.save().then(() => {
		if (note.isNew === false) {
			console.log("note saved!")
			res.send("saved")
		} else {
			console.log("failed to save note")
		}
	})
})

// delete - delete

// update - put

// fetch - get
app.get('/fetch', (req, res) => {
	Data.find().then((DBitems) => {
		res.send(DBitems)
	})
})