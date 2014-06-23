var http = require("http");
http.createServer(function (request, response) {
      response.writeHead(200, {
         'Content-Type': 'text/plain'
      });
      response.write('Simple Simple Fun')
      response.end();
}).listen(5002);

var express = require("express");
var app = express();
 
/* serves main page */
app.get("/", function(req, res) {
	res.sendfile('index.html')
});
 
app.post("/user/add", function(req, res) {
	/* some server side logic */
    res.send("OK");
});
 
/* serves all the static files */
app.get(/^(.+)$/, function(req, res) {
	console.log('static file request : ' + req.params);
    res.sendfile( __dirname + req.params[0]); 
});
 
var port = process.env.PORT || 5000;
app.listen(port, function() {
	console.log("Listening on " + port);
});