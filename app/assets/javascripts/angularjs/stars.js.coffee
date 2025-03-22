@app.controller 'StarsController', [ '$scope', '$http', ($scope, $http)->

  $scope.init = (project_id, is_starred)->
    $scope.project_id = project_id
    $scope.is_starred = is_starred

  $scope.add_star = ()->
    $scope.loading = true
    $http
      url: '/stars'
      method: 'POST'
      params:
        id: $scope.project_id
    .success (res)->
      $scope.loading = false
      if res.success
        $scope.is_starred = true

  $scope.remove_star = ()->
    $scope.loading = true
    $http
      url: '/stars'
      method: 'DELETE'
      params:
        id: $scope.project_id
    .success (res)->
      $scope.loading = false
      if res.success
        $scope.is_starred = false
  
]