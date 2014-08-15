@app.controller 'ProjectCreateBasicController', [ '$scope', '$http', '$location', '$routeParams', '$upload', '$timeout', '$modal', ($scope, $http, $location, $routeParams, $upload, $timeout, $modal)->

  $scope.project_id = $routeParams.id
  $scope.project = {}
  if $scope.project_id
    $http.get('/projects/' + $scope.project_id).success (res)->
      $scope.project = res

  $scope.submit = ()->
    if $scope.project_id
      $scope.update()
    else
      $scope.create()

  $scope.create = ()->
    $http
      url: '/projects'
      method: 'POST'
      data:
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
        $scope.screenshot_error = res.screenshot_error
        $timeout ()->
          $scope.error_message = null
        ,5000

  $scope.update = ()->
    $http
      url: '/projects/' + $scope.project_id
      method: 'PATCH'
      data:
        $scope.project
    .success (res)->
      if res.success
        $location.url('/project/team' + '?id=' + $scope.project_id)
      else
        $scope.error_message = res.message
        $scope.errors = res.errors
        $scope.logo_error = res.logo_error
        $scope.screenshot_error = res.screenshot_error
        $timeout ()->
          $scope.error_message = null
        ,5000

  $scope.upload_logo = ($files)->
    $scope.logo_error = null
    for file in $files
      $upload.upload
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

  $scope.upload_screenshot = ($files)->
    $scope.screenshot_error = null
    for file in $files
      $upload.upload
        url: '/screenshots'
        method: 'POST'
        file: file
      .success (res)->
        if res.success
          $scope.project.screenshot_url = res.data.image_url
          $scope.project.screenshot_id = res.data.id
        else
          $scope.screenshot_error = res.message
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

  $scope.select_industry = ()->
    modal = $modal.open
      templateUrl: 'select_industry.html'
      controller: 'SelectIndustryModalController',
      resolve:
        industries: ->
          $scope.project.industries
    modal.result.then (industries)->
      $scope.project.industries = industries

  $scope.is_empty_industries = ()->
    _.isEmpty($scope.project.industries)

  $scope.revert_select = (industry)->
    $scope.project.industries = _.without($scope.project.industries, industry)
]

@app.controller 'SelectIndustryModalController', ['$scope', '$http', '$modalInstance', ($scope, $http, $modalInstance)->
  $scope.hash = {}
  $scope.hash.categories = []
  $scope.hash.industries = []
  
  $scope.init_industries = ()->
    $http
      url: '/categories.json'
    .success (res)->
      $scope.hash.categories = res
      $scope.hash.head = _.first($scope.hash.categories)

  $scope.select_head = (head)->
    $scope.hash.head = head
  
  $scope.toggleIndustry = (industry, event)->
    event.stopPropagation()
    industries = $scope.hash.industries
    found = _.find industries, (i)->
      i.id == industry.id
    if found
      $scope.hash.industries = _.without(industries, found)
    else
      industries.push(industry)

  $scope.submit_industry = ()->
    $modalInstance.close($scope.hash.industries)

  $scope.is_empty_industries = ()->
    _.isEmpty($scope.hash.industries)
    

  $scope.revert_select = (industry)->
    $scope.hash.industries = _.without($scope.hash.industries, industry)

  $scope.is_selected_industry = (id)->
    _.findWhere($scope.hash.industries, {id: id})

  $scope.init_industries()

  $scope.cancel = ()->
    $modalInstance.dismiss('cancel')
]
