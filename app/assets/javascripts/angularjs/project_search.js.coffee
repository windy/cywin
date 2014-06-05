@app.controller 'ProjectSearchController', [ '$scope', '$http', '$window', ($scope, $http, $window)->

  $scope.search = ()->
    $window.location.href = '/explore/search/?q=' + $scope.q
]
