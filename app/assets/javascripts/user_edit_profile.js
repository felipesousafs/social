$(document).ready(function () {
    var mymap = L.map('mapid').setView([-5.05059, -42.79477], 13);

    var tile_layer = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox.streets',
        accessToken: 'pk.eyJ1IjoiZm1zb2Z0IiwiYSI6ImNqcGluYjA4YjBkeW0zcW1tc3QyYnJyZXoifQ.z8_uH8BcuUlj_6kpOBTkOw'
    });
    tile_layer.addTo(mymap);
    var markerGroup = L.layerGroup().addTo(mymap);
    var popup = L.popup();

    function onMapClick(e) {
        popup
            .setLatLng(e.latlng)
            .setContent(e.latlng.toString())
            .openOn(mymap);
        // mymap.removeLayer();
        markerGroup.clearLayers();
        L.marker([e.latlng.lat, e.latlng.lng]).addTo(markerGroup);
        $('#user_latitude').val(e.latlng.lat);
        $('#user_longitude').val(e.latlng.lng);
    }

    mymap.on('click', onMapClick);
});