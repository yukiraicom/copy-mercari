$(function(){
  $('.container--mypage__content__tab__list').click(function(){
    $('.container--mypage__content__tab__list').removeClass('container--mypage__content__tab__list--active')
    $(this).addClass('container--mypage__content__tab__list--active')
    $('.container--mypage__content__tab__content__pane--active').removeClass('container--mypage__content__tab__content__pane--active')
    const index = $(this).index()
    $('.container--mypage__content__tab__content__pane').eq(index).addClass('container--mypage__content__tab__content__pane--active')
  })

  $('.container--mypage__content__tab__trading__li').click(function(){
    $('.container--mypage__content__tab__trading__li').removeClass('container--mypage__content__tab__trading__li--active')
    $(this).addClass('container--mypage__content__tab__trading__li--active')
    const index = $(this).index()
    $('.container--mypage__content__tab__trading--content--item').removeClass('container--mypage__content__tab__trading--content--item--active')
    $('.container--mypage__content__tab__trading--content--item').eq(index).addClass('container--mypage__content__tab__trading--content--item--active');
  })
})

