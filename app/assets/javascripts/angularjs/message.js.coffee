@app.controller 'MessageController', [ '$scope', '$rootScope', '$http', '$timeout', 'message', ($scope, $rootScope, $http, $timeout, message)->

  $scope.message_count = ()->
    $rootScope.message_count

  $scope.is_empty = ()->
    $rootScope.message_count == 0
]
