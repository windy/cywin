@app.controller 'MoneyRequireController', [ '$scope', '$http', '$modal', ($scope, $http, $modal)->
  $scope.init = (project_id)->
    $scope.project_id = project_id
    $scope.init_opened()
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
  # 注意
  # opened.syndicate.already_money 作为追加投资的标识
  $scope.hash = {
    submit: '投资'
    message: ''
    min_money: opened.syndicate.min_money
    money: opened.syndicate.min_money
  }

  if opened.syndicate.already_money
    $scope.hash.submit = '追加'
    $scope.hash.money = 0
    $scope.hash.already_message = '你正在追加投资, 你已经投资了: ' + opened.syndicate.already_money

  $scope.syndicate = ()->
    if $scope.opened.syndicate.already_money
      $http
        url: '/syndicates/' + $scope.opened.syndicate.already_investment_id
        method: 'PATCH'
        params:
          money: $scope.cal_total_money()
      .success (res)->
        if res.success
          new_opened = res.data
          $modalInstance.close(new_opened)
        else
          $scope.errors = res.errors
    else
      $http
        url: '/syndicates'
        method: 'POST'
        params:
          money_require_id: opened.id
          money: $scope.hash.money
      .success (res)->
        if res.success
          new_opened = res.data
          $modalInstance.close(new_opened)
        else
          $scope.errors = res.errors

  $scope.cal_total_money = ()->
     parseInt(opened.syndicate.already_money) + parseInt($scope.hash.money || 0 )

]
