@app.controller 'MoneyRequireAdminController', [ '$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  
  $scope.loading = true
  
  $scope.init = (project_id)->
    $scope.project_id = project_id
    $scope.init_money_require()
    $scope.loading = false

  $scope.init_money_require = ()->
    $http
      url: '/money_requires/opened'
      params:
        project_id: $scope.project_id
    .success (res)->
      if res == "null"
        $scope.money_require = {}
      else
        $scope.money_require = res

  $scope.prevalue = ()->
    $scope.money_require?.money * (100 - $scope.money_require?.share ) / $scope.money_require?.share

  $scope.create_or_update = ()->
    $scope.money_require.errors = null
    if $scope.money_require.id
      $scope.update()
    else
      $scope.create()

  $scope.create = ()->
    $scope.money_require.project_id = $scope.project_id
    $http
      url: '/money_requires'
      method: 'POST'
      data:
        $scope.money_require
    .success (res)->
      if res.success
        $scope.init_money_require()
      else
        $scope.money_require.errors = res.errors

  $scope.update = ()->
    $http
      url: '/money_requires/' + $scope.money_require.id
      method: 'PATCH'
      data:
        $scope.money_require
    .success (res)->
      if res.success
        $scope.init_money_require()
        $scope.opened_menu = false
      else
        $scope.money_require.errors = res.errors

    
  $scope.autocomplete_search = (val)->
    $http
      url: '/investors/autocomplete.json'
      params:
        search: val
    .then (res)->
      res.data

  $scope.selected_leader = ()->
    typeof($scope.autocomplete_user) == "object"

  $scope.add_leader = ()->
    $http
      url: '/money_requires/' + $scope.money_require.id + '/add_leader'
      method: 'PATCH'
      data:
        leader_id: $scope.autocomplete_user.id
    .success (res)->
      if res.success == false
        $scope.leader_error_message = res.message
      else
        $scope.money_require = res
]
