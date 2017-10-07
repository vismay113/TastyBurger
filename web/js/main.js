
/*
$(document).ready(function() {
    $('.tastyburger-footer').append('navbar.html');
});
*/


 function initMap() {
        var uluru = {lat: -27.467354, lng: 153.024131};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }


