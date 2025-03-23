@app.controller 'InvestorBasicController', ['$scope', '$http', '$window', ($scope, $http, $window)->

  $http
    url: '/investors/basic.json'
  .success (res)->
    $scope.investor = res

  $http
    url: '/investments'
  .success (res)->
    $scope.investments = res

  $scope.submit = ()->
    $http
      url: '/investors'
      method: 'POST'
      params:
        $scope.investor
    .success (res)->
      if res.success
        $window.location.href= '/investors/idea'
      else
        $scope.errors = res.errors

  $scope.investment_create = ()->
    $http
      url: '/investments'
      method: 'POST'
      params:
        $scope.investment
    .success (res)->
      if res.success
        $scope.investments.push($scope.investment)
        $scope.investment = {}
        $scope.investment_errors = {}
        $scope.investment_added = false
      else
        $scope.investment_errors = res.errors
]