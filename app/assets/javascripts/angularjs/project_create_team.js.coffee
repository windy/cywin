@app.controller 'ProjectCreateTeamController', [ '$scope', '$http', '$cookieStore', '$location', '$routeParams', '$upload', ($scope, $http, $cookieStore, $location, $routeParams, $upload)->

  $scope.project_id = $routeParams.id

  $http.get('/projects/' + $scope.project_id + '/members/owner').success (res)->
    $scope.owner = res.data

  $http.get('/projects/' + $scope.project_id + '/members/team_story').success (res)->
    $scope.team_story = res.team_story

  $scope.update_owner = ()->
    $http
      url: '/projects/' + $scope.project_id + '/members/' + $scope.owner.user_id
      method: 'PATCH'
      params:
        name: $scope.owner.name
        title: $scope.owner.title
        description: $scope.owner.description
    .success (res)->
      if res.success
        $scope.owner_edited = false
      else
        $scope.owner_edit_error = res.message

  $scope.cancel_owner_edit = ()->
    $http.get('/projects/' + $scope.project_id + '/members/owner').success (res)->
      $scope.owner = res.data
      $scope.owner_edited = false

  $scope.upload_avatar = ($files)->
    $scope.avatar_error = null
    for file in $files
      $scope.upload = $upload.upload
        url: '/avatars'
        method: 'POST'
        params:
          user_id: $scope.owner.user_id
        file: file
      .success (res)->
        if res.success
          $scope.owner.avatar = res.url
        else
          $scope.avatar_error = res.message
      .error ()->
        console.log '上传失败'

  $scope.update_team_story = ()->
    $http
      url: '/projects/' + $scope.project_id + '/members/update_team_story'
      method: 'POST'
      params:
        team_story: $scope.team_story
    .success (res)->
      $scope.team_edited = false

  $scope.cancel_team_edit = ()->
    $http.get('/projects/' + $scope.project_id + '/members/team_story').success (res)->
      $scope.team_story = res.team_story
      $scope.team_edited = false

  $scope.next = ()->
    $location.url('/project/require' + "?id=" + $scope.project_id)

  $scope.prev = ()->
    $location.url('/project/basic' + '?id=' + $scope.project_id)


]
