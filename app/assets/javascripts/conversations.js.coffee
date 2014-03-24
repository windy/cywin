$(document).ready ->
  $('.conversation').hover ->
    $(this).find('button').show()
  , ->
    $(this).find('button').hide()

  $('.mark_as_read').click (e)->
    e.preventDefault()
    $.post $(this).data('uri'), (data)=>
      Alert.doit data, =>
        $(this).remove()
        new_message_count = $('.messagebox').text() - 1
        $('.messagebox').text( new_message_count )
