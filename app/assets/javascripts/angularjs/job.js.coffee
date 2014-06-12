@app.controller 'JobController', [ '$scope', '$http', ($scope, $http)->

  $scope.init = (project_id)->
    $scope.project_id = project_id
    $scope.interest_person_requires = {}

  $scope.interest = (person_require_id)->
    $http
      url: '/projects/' + $scope.project_id + '/person_requires/' + person_require_id + '/interest'
      method: 'POST'
    .success (res)->
      if res.success
        $scope.interest_person_requires[person_require_id] = true
]
