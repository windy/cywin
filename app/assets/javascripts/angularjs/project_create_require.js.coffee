@app.controller 'ProjectCreateRequireController', [ '$scope', '$http', '$cookieStore', '$routeParams', '$location', '$window', ($scope, $http, $cookieStore, $routeParams, $location, $window)->

  $scope.project_id = $routeParams.id
  $scope.money_require_flag = true
  $scope.person_require_flag = false

  $http
    url: '/money_requires/dirty_show'
    method: 'GET'
    params:
      project_id: $scope.project_id
  .success (res)->
    $scope.money = res.data.money
    $scope.share = res.data.share
    $scope.money_require_id = res.data.id

  $scope.complete = ()->
    if $scope.money_require_id
      $http
        url: '/money_requires/' + $scope.money_require_id + '/dirty_update'
        method: 'PATCH'
        params:
          money: $scope.money
          share: $scope.share
      .success (res)->
        if res.success
          $window.location.href = '/projects/' + $scope.project_id
        else
          $scope.complete_error = res.message
    else
      $http
        url: '/money_requires/dirty_create'
        method: 'POST'
        params:
          project_id: $scope.project_id
          money: $scope.money
          share: $scope.share
      .success (res)->
        if res.success
          $window.location.href = '/projects/' + $scope.project_id
        else
          $scope.complete_error = res.message

  $scope.back = ()->
    $location.url('/project/team' + '?id=' + $scope.project_id)


]
