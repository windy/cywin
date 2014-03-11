$(document).ready ->
  $('#new_syndicate').submit (e)->
    e.preventDefault()
    $.post $(this).attr('action'), $(this).serialize(), (data)->
      Alert.doit data, ->
        window.location.reload()
