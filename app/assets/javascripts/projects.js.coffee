$(document).ready ->
  $('.selection a, .industry a, .district a').click ->
    $(this).parent().addClass('active')
    $(this).parent().siblings().removeClass('active')
    false
  $('.stage1 .add_member').click ()->
    false
  $('.stage1 input[type=submit]').click ()->
    true
