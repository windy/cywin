window.Project =
  search: ()->
    search_name = $('#search_name').val()
    industry = $('.industry').find('.active a').attr('data-id')
    district = $('.district').find('.active a').attr('data-id')
    $.get '/projects_searcher/index', { search_name: search_name, industry: industry, district: district }, (data)->
      $('.projects_search').html(data)

$(document).ready ->
  $('.selection a, .industry a, .district a').click ->
    $(this).parent().addClass('active')
    $(this).parent().siblings().removeClass('active')
    Project.search()
    false
  $('.stage1 .add_member').click ()->
    #TODO
    false
  $('#search_button').click ()->
    Project.search()
    false
  # 回车注册
  $('#search_name').keyup (e)->
    if e.keyCode == 13
      $('#search_button').click()

  # 触发一次 ChinaCity
  $('.city-select').trigger('change')
