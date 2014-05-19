// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

HACKVOTE = {

  common : {
    init : function() {
      // this init is called every page
      //this to include csrf into my post requests
      $.ajaxSetup({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      });
      //snippet for turning form into json.
      $.fn.serializeObject = function()
      {
         var o = {};
         var a = this.serializeArray();
         $.each(a, function() {
             if (o[this.name]) {
                 if (!o[this.name].push) {
                     o[this.name] = [o[this.name]];
                 }
                 o[this.name].push(this.value || '');
             } else {
                 o[this.name] = this.value || '';
             }
         });
         return o;
      };

    }
  },

  homepage : {
    init : function() {
      $('#latest_hack_button').click(function(){
        window.location = "/hackdays"
      });

      $('#new_hack_button').click(function() {
        $('#myModal').modal('show');
      });

      $('#hackday_submit_button').click(function() {
        var data = JSON.stringify($('#new_hackday_form').serializeObject());
        $.ajax({
          url: "/hackdays",
          type: 'post',
          data: data,
          headers: {
              'content-type': 'application/json'   //If your header name has spaces or any other char not appropriate
          },
          dataType: 'json',
          success: function (data) {
              console.log(data);
              $('#myModal').modal('hide');
          },
          error: function(data){
            console.log(data);
          }
        });      
      });
    }
  },

  hackday : {
    init : function() {
      $('.vote_button').each(function(){
        //grab the id from the button's data-
        $(this).click(function(){
          vote_url = $(this).attr("data-vote-url");
          vote_holder = $(this).parent().find('.vote_holder');
          $.ajax({
            url: vote_url,
            type: 'PUT',
            headers: {
                'content-type': 'application/json'   //If your header name has spaces or any other char not appropriate
            },
            dataType: 'json',
            success: function (data) {
              if (data['code'] == 1){
                // successfully voted.  update the vote count, 
                vote_holder.html(data.votes);
                // decrease votes left.  
                votes_left = parseInt($('#votes_left').html()) - 1;
                $('#votes_left').html(votes_left)
              }else{
                alert("you are out of votes!");
              }
            },
            error: function(data){
              alert(data);
            }
          });
        });
      });
    }
  },
};

UTIL = {
  exec: function( controller, action ) {
    var ns = HACKVOTE,
    action = ( action === undefined ) ? "init" : action;

    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
      //if action also found, call function
      ns[controller][action]();
    }
  },

  init: function() {
    var main_container = $("#main_container").get(0); 
    controller = main_container.getAttribute( "data-controller");
    UTIL.exec( "common" );
    UTIL.exec( controller );
  }
};

$(document).ready(UTIL.init);
$(document).on('page:load', UTIL.init);