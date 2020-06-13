// In the following example, markers appear when the user clicks on the map.
// The markers are stored in an array.
// The user can then click an option to hide, show or delete the markers.
var map;
var markers = [];
var  i = 1 ; 
function initMap() {
  var haightAshbury = {lat: 25.3678259, lng: 68.3581077};

  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15, 
    center: haightAshbury,
    mapTypeId: 'terrain'
  });

  // This event listener will call addMarker() when the map is clicked.
  
  map.addListener('click', function(event) {
    
    if(i==1){
    	addMarker(event.latLng);
    } 
    i++;
  }); 

  // Adds a marker at the center of the map.
  // addMarker(haightAshbury);
}

// Adds a marker to the map and push to the array.
var a;
function addMarker(location) {
  
  var marker = new google.maps.Marker({
    position: location,
    map: map
    
  });
  markers.push(marker);
  a = marker.getPosition().toUrlValue();
 console.log("lat lngs is  "+a.toString());
 
 var geocoder = geocoder = new google.maps.Geocoder();    
 var geocoder = geocoder = new google.maps.Geocoder(); 
 geocoder.geocode({ 'latLng': marker.getPosition()}, function (results, status) {
     if (status == google.maps.GeocoderStatus.OK) {
         if (results[1]) {
              $('#address2').val(results[1].formatted_address);
              $('#location').val(a.toString()); 
         } 
     }  
 }); 
}

// Sets the map on all markers in the array.
function setMapOnAll(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
	setMapOnAll(null);
	i=1;
	markers = [];
}
