

express = require('express')
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)
readline = require('readline')
omx = require('omxcontrol')
path = require("path")
Keyboard = require('linux-input') 

port = process.env.PORT

if port is undefined
  port = 8081

io.configure( ->
	io.set('log level', 2)
	io.set('transports', ['websocket','xhr-polling']);
	#websocket funktioniert bei mir nicht??
	#io.set('transports', ['websocket']);
)



console.log path.join(__dirname, '..','public') 

app.use "/" , express.static path.join(__dirname, '..', 'public') 

server.listen(port, ()->  
	console.log('listening on port test: ' + port)
)


 
k = new Keyboard('event0'); # 'event2' is the file corresponding to my keyboard in /dev/input/

io.sockets.on('connection',  (socket)-> 
	
	console.log("Screen connected...")
	
	k.on('keypress', (event)->
		console.log("keypress hallo: " +event.keyId);
		
		relevantKeys = [Keyboard.KEYS.KEY_UP,Keyboard.KEYS.KEY_PAGEUP,Keyboard.KEYS.KEY_LEFT,Keyboard.KEYS.KEY_RIGHT,Keyboard.KEYS.KEY_END,Keyboard.KEYS.KEY_DOWN,Keyboard.KEYS.KEY_ENTER]
		if event.keyId in relevantKeys
			socket.emit('controll', { action: event  });

	)

	socket.on("play", (data)-> 			
		omx.quit()    		
		omx.start(data.url)
	)

	socket.on("stop", (data) -> 
		console.log("stop")
		omx.quit()
	) 
 
)




