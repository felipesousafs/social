// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-table
//= require leaflet.js
//= require_tree .


$(document).ready(function(){
    console.log("JS loaded");
    // $('#comment_form').on('ajax:success', function(e, data, status, xhr){
    //     // var comment = "" +
    //     //     "<div class=\"card-footer\">" +
    //     //     "<small class=\"text-muted\">" +
    //     //     "<strong>"+data.user_id+"</strong> comentou: <code></b> <p>" +
    //     //     data.text + "</p></code></small>" +
    //     //     "</div>";
    //     // $('#comments_'+data.post_id).append(comment);
    //     console.log("Sucesso");
    // }).on('ajax:error',function(e, xhr, status, error){
    //     console.log("Erro");
    //     // $('#comment_form').text('Failed.');
    // });

    var mymap = L.map('mapid').setView([-5.05059, -42.79477], 13);
    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox.streets',
        accessToken: 'pk.eyJ1IjoiZm1zb2Z0IiwiYSI6ImNqcGluYjA4YjBkeW0zcW1tc3QyYnJyZXoifQ.z8_uH8BcuUlj_6kpOBTkOw'
    }).addTo(mymap);

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