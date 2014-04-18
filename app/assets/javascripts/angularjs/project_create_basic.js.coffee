@app.controller 'ProjectCreateBasicController', [ '$scope', '$http', '$cookieStore', '$location', ($scope, $http, $cookieStore, $location)->

  $scope.submit = ()->
    $http
      url: '/projects'
      method: 'POST'
      params:
        $scope.project
    .success (res)->
      if res.success
        $location.url('/project/team')
      else
        $scope.errors = res.errors
        

]
