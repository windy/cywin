@app.controller 'RegistrationController', [ '$scope', '$timeout', '$http', ($scope, $timeout, $http)->

  $scope.errors = {}
  
  $scope.submit = ()->
    $http
      url: '/users'
      method: 'POST'
      params:
        'user[name]': $scope.name
        'user[email]': $scope.email
        'user[password]': $scope.password
    .success (res)->
      if res.success
        window.location.href = '/'
      else
        $scope.errors = res.errors
    .error (res, status)->
      $scope.error_message = '网络错误, 请重试, 错误码为: ' + status

  $scope.email_validate = ()->
    $http
      url: '/users/email_validate'
      method: 'POST'
      params:
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
