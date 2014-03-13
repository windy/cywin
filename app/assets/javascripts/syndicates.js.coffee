$(document).ready ->
  # 投资某个项目
  $('#new_syndicate').submit (e)->
    e.preventDefault()
    $.post $(this).attr('action'), $(this).serialize(), (data)->
      Alert.doit data, ->
        $('#add-syndicate-modal').foundation('reveal', 'close')
        $('#invest').fadeOut 'slow', ->
          $(this).html(data)
          $(this).fadeIn('slow')
