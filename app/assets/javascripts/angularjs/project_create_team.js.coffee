@app.controller 'ProjectCreateTeamController', [ '$scope', '$http', '$cookieStore', '$location', '$routeParams', ($scope, $http, $cookieStore, $location, $routeParams)->

  $scope.project_id = $routeParams.id

  $http.get('/projects/' + $scope.project_id + '/members/owner').success (res)->
    $scope.owner = res.data

  $scope.update_owner = ()->
    $http
      url: '/projects/' + $scope.project_id + '/members/' + $scope.owner.user_id
      method: 'PATCH'
      params:
        name: $scope.owner.name
        title: $scope.owner.title
        description: $scope.owner.description
    .success (res)->
      if res.success
        $scope.owner_edited = false
      else
        $scope.owner_edit_error = res.message

  $scope.cancel_owner_edit = ()->
    $http.get('/projects/' + $scope.project_id + '/members/owner').success (res)->
      $scope.owner = res.data
      $scope.owner_edited = false

  $scope.next = ()->
    $location.url('/project/require' + "?id=" + $scope.project_id)

  $scope.prev = ()->
    $location.url('/project/basic' + '?id=' + $scope.project_id)


]
