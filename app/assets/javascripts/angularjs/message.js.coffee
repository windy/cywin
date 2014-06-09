@app.controller 'MessageController', [ '$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  
  $scope.message_count = 0

  get_message_count = ()->
    $http
      url: '/messages/count'
      method: 'GET'
    .then (res)->
      $scope.message_count = res.data.count

  loop_get_message_count = ()->
    $timeout ()->
      get_message_count()
      loop_get_message_count()
    , 5000

  get_message_count()
  loop_get_message_count()

  $scope.is_empty = ()->
    $scope.message_count == 0
]
