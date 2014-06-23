@app.factory 'message', ['$rootScope', '$http', '$timeout', ($rootScope, $http, $timeout)->

  $rootScope.message_count = 0
  get_message_count = ()->
    $http
      url: '/messages/count'
      method: 'GET'
    .then (res)->
      $rootScope.message_count = res.data.count

  loop_get_message_count = ()->
    $timeout ()->
      get_message_count()
      loop_get_message_count()
    , 10000

  get_message_count()
  loop_get_message_count()

  return {}
]
