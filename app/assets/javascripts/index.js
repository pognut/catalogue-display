$(document).on("turbolinks:load", function(){

  $('.slick-test').slick({
    dots:true,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 4000,
  });

var $input = $('#refresh');

$input.val() == 'yes' ? location.reload(true) : $input.val('yes');




});





