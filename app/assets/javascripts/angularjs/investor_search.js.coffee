@app.controller 'InvestorSearchController', [ '$scope', '$http', '$window', ($scope, $http, $window)->

  $scope.search = ()->
    $window.location.href = '/investors/search/?q=' + $scope.q
]
