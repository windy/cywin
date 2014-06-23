@app.controller 'InvestorProveController', ['$scope', '$http', '$upload', '$window', ($scope, $http, $upload, $window)->

  $scope.can_submit = false

  $http
    url: '/cards'
  .success (res)->
    unless res == 'null'
      $scope.card_url = res.url
      $scope.can_submit = true

  $scope.upload = ($files)->
    $scope.card_error = null
    for file in $files
      $upload.upload
        url: '/cards'
        method: 'POST'
        file: file
      .success (res)->
        if res.success
          $scope.can_submit = true
          $scope.card_url = res.url
        else
          $scope.card_error = res.message
      .error ()->
        console.log '上传失败'

  $scope.submit = ()->
    $http
      url: '/investors/submit'
      method: 'POST'
    .success (res)->
      if res.success
        $window.location.href = '/'
      else
        $window.location.href = '/'

  $scope.prev = ()->
    $window.location.href = '/investors/idea'

]
