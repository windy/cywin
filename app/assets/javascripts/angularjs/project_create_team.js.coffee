@app.controller 'ProjectCreateTeamController', [ '$scope', '$http', '$cookieStore', '$location', ($scope, $http, $cookieStore, $location)->

  $http.get('/projects/1/members/owner').success (res)->
    $scope.owner = res.data

  $scope.next = ()->
    $location.url('/project/require')

  $scope.prev = ()->
    $location.url('/project/basic')


]
