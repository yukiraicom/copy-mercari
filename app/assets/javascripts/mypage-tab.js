$(function(){
    $('.container--mypage__content__tab__list').click(function(){
        $('.container--mypage__content__tab__list').removeClass('container--mypage__content__tab__list--active')
        $(this).addClass('container--mypage__content__tab__list--active')
        $('.container--mypage__content__tab__content__pane--active').removeClass('container--mypage__content__tab__content__pane--active')
        const index = $(this).index()
        $('.container--mypage__content__tab__content__pane').eq(index).addClass('container--mypage__content__tab__content__pane--active')
      })
    })

