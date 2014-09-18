@app.controller 'InvestorProveController', ['$scope', '$http', '$upload', '$window', ($scope, $http, $upload, $window)->

  $scope.can_submit = ()->
    $scope.accept && $scope.card_url

  $http
    url: '/cards'
  .success (res)->
    unless res == 'null'
      $scope.card_url = res.url

  $http
    url: '/bank_statements'
  .success (res)->
    unless res == 'null'
      $scope.bank_statement_url = res.url

  $scope.upload = ($files)->
    $scope.card_error = null
    for file in $files
      $upload.upload
        url: '/cards'
        method: 'POST'
        file: file
      .success (res)->
        if res.success
          $scope.card_url = res.url
        else
          $scope.card_error = res.message
      .error ()->
        console.log '上传失败'

  $scope.upload_bank_statement = ($files)->
    $scope.card_error = null
    for file in $files
      $upload.upload
        url: '/bank_statements'
        method: 'POST'
        file: file
      .success (res)->
        if res.success
          $scope.bank_statement_url = res.url
        else
          $scope.bank_statement_error = res.message
      .error ()->
        console.log '上传失败'

  $scope.submit = ()->
    $http
      url: '/investors/submit'
      method: 'POST'
    .success (res)->
      if res.success
        $window.location.href = '/investors/info'
      else
        $window.location.href = '/'

  $scope.prev = ()->
    $window.location.href = '/investors/idea'

]
