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
  
  $scope.hash = {
  }

  $scope.syndicate = ()->
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

]
