@app.controller 'ProjectEditController', [ '$scope', '$http', ($scope, $http)->
  $scope.init = (id)->
    $scope.project_id = id
]
