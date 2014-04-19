@app.controller 'ProjectCreateBasicController', [ '$scope', '$http', '$cookieStore', '$location', '$routeParams', ($scope, $http, $cookieStore, $location, $routeParams)->
  $scope.project_id = $routeParams.id
  if $scope.project_id
    $http.get('/projects/' + $scope.project_id).success (res)->
      $scope.project = res.data

  $scope.submit = ()->
    if $scope.project_id
      $scope.update()
    else
      $scope.create()

  $scope.create = ()->
    $http
      url: '/projects'
      method: 'POST'
      params:
        $scope.project
    .success (res)->
      if res.success
        new_url = $location.absUrl() + '?id=' + res.id
        window.history.replaceState({}, 'basic', new_url)
        $location.url('/project/team' + '?id=' + res.id)
      else
        $scope.errors = res.errors

  $scope.update = ()->
    $http
      url: '/projects/' + $scope.project_id
      method: 'PATCH'
      params:
        $scope.project
    .success (res)->
      if res.success
        $location.url('/project/team' + '?id=' + $scope.project_id)
      else
        $scope.errors = res.errors
]
