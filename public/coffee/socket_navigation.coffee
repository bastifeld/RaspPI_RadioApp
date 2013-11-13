

class SocketNavigation
	constructor: () ->
		@events = {}
		if location.port
			port = ":" +location.port
		###test hallo welt###
		
		http_address = location.protocol+'//'+location.hostname+ port
		socket = io.connect(http_address)

		socket.on('controll', (data) =>
			console.log(data)

			for listener in @events[data.action]
				listener()
		)
			
	on: (eventName, callback) ->
		if not Array.isArray(@events[eventName]) 
			@events[eventName] = [];
		@events[eventName].push  callback
	
	
module.exports = SocketNavigation
