@app.controller 'SyndicateInfoController', [ '$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  $scope.init = (money_require_id)->
    if money_require_id?
      $scope.money_require_id = money_require_id
      $http
        url: '/syndicates'
        params:
          money_require_id: money_require_id
      .success (res)->
        $scope.leader = res.leader
        $scope.investments = res.investments
]
