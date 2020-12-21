$(document).ready(function() {
  $(".show-in-modal").click(function(e){
    var img = $(this).attr("src");
    $("#modalShow .modal-body").html("<img src='"+img+"' class='img-responsive'>");
     $("#modalShow").modal("show");
     e.preventDefault()
  });

  $(".show-image").click(function(e){
    var img = $(this).closest(".item-img-wrap").find("img:first").attr("src");
    $("#modalShow .modal-body").html("<img src='"+img+"' class='img-responsive'>");
     $("#modalShow").modal("show");
     e.preventDefault()
  });

  //messages
  if ($('#ms-menu-trigger')[0]) {
    $('body').on('click', '#ms-menu-trigger', function() {
        $('.ms-menu').toggleClass('toggled'); 
    });
   }

   /*============ Chat sidebar ========*/
  $('.chat-sidebar, .nav-controller, .chat-sidebar a').on('click', function(event) {
      $('.chat-sidebar').toggleClass('focus');
  });

  $(".hide-chat").click(function(){
      $('.chat-sidebar').toggleClass('focus');
  });

   /*sidebar profile toggle*/
  $(".btn-toggle-menu").click(function() {
    $("#wrapper").toggleClass("toggled");
  });

})