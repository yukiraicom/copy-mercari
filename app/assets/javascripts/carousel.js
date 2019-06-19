$(function() {
  $(".owl-carousel--top").owlCarousel({
    items: 1,
    loop: true,
    autoWidht: true,
    autoHeight: false,
    dots: false,
    autoplay: true
  });
  $(".owl-carousel--item").owlCarousel({
    items: 1,
    autoWidht: true,
    autoHeight: false,
    autoplay: false,
    dots: false,
    loop:false,
    center:true,
    margin:10,
    URLhashListener:true,
    autoplayHoverPause:true,
    startPosition: 'URLHash'
  })
});
