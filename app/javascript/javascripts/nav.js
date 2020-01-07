$(function() {
  $(document).on('click', '.nav-button-wrap', function() {
    //var tag = $(this).parent('.nav-button-wrap')

    if ($(this).hasClass('nav_active')) {
      // スマホ用メニューが表示されていたとき
      $(this).removeClass('nav_active');
      $('.globalnav').addClass('close');
      $('.globalnav-wrap').removeClass('open');
    } else {
      // スマホ用メニューが非表示の時
      $(this).addClass('nav_active');
      $('.globalnav').removeClass('close');
      $('.globalnav-wrap').addClass('open');
    }
  });
});
