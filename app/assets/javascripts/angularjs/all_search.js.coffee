@app.controller 'AllSearchController', [ '$scope', '$http', '$window', ($scope, $http, $window)->

  $scope.search = ($event)->
    $event.preventDefault()
    $window.location.href = '/home/search/?q=' + $scope.q
]
