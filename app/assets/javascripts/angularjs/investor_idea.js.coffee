@app.controller 'InvestorIdeaController', ['$scope', '$http', '$window', ($scope, $http, $window)->

  $http
    url: '/investideas.json'
  .success (res)->
    $scope.investidea = res
  $scope.submit = ()->
    $http
      url: '/investideas'
      method: 'POST'
      data:
        $scope.investidea
    .success (res)->
      if res.success
        $window.location.href = '/investors/prove'
      else
        $scope.errors = res.errors

  $scope.prev = ()->
    $window.location.href = '/investors/basic'
]
