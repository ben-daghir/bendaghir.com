var express = require("express");
var path = require("path");

var app = express();

port = 3000;

app.listen(port);
console.log("App listening on port:", port);

app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});

app.get('/academics/home', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/academics/home.html'));
});

app.get('/coding/home', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/coding/home.html'));
});

app.get('/grandchallenges/home', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/grandchallenges/home.html'));
});

app.get('/projects&patents/home', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/projects&patents/home.html'));
});

app.get('/research/home', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/research/home.html'));
});

app.get('/service/home', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/service/home.html'));
});

app.get('/navbar', function(req, res) {
    res.sendFile(path.join(__dirname + '/views/navbar.html'));
});
