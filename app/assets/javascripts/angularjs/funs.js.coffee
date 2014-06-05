@app.controller 'FunsController', [ '$scope', '$http', ($scope, $http)->

  $scope.init = (user_id, is_fun)->
    $scope.user_id = user_id
    $scope.is_fun = is_fun
    $scope.loading = false

  $scope.add_fun = ()->
    $scope.loading = true
    $http
      url: '/funs'
      method: 'POST'
      data:
        id: $scope.user_id
    .success (res)->
      $scope.loading = false
      if res.success
        $scope.is_fun = true

  $scope.remove_fun = ()->
    $scope.loading = true
    $http
      url: '/funs'
      method: 'DELETE'
      params:
        id: $scope.user_id
    .success (res)->
      $scope.loading = false
      if res.success
        $scope.is_fun = false
]
