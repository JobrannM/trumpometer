$(document).scroll(function() {
  var st = $(this).scrollTop();
  $("#banner").css({
    "background-position-y": (-st/20)
  })
  $("#bannerscroll").css({
    "top": (-st/5),
    "bottom": (st/5)
  })
});
