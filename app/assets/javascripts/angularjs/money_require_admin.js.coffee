@app.controller 'MoneyRequireAdminController', [ '$scope', '$http', '$modal', ($scope, $http, $modal)->
  
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

  $scope.open_leader_confirm_modal = ()->
    modal = $modal.open
      templateUrl: 'leader_confirm_modal.html'
      controller: 'LeaderConfirmModalController',
      resolve:
        project_id: ->
          $scope.project_id
        money_require: ->
          $scope.money_require

    modal.result.then (money_require)->
      $scope.money_require = money_require

]

@app.controller 'LeaderConfirmModalController', ['$scope', '$modalInstance', '$http', 'project_id', 'money_require', ($scope, $modalInstance, $http, project_id, money_require)->

  $scope.project_id = project_id
  $scope.money_require = money_require
  $scope.hash = {}

  $scope.create_or_update = ()->
    $scope.update()

  $scope.update = ()->
    $http
      url: '/money_requires/' + $scope.money_require.id
      method: 'PATCH'
      data:
        $scope.money_require
    .success (res)->
      if res.success == false
        $scope.money_require.errors = res.errors
      else
        $scope.money_require.errors = {}
        $scope.money_require_success = '更新成功'

  $scope.prevalue = ()->
    $scope.money_require?.money * (100 - $scope.money_require?.share ) / $scope.money_require?.share

  $scope.autocomplete_search = (val)->
    $http
      url: '/investors/autocomplete.json'
      params:
        search: val
    .then (res)->
      res.data

  $scope.selected_leader = ()->
    typeof($scope.hash.autocomplete_user) == "object"

  $scope.init_law_iterms = ()->
    $http
      url: '/law_iterms'
      params:
        money_require_id: $scope.money_require.id
    .success (res)->
      $scope.law_iterm_ids = res

  $scope.toggleLawIterm = (id)->
    if $scope.law_iterm_ids.indexOf(id) == -1
      $scope.law_iterm_ids.push(id)
    else
      $scope.law_iterm_ids.splice($scope.law_iterm_ids.indexOf(id), 1)

  $scope.init_law_iterms()

  $scope.update_law_iterms = ()->
    $http
      url: '/law_iterms'
      method: 'POST'
      data:
        ids: $scope.law_iterm_ids
        money_require_id: $scope.money_require.id
    .success (res)->
      if res.success == false
        $scope.law_iterms_success = null
        $scope.law_iterms_error = res.message
      else
        $scope.law_iterms_success = '更新成功'

  $scope.add_leader = ()->
    $scope.create_or_update()
    $scope.update_law_iterms()
    $http
      url: '/money_requires/' + $scope.money_require.id + '/add_leader'
      method: 'PATCH'
      data:
        leader_id: $scope.hash.autocomplete_user.id
        carry: $scope.money_require.carry
    .success (res)->
      if res.success == false
        $scope.carry_error_message = res.carry_error
        $scope.leader_error_message = res.leader_error
      else
        $scope.money_require = res
        $modalInstance.close($scope.money_require)

  $scope.cancel = ()->
    $modalInstance.dismiss('cancel')
]
