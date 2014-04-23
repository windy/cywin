@app.controller 'ProjectCreateRequireController', [ '$scope', '$http', '$cookieStore', '$routeParams', '$location', '$window', ($scope, $http, $cookieStore, $routeParams, $location, $window)->

  $scope.project_id = $routeParams.id
  $scope.money_require_flag = true
  $scope.person_require_flag = false
  $scope.add_person_require_data = {}
  $scope.add_person_require_data.errors = {}

  $http
    url: '/money_requires/dirty_show'
    method: 'GET'
    params:
      project_id: $scope.project_id
  .success (res)->
    $scope.money = res.data.money
    $scope.share = res.data.share
    $scope.money_require_id = res.data.id

  $http
    url: '/projects/' + $scope.project_id + '/person_requires'
    method: 'GET'
  .success (res)->
    if res.success
      $scope.person_requires = res.data

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

  $scope.add_person_require = ()->
    $scope.add_person_require_error = null
    $scope.add_person_require_data.errors = {}
    $http
      url: '/projects/' + $scope.project_id + '/person_requires'
      method: 'POST'
      params:
        $scope.add_person_require_data
    .success (res)->
      if res.success
        $scope.person_requires.push($scope.add_person_require_data)
        $scope.add_person_require_data = {}
        $scope.person_require_edited = false
      else
        $scope.add_person_require_error = res.message
        $scope.add_person_require_data.errors = res.errors

  $scope.boolean2human = (bool)->
    if bool
      '是'
    else
      '否'

  $scope.back = ()->
    $location.url('/project/team' + '?id=' + $scope.project_id)


]
