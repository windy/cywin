$(document).ready ->

  $('#star_project').mouseenter (e)->
    if $(this).hasClass('has_starred')
      $(this).addClass('mouseover').text("取消关注")
    else
      $(this).addClass('mouseover').text("点击关注")
  .mouseleave (e)->
    if $(this).hasClass('has_starred')
      $(this).removeClass('mouseover').text("已关注")
    else
      $(this).removeClass('mouseover').text("关注")

  $('#star_project').click (e)->
    e.preventDefault()
    uri = $(this).data('uri')
    id = $(this).data('id')
    if $(this).hasClass('has_starred')
      $.ajax
        url: uri
        type: 'delete'
        data:
          id: id
        success: (data)->
          Alert.doit data, ->
            $('#star_project').removeClass('has_starred').addClass('unstarred').text("关注")
    else
      $.post uri, id: id, (data)->
        Alert.doit data, ->
          $('#star_project').addClass('has_starred').text("已关注")
