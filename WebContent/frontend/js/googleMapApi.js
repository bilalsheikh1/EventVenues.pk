var lat =0;
	var lng = 0;
	var address="";
	function initMap() {
	    var map = new google.maps.Map(document.getElementById('map'), { 
	    center: {lat: 25.3678259, lng: 68.3581077},
	    zoom: 15
	  });
	  

	 infoWindow = new google.maps.InfoWindow;

	        // Try HTML5 geolocation. 
	        if (navigator.geolocation) {
	          navigator.geolocation.getCurrentPosition(function(position) {
	            var pos = {
	              lat: position.coords.latitude,
	              lng: position.coords.longitude
	            };   
	            infoWindow.setPosition(pos);
	            infoWindow.setContent('Your Current Location.');
	            infoWindow.open(map);
	            map.setCenter(pos); 
	            lat = position.coords.latitude;
	            lng = position.coords.longitude; 
	            var latlng = new google.maps.LatLng(lat , lng);
	                var geocoder = geocoder = new google.maps.Geocoder();
	                geocoder.geocode({ 'latLng': latlng }, function (results, status) {
	                    if (status == google.maps.GeocoderStatus.OK) {
	                        if (results[1]) {
	                            address = results[1].formatted_address;   
	                            //$('<input/>').attr({ type: 'text', id: 'test', name: 'test' , value : address }).appendTo('#text').focus();
	                            $(document).ready(function (){
									address = address.slice(0,21);  
									$.ajax({ 
									 	url : '../Marquee',
										data : 'method=getNearby&address='+address,
										type : 'post', 
										success : function (msg){   
													$('#nearByMarquees').html(msg); 
     											},     
										error : function(){
												alert("error in marquer near by function");
											}
									});  
	                            });
	                        } 
	                    } 
	                }); 
	          }, function() {
	            handleLocationError(true, infoWindow, map.getCenter());
	          });
	        } else {
	          // Browser doesn't support Geolocation
	          handleLocationError(false, infoWindow, map.getCenter());
	        }

	        
	        
	  var circle; 
	  // var marker = new google.maps.Marker({
	  //   map: map,   
	  //   position: map.getCenter(), 
	  //   title: "name"
	  // });    
	  for (i = 0; i < arr.length; i++) {  
	      var index = arr[i].indexOf(",");
	      var slice = arr[i].slice(0,index);
	      var slice1 = arr[i].slice(index+1 , arr[i].length);
	    
	        marker = new google.maps.Marker({
	        position: new google.maps.LatLng(slice , slice1),
	        map: map,  
	        url : "individual_venue.jsp?id="+id[i]+"Mb"+Math.round(new Date().getTime()/1000) 
	      });    
	          infoWindow.setContent('Your Current Location.');

	           google.maps.event.addListener(marker, 'click', function() {
	             window.location.href = this.url;
	          });
	    //     google.maps.event.addListener(marker, 'click', (function(marker, i) {
	    //     return function() { 
	    //       // infowindow.setContent("img");
	    //       infowindow.open(map, marker);  

	    //     }
	    //   }) (marker, i));   
	    // }  

	  // Add circle overlay and bind to marker
	  $('#customRange1').change(function() {
	    var new_rad = $(this).val();
	    console.log(new_rad);
	    var rad = new_rad * 1609.34;
	    if (!circle || !circle.setRadius) {
	      circle = new google.maps.Circle({
	        map: map,
	        radius: rad,
	        fillColor: '#555',
	        strokeColor: '#ffffff', 
	        strokeOpacity: 0.1,
	        strokeWeight: 3
	      });
	      circle.bindTo('center', marker, 'position');
	    } else circle.setRadius(rad);
	  });
	}
	}