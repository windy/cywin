@app.factory 'MoneyRequire', ['$http', ($http)->
  return {
    init: ()->
      $http
        url: '/money_requires/opened'
        params:
          project_id: $scope.project_id
      .success (res)->
        if res == "null"
          $scope.money_require = {}
        else
          $scope.money_require = res
  }
]
