@app.controller 'JobSearchController', [ '$scope', '$http', '$window', ($scope, $http, $window)->

  $scope.search = ()->
    $window.location.href = '/jobs/search/?q=' + $scope.q
]
