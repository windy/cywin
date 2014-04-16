@app.controller 'RegistrationController', [ '$scope', '$timeout', '$http', ($scope, $timeout, $http)->
  
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
]
