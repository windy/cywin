@app.controller 'MoneyRequireAdminController', [ '$scope', '$http', ($scope, $http)->
  
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
      url: '/money_requires' + $scope.money_require.id
      method: 'PATCH'
      params:
        $scope.money_require
    .success (res)->
      if res.success
        $scope.init_money_require()
      else
        $scope.money_require.errors = res.errors
]
