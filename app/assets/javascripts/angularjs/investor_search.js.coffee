@app.controller 'InvestorSearchController', [ '$scope', '$http', '$window', ($scope, $http, $window)->

  $scope.search = ()->
    $window.location.href = '/investors/search/?q=' + $scope.q + '&investor_type=' + $scope.investor_type

  $scope.select_investor_type = (type)->
    $scope.investor_type = type
    $scope.search()

  $scope.is_selected_investor_type = (type)->
    $scope.investor_type == type
]
