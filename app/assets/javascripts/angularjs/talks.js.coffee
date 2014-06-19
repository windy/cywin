@app.controller 'TalksController', [ '$scope', '$http', ($scope, $http)->

  $scope.init = (project_id)->
    $scope.project_id = project_id

  $scope.talk = ()->
    return 'ok'
]
