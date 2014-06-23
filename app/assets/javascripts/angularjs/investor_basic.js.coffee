@app.controller 'InvestorBasicController', ['$scope', '$http', '$window', ($scope, $http, $window)->

  $http
    url: '/investors/basic.json'
  .success (res)->
    $scope.investor = res

  $scope.submit = ()->
    $http
      url: '/investors'
      method: 'POST'
      data:
        $scope.investor
    .success (res)->
      if res.success
        $window.location.href= '/investors/idea'
      else
        $scope.errors = res.errors
]
