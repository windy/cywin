@app.controller 'MoneyRequireController', [ '$scope', '$http', ($scope, $http)->
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
]
