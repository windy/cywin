$(document).ready ->
  $('.selection a, .industry a, .district a').click ->
    $(this).parent().addClass('active')
    $(this).parent().siblings().removeClass('active')
    false
