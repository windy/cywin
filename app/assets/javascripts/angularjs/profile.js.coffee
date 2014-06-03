@app.controller 'ProfileController', [ '$scope', '$http', '$upload', ($scope, $http, $upload)->

  $scope.upload_avatar = ($files)->
    $scope.avatar_error = null
    for file in $files
      $scope.upload = $upload.upload
        url: '/avatars'
        method: 'POST'
        data:
          user_id: $scope.user_id
        file: file
      .success (res)->
        if res.success
          $scope.avatar = res.url
        else
          $scope.avatar_error = res.message
      .error ()->
        console.log '上传失败'
]
