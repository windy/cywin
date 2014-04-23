@app.controller 'ProjectCreateRequireController', [ '$scope', '$http', '$cookieStore', '$routeParams', '$location', ($scope, $http, $cookieStore, $routeParams, $location)->

  $scope.project_id = $routeParams.id

  $scope.back = ()->
    $location.url('/project/team' + '?id=' + $scope.project_id)


]
