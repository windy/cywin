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
  
  $scope.autocomplete_categories_search = ()->
    $scope.autocomplete_categories_error = null
    if $scope.autocomplete_categories_search_timeout
      $timeout.cancel( $scope.autocomplete_categories_search_timeout )
    $scope.autocomplete_categories_search_timeout = $timeout ()->
      $http
        url: '/categories/autocomplete'
        method: 'GET'
        params:
          search: $scope.project.industry
      .success (res)->
        if res.success
          $scope.autocomplete_categories = res.data
        else
          $scope.autocomplete_categories_error = '系统中尚无此行业分类, 我们将直接创建'
          $scope.autocomplete_categories = []

    , 500

  $scope.autocomplete_categories_is_empty = ()->
    unless $scope.autocomplete_categories
      return true
    $scope.autocomplete_categories.length == 0

  $scope.add_category = (category)->
    $scope.project.industry = category.name
    $scope.autocomplete_categories = []
]
