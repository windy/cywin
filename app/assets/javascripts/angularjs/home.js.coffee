@app.controller 'HomeController', [ '$scope', '$http', '$cookieStore', ($scope, $http, $cookieStore)->
  
  $scope.submit = ()->
    $http
      url: '/users'
      method: 'POST'
      data:
        'user[name]': $scope.name
        'user[email]': $scope.email
        'user[password]': $scope.password
    .success (res)->
      if res.success
        window.location.href = '/home/welcome'
      else
        $cookieStore.put('register_errors', res.errors)
        $cookieStore.put('register_users', { name: $scope.name, email: $scope.email, password: $scope.password })
        window.location.href = '/users/sign_up'
    .error ()->
        window.location.href = '/users/sign_up'
]
