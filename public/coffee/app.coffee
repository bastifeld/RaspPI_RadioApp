

SocketNavigation = require('./socket_navigation.coffee') 

$ ->
	
	addTemplate = (hdbTemplate, element, context, callback) ->
		$.get(hdbTemplate, (data) ->
			template = Handlebars.compile(data);
			html = template(context);
			$(element).html(html);
			if callback
				callback()
		)    



	footerContext = 
		navigation :
			navItem : "Radio"
			navItem : "System"
		
	addTemplate("footer.html","#footer",footerContext) 

	

	headerContext = 
		title: "meine Radio App"	    
	addTemplate("header.html","#header",headerContext) 

	context = 
		senders: [
			{name: "ndr 2 test", url:"http://ndrstream.ic.llnwd.net/stream/ndrstream_ndr2_hi_mp3"},
			{name: "wdr 2", url:"http://wdr-mp3-m-wdr2-koeln.akacast.akamaistream.net/7/812/119456/v1/gnl.akacast.akamaistream.net/wdr-mp3-m-wdr2-koeln"},
			{name: "radio21", url:"http://edge.live.mp3.mdn.newmedia.nacamar.net/ps-radio21/livestream.mp3"}
			{name: "stop", url:"stop"}
		]
	addTemplate("radioList.html","#content",context,-> 
		$(".radio-list li:first-child").addClass("active")
		addCheckSVG()
	) 



	navi = new SocketNavigation

	navi.on "KEY_DOWN" , () ->
		oldSelected = $(".active")
		nextSelected = oldSelected.next();
		if nextSelected.length > 0			
			nextSelected.addClass("active");
			oldSelected.removeClass("active");			
			addCheckSVG() 
	
	navi.on "KEY_UP" , () ->
		oldSelected = $(".active")
		prevSelected = oldSelected.prev();
		if prevSelected.length > 0
			prevSelected.addClass("active");
			oldSelected.removeClass("active");
			addCheckSVG() 
		
	navi.on "KEY_ENTER", () ->
		oldSelected = $(".active")
		if oldSelected.attr("url") is "stop" 
			socket.emit("stop")
		else
			socket.emit("play",  url: oldSelected.attr( "url" ) )
	

	
	addCheckSVG = () ->
		$(".svg").remove()
		# $("#svg").load("svg/check.svg")
		$.get("svg/check.svg", (data) ->
			$(".active").append($('<div class="svg"></div>'));
			$(".active > .svg").append(data)
		, 'text')   
	
	
	
