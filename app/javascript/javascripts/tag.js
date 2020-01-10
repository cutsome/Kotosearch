$(function(){
  $('.container').on('click', 'input', function(){
    var tag = $(this).parent('.tag-item');

    if (tag.hasClass('tag-item')) {
      tag.toggleClass('tag-item__active');
    }
  });

  $('input:checked').each(function() {
    $(this).parent().addClass('tag-item__active');
  });
});
