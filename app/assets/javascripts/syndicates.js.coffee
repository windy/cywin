$(document).ready ->
  $(this).on 'click', '#add-syndicate-button', (e)->
    e.preventDefault()
    $('#add-syndicate-modal').foundation('reveal', 'open')

  $(this).on 'click', '#leader-confirm-button', (e)->
    e.preventDefault()
    $('#leader-confirm-modal').foundation('reveal', 'open')
  
  # 投资某个项目
  $(this).on 'submit', '#new_syndicate', (e)->
    e.preventDefault()
    $.post $(this).attr('action'), $(this).serialize(), (data)->
      Alert.doit data, ->
        $('#add-syndicate-modal').foundation('reveal', 'close')
        $('#invest').fadeOut 'slow', ->
          $(this).html(data)
          $(this).fadeIn('slow')

  $('#leader_confirm_form').submit (e)->
    e.preventDefault()
    $.post $(this).attr('action'), (data)->
      Alert.doit data, ->
        $('#leader-confirm-modal').foundation('reveal', 'close')
        $('#invest').fadeOut 'slow', ->
          $(this).html(data)
          $(this).fadeIn('slow')

