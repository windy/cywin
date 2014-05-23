@app.controller 'ProjectCreateBasicController', [ '$scope', '$http', '$cookieStore', '$location', '$routeParams', '$upload', '$timeout', ($scope, $http, $cookieStore, $location, $routeParams, $upload, $timeout)->

  $scope.project_id = $routeParams.id
  $scope.project = {}
  if $scope.project_id
    $http.get('/projects/' + $scope.project_id).success (res)->
      $scope.project = res.data

  $scope.submit = ()->
    if $scope.project_id
      $scope.update()
    else
      $scope.create()

  $scope.create = ()->
    $http
      url: '/projects'
      method: 'POST'
      params:
        $scope.project
    .success (res)->
      if res.success
        new_url = $location.absUrl() + '?id=' + res.id
        window.history.replaceState({}, 'basic', new_url)
        $location.url('/project/team' + '?id=' + res.id)
      else
        $scope.error_message = res.message
        $scope.errors = res.errors
        $scope.logo_error = res.logo_error
        $timeout ()->
          $scope.error_message = null
        ,5000

  $scope.update = ()->
    $http
      url: '/projects/' + $scope.project_id
      method: 'PATCH'
      params:
        $scope.project
    .success (res)->
      if res.success
        $location.url('/project/team' + '?id=' + $scope.project_id)
      else
        $scope.error_message = res.message
        $scope.errors = res.errors
        $timeout ()->
          $scope.error_message = null
        ,5000

  $scope.upload_logo = ($files)->
    $scope.logo_error = null
    for file in $files
      $scope.upload = $upload.upload
        url: '/logos'
        method: 'POST'
        file: file
      .success (res)->
        if res.success
          $scope.project.logo_url = res.url
          $scope.project.logo_id = res.id
        else
          $scope.logo_error = res.message
      .error ()->
        console.log '上传失败'
  
  $scope.autocomplete_category = (viewValue)->
    $http
      url: '/categories/autocomplete'
      method: 'GET'
      params:
        search: viewValue
    .then (res)->
      res.data.data

  $scope.autocomplete_city = (viewValue)->
    $http
      url: '/cities/autocomplete'
      method: 'GET'
      params:
        search: viewValue
    .then (res)->
      res.data.data
]
