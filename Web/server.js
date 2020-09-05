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
			console.log("saved: " + note)
			res.send("saved")
		} else {
			console.log("failed to save note")
		}
	})
})

// delete - delete
app.delete('/delete', (req, res) => {
	// params: target, callback
	Data.findOneAndDelete({
		_id: req.get("id")
	}, (err) => {
		if (err !== null) {
			console.log("error shown: " + err)
			res.send("failed to delete!")
		}
	})
	res.send("deleted")
})

// update - put
app.put('/update', (req, res) => {
	// params: targetToUpdate, newContent, callback
	Data.findByIdAndUpdate({
		_id: req.get("id")
	}, {
		title: req.get("title"),
		date: req.get("date"),
		note: req.get("note")
	}, (err) => {
		if (err !== null) {
			console.log("failed to update: " + err)
			res.send("failed to update!")
		}
	})
	res.send("updated")
})


// fetch - get
app.get('/fetch', (req, res) => {
	Data.find({}).then((DBitems) => {
		res.send(DBitems)
	})
})