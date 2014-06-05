@app.controller 'TimelineController', [ '$scope', '$http', '$timeout', ($scope, $http, $timeout)->
  
  $scope.init = (start_with)->
    $scope.start_with = start_with
    $scope.events = []

  $scope.load_more = ()->
    $scope.loading = true
    $scope.no_content_flag = false
    $http
      url: '/events'
      method: 'GET'
      params:
        start_with: $scope.start_with
    .success (res)->
      $scope.loading = false
      if Utils.is_empty(res.data)
        $scope.no_content_flag = true
        $scope.timeout = $timeout ()->
          $scope.no_content_flag = false
        , 3000
        return
      $scope.events.push(res.data)
      $scope.start_with = res.start_with
]
