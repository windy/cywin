@app.controller 'MoneyRequireAdminController', [ '$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  
  # 存储当前项目正在融资的需求, 如无, 则为 {}
  
  $scope.init = (project_id)->
    $scope.project_id = project_id
    $scope.init_money_require()

  $scope.init_money_require = ()->
    $http
      url: '/money_requires/opened'
      params:
        project_id: $scope.project_id
    .success (res)->
      $scope.money_require = res.money_require

  $scope.create_or_update = ()->
    if $scope.money_require.id
      $scope.update()
    else
      $scope.create()

  $scope.create = ()->
    $scope.money_require.errors = null
    $http
      url: '/money_requires'
      method: 'POST'
      params:
        $scope.money_require
    .success (res)->
      if res.success
        $scope.init_money_require()
      else
        $scope.money_require.errors = res.errors

  $scope.update = ()->
    $scope.money_require.errors = null
    $http
      url: '/money_requires/' + $scope.money_require.id
      method: 'PATCH'
      params:
        $scope.money_require
    .success (res)->
      if res.success
        $scope.init_money_require()
      else
        $scope.money_require.errors = res.errors

  # 搜索
  $scope.autocomplete_search_with_timeout = ()->
    if $scope.autocomplete_timeout
      $timeout.cancel( $scope.autocomplete_timeout )
    $scope.autocomplete_timeout = $timeout( $scope.autocomplete_search, 500 )

    
  $scope.autocomplete_search = ()->
    $http
      url: '/investors/autocomplete.json'
      params:
        search: $scope.autocomplete_user
    .success (res)->
      $scope.autocomplete_users = res

  $scope.select_leader = (user)->
    $scope.selected_leader = user
    $scope.autocomplete_users = null

  $scope.add_leader = ()->
    $http
      url: '/money_requires/' + $scope.money_require.id + '/add_leader'
      method: 'PATCH'
      params:
        leader_id: $scope.selected_leader.id
    .success (res)->
      $scope.money_require = res
]
