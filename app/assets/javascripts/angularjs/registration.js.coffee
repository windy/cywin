@app.controller 'RegistrationController', [ '$scope', '$http', '$window', 'ipCookie', ($scope, $http, $window, ipCookie)->

  $scope.errors = ipCookie('registerErrors') || {}
  ipCookie.remove('registerErrors', { path: '/' })

  if user = ipCookie('register_users')
    $scope.name = user.name
    $scope.email = user.email
    $scope.password = user.password
    $scope.password_confirm = user.password
    $scope.code = user.code
    ipCookie.remove('register_users', {path: '/'})
  
  $scope.submit = ()->
    $http
      url: '/users'
      method: 'POST'
      params:
        'user[name]': $scope.name
        'user[email]': $scope.email
        'user[password]': $scope.password
        'code': $scope.code
    .success (res)->
      if res.success
        $window.location.href = '/home/welcome'
      else
        $scope.errors = res.errors
    .error (res, status)->
      $scope.error_message = '网络错误, 请重试, 错误码为: ' + status

  $scope.email_validate = ()->
    $http
      url: '/users/email_validate'
      method: 'POST'
      data:
        email: $scope.email
    .success (res)->
      if ! res.success
        $scope.errors.email = res.message
      else
        delete $scope.errors.email

  $scope.password_confirm_validate = ()->
    if $scope.password_confirm != $scope.password
      $scope.errors.password_confirm = '确认密码与原密码不一致'
    else
      delete $scope.errors.password_confirm

  $scope.submit_validate = ()->
    Utils.is_empty($scope.errors)

  $scope.delete_error_on = (column)->
    delete $scope.errors[column]
    
]
