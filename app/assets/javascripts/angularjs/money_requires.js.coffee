@app.controller 'MoneyRequireController', [ '$scope', '$http', '$modal', ($scope, $http, $modal)->
  $scope.init = (project_id, { init_opened, init_history })->
    init_opened ?= true
    init_history ?= true
    $scope.project_id = project_id
    if init_opened
      $scope.init_opened()
    if init_history
      $scope.init_history()

  $scope.init_opened = ()->
    $http
      url: '/money_requires/opened.json'
      params:
        project_id: $scope.project_id
    .success (res)->
      if res == "null"
        $scope.opened = null
      else
        $scope.opened = res

  $scope.init_history = ()->
    $http
      url: '/money_requires/history.json'
      params:
        project_id: $scope.project_id
    .success (res)->
      if res == 'null'
        $scope.histories = []
      else
        $scope.histories = res

  $scope.is_histories_empty = ()->
    Utils.is_empty($scope.histories)

  $scope.open_syndicate = ()->
    modal = $modal.open
      templateUrl: 'syndicate.html'
      controller: 'SyndicateModalController',
      resolve:
        opened: ->
          $scope.opened
    
    modal.result.then (new_opened)->
      $scope.opened = new_opened

]

@app.controller 'SyndicateModalController', [ '$scope', '$http', '$modalInstance', 'opened', ($scope, $http, $modalInstance, opened)->

  $scope.opened = opened

  $scope.behave = ()->
    $scope.opened.syndicate.behave
    
  switch $scope.behave()
    when "leader_confirm"
      $scope.hash = {
        submit: '领投确认并投资'
        min_money: $scope.opened.min_money
        money: $scope.min_money
      }
    when "invest"
      $scope.hash = {
        submit: '投资'
        min_money: $scope.opened.min_money
        money: $scope.min_money
      }
    when "add"
      $scope.hash = {
        submit: '追加'
        money: 0
        min_money: $scope.opened.min_money
        already_message: '你正在追加投资, 你已经投资了: '
        already_money: $scope.opened.syndicate.already_money
      }

  $scope.syndicate = ()->
    if $scope.behave() == 'leader_confirm'
      $http
        url: '/money_requires/' + $scope.opened.id + '/leader_confirm'
        method: 'POST'
        data:
          money: $scope.hash.money
          leader_word: $scope.hash.leader_word
      .success (res)->
        if res.success
          new_opened = res.data
          $modalInstance.close(new_opened)
        else
          $scope.errors = res.errors
    else if $scope.behave() == 'add'
      $http
        url: '/syndicates/' + $scope.opened.syndicate.already_investment_id
        method: 'PATCH'
        data:
          money: $scope.cal_total_money()
      .success (res)->
        if res.success
          new_opened = res.data
          $modalInstance.close(new_opened)
        else
          $scope.errors = res.errors
    else if $scope.behave() == 'invest'
      $http
        url: '/syndicates'
        method: 'POST'
        data:
          money_require_id: opened.id
          money: $scope.hash.money
      .success (res)->
        if res.success
          new_opened = res.data
          $modalInstance.close(new_opened)
        else
          $scope.errors = res.errors

  $scope.cancel = ()->
    $modalInstance.dismiss('cancel')

  $scope.cal_total_money = ()->
    money = $scope.hash.money || 0
    if ! $scope.opened.syndicate
      already_money = 0
    else
      already_money = $scope.opened.syndicate.already_money
    parseInt(already_money) + parseInt(money)

]
