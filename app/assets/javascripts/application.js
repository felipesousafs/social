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
});