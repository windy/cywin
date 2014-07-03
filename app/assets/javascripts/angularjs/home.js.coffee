@app.controller 'HomeController', [ '$scope', '$http', '$window', 'ipCookie', ($scope, $http, $window, ipCookie)->
  
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
        ipCookie('registerErrors', res.errors)
        ipCookie('register_users', { name: $scope.name, email: $scope.email, password: $scope.password, code: $scope.code })
        $window.location.href = '/users/sign_up'
    .error ()->
        $window.location.href = '/users/sign_up'
]
