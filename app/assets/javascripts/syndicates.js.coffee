$(document).ready ->
  $('#new_syndicate').submit (e)->
    e.preventDefault()
    $.post $(this).attr('action'), $(this).serialize(), (data)->
      Alert.doit data, ->
        $('#add-syndicate-modal').foundation('reveal', 'close')
        $('#invest').fadeOut 'slow', ->
          $(this).html(data)
          $(this).fadeIn('slow')
