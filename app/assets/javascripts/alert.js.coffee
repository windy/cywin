window.Alert =
  doit: (data, callback)->
    if data.success
      $('#ajaxalert').removeClass('alert').addClass('success')
      $('#ajaxalert-box').text(data.message || "操作成功")
      $('#ajaxalert').show()
      if callback
        callback(data)
      true
    else
      $('#ajaxalert').removeClass('success').addClass('alert')
      $('#ajaxalert-box').text(data.message || "操作失败")
      $('#ajaxalert').show()
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
           
