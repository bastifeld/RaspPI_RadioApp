EventEmitter = require('events').EventEmitter

class SocketNavigation extends EventEmitter
	constructor: () ->
		if location.port
			port = ":" +location.port
		
		http_address = location.protocol+'//'+location.hostname+ port
		socket = io.connect(http_address)

		socket.on('controll', (data) =>
			console.log(data)
			@emit( data.action.keyName,data);
		)
	
module.exports = SocketNavigation
