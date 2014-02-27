window.Project =
  search: ()->
    search_name = $('#search_name').val()
    industry = $('.industry').find('.active a').attr('data-id')
    district = $('.district').find('.active a').attr('data-id')
    $.get '/projects_searcher/index', { search_name: search_name, industry: industry, district: district }, (data)->
      $('.projects_search').html(data)

$(document).ready ->
  $('.selection a, .industry a, .district a').click (e)->
    e.preventDefault()
    $(this).parent().addClass('active')
    $(this).parent().siblings().removeClass('active')
    Project.search()

  $('#search_button').click (e)->
    e.preventDefault()
    Project.search()

  # 回车注册
  $('#search_name').keyup (e)->
    if e.keyCode == 13
      $('#search_button').click()

  # 添加一个成员
  $('a.add_member').click (e)->
    e.preventDefault()
    url = $(this).attr('href')
    $.get url, (data)->
      $('.add_member_section').html(data)

  $(this).on 'click', '.add_member_button', (e)->
    e.preventDefault()
    params = {
      user_id: $('#member_user_name').val(),
      role: $('#member_role').val()
    }
    url = $('.add_member_div').data('uri')
    $.post url, params, (data)->
      if data.success
        url = $('div.members').data('uri')
        $.get url, (data)->
          $('div.members').html(data)
        $('.add_member_section').empty()
      else
        alert(data.message)

  # 取消
  $(this).on 'click', '#cancel_member', (e)->
    e.preventDefault()
    $('.add_member_section').empty()
    
