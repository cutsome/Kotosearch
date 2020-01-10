$(function() {
  $(document).on('click', '.nav-button-wrap', function() {

    if ($(this).hasClass('nav_active')) {
      $(this).removeClass('nav_active');
      $('.globalnav').addClass('close');
      $('.globalnav-wrap').removeClass('open');
    } else {
      $(this).addClass('nav_active');
      $('.globalnav').removeClass('close');
      $('.globalnav-wrap').addClass('open');
    }
  });
});
