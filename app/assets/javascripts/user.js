
$(document).ready(function(){
    console.log("User.js loaded");

    var map_user = L.map('map_user');

    var tile_layer = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox.streets',
        accessToken: 'pk.eyJ1IjoiZm1zb2Z0IiwiYSI6ImNqcGluYjA4YjBkeW0zcW1tc3QyYnJyZXoifQ.z8_uH8BcuUlj_6kpOBTkOw'
    });
    tile_layer.addTo(map_user);
    var markerGroup = L.layerGroup().addTo(map_user);
    console.log();
    $.get(window.location.href+".json", function(data, status){
        console.log(data);
        console.log(status);
        map_user.setView([data.latitude, data.longitude], 15);
        L.marker([data.latitude, data.longitude]).addTo(markerGroup).bindTooltip(data.address);
    });
});