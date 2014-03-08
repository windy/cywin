$(document).ready ->
  #FIXME 有冲突
  $('#new_syndicate').submit (e)->
    e.preventDefault()
    $.post $(this).attr('action'), $(this).serialize(), (data)->
      if data.success
        window.location.reload()
      else
        alert(data.message)
