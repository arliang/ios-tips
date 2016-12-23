var http = require("http")
var ws = require("./lib/node-websocket")
var fs = require("fs")

http.createServer(function (req, res) {
	fs.createReadStream("index.html").pipe(res)
}).listen(8080)

var server = ws.createServer(function (connection) {
  console.log('connection coming')
	connection.nickname = null
	connection.on("text", function (str) {
    console.log("text: " + str)
		if (connection.nickname === null) {
			connection.nickname = str
			broadcast(str+" entered")
		} else
			broadcast("["+connection.nickname+"] "+str)
	})
	connection.on("close", function () {
		broadcast(connection.nickname+" left")
	})
  connection.on("error", function () {
    console.error("error accurred")
  })
})

server.listen(8081)

function broadcast(str) {
	server.connections.forEach(function (connection) {
		connection.sendText(str)
	})
}
