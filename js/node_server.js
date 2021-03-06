(function() {
  var Keyboard, app, express, io, k, omx, path, port, readline, server,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  express = require('express');

  app = express();

  server = require('http').createServer(app);

  io = require('socket.io').listen(server);

  readline = require('readline');

  omx = require('omxcontrol');

  path = require("path");

  Keyboard = require('linux-input');

  port = process.env.PORT;

  if (port === void 0) {
    port = 8081;
  }

  io.configure(function() {
    io.set('log level', 2);
    return io.set('transports', ['websocket', 'xhr-polling']);
  });

  console.log(path.join(__dirname, '..', 'public'));

  app.use("/", express["static"](path.join(__dirname, '..', 'public')));

  server.listen(port, function() {
    return console.log('listening on port test: ' + port);
  });

  k = new Keyboard('event0');

  io.sockets.on('connection', function(socket) {
    console.log("Screen connected...");
    k.on('keypress', function(event) {
      var relevantKeys, _ref;
      console.log("keypress hallo: " + event.keyId);
      relevantKeys = [Keyboard.KEYS.KEY_UP, Keyboard.KEYS.KEY_PAGEUP, Keyboard.KEYS.KEY_LEFT, Keyboard.KEYS.KEY_RIGHT, Keyboard.KEYS.KEY_END, Keyboard.KEYS.KEY_DOWN, Keyboard.KEYS.KEY_ENTER];
      if (_ref = event.keyId, __indexOf.call(relevantKeys, _ref) >= 0) {
        return socket.emit('controll', {
          action: event
        });
      }
    });
    socket.on("play", function(data) {
      omx.quit();
      return omx.start(data.url);
    });
    return socket.on("stop", function(data) {
      console.log("stop");
      return omx.quit();
    });
  });

}).call(this);
