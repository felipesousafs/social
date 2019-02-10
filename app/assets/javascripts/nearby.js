
$(document).ready(function(){
    console.log("Nearby.js loaded");

    var map_nearby = L.map('map_nearby').setView([-5.05059, -42.79477], 13);

    var tile_layer = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox.streets',
        accessToken: 'pk.eyJ1IjoiZm1zb2Z0IiwiYSI6ImNqcGluYjA4YjBkeW0zcW1tc3QyYnJyZXoifQ.z8_uH8BcuUlj_6kpOBTkOw'
    });
    tile_layer.addTo(map_nearby);
    var markerGroup = L.layerGroup().addTo(map_nearby);
    var popup = L.popup();

    $.get("/nearby.json", function(data, status){
        console.log(data);
        console.log(status);
        data.forEach(function (item) {
            console.log(item);
            L.marker([item.latitude, item.longitude]).addTo(markerGroup).bindTooltip(item.user_email);
        });
    });
});