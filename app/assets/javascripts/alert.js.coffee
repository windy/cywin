//= require jquery.pnotify
stack_bottomright = {"dir1": "up", "dir2": "left", "firstpos1": 25, "firstpos2": 25}
$.pnotify.defaults.styling = 'jqueryui'
$.pnotify.defaults.history = false
$.pnotify.defaults.delay = 3000
$.pnotify.defaults.mouse_reset = false
$.pnotify.defaults.stack = stack_bottomright
window.Alert =
  doit: (data, callback)->
    if typeof data == "string"
      $.pnotify
        title: '操作成功'
        text: ''
        type: 'success'
      if callback
        callback(data)
      return true
    if data.success
      $.pnotify
        title: '操作成功'
        text: data.message
        type: 'success'
      if callback
        callback(data)
      true
    else
      $.pnotify
        title: '操作失败'
        text: data.message
        addclass: 'stack-bottomright'
        type: 'error'
      false

  fail: (data)->
    window.Alert.doit(success: false, message: data)

  enable_global_alert: ->
    $.ajaxSetup
      error: (xhr, error)->
        if xhr.status == 401
          window.Alert.fail('未登录, 请重新登录')
        else if xhr.status == 403
          window.Alert.fail('权限不足')
        else if xhr.status == 500
          window.Alert.fail('服务器错误')
        else
          window.Alert.fail('网络错误, 请稍后刷新重试: ErrorCode=' + xhr.status)

$(document).ready ->
  Alert.enable_global_alert()

  $('#ajaxalert-close').click (e)->
    e.preventDefault()
    $(this).parent().hide()
           
