@app.controller 'ProjectCreateTeamController', [ '$scope', '$http', '$location', '$routeParams', '$upload', '$timeout', ($scope, $http, $location, $routeParams, $upload, $timeout)->

  $scope.project_id = $routeParams.id
  $scope.invite_user = ''
  $scope.autocomplete_invite = false

  $scope.init = (project_id)->
    $scope.project_id = project_id
    $scope.init_data()

  $scope.init_data = ()->
    $http.get('/projects/' + $scope.project_id + '/members/owner').success (res)->
      $scope.owner = res.data
    $http.get('/projects/' + $scope.project_id + '/members/team_story').success (res)->
      $scope.team_story = res.team_story
    $http.get('/projects/' + $scope.project_id + '/members').success (res)->
      $scope.members = res.data

  if $routeParams.id
    $scope.init_data()

  $scope.open_owner_edited = ()->
    $scope.owner_edited = true
    $scope.owner_edit = angular.copy($scope.owner)

  $scope.update_owner = ()->
    $http
      url: '/projects/' + $scope.project_id + '/members/' + $scope.owner.user_id
      method: 'PATCH'
      data:
        name: $scope.owner_edit.name
        title: $scope.owner_edit.title
        description: $scope.owner_edit.description
    .success (res)->
      if res.success
        $scope.owner.name = $scope.owner_edit.name
        $scope.owner.title = $scope.owner_edit.title
        $scope.owner.description = $scope.owner_edit.description
        $scope.owner_edited = false
      else
        $scope.owner_edit_error = res.message

  $scope.cancel_owner_edit = ()->
    $scope.owner_edited = false

  $scope.upload_avatar = ($files)->
    $scope.avatar_error = null
    for file in $files
      $upload.upload
        url: '/avatars'
        method: 'POST'
        data:
          user_id: $scope.owner.user_id
        file: file
      .success (res)->
        if res.success
          $scope.owner.avatar = res.url
        else
          $scope.avatar_error = res.message
      .error ()->
        console.log '上传失败'

  $scope.open_team_story_edited = ()->
    $scope.team_story_edit = $scope.team_story
    $scope.team_edited = true

  $scope.update_team_story = ()->
    $http
      url: '/projects/' + $scope.project_id + '/members/update_team_story'
      method: 'POST'
      data:
        team_story: $scope.team_story_edit
    .success (res)->
      $scope.team_story = $scope.team_story_edit
      $scope.team_edited = false

  $scope.cancel_team_edit = ()->
    $scope.team_edited = false

  $scope.autocomplete_member = (viewValue)->
    $http
      url: '/projects/' + $scope.project_id + '/members/autocomplete'
      method: 'GET'
      params:
        search: viewValue
    .then (res)->
      res = res.data
      # email邀请
      if res.email
        if res.success
          return res.data
        else
          $scope.autocomplete_invite = true
          $scope.autocomplete_invite_name = res.name
          return []
      else
      # 普通用户名
        if res.success
          return res.data
        else
          return []

  $scope.add_member = (autocomplete_user)->
    return false if autocomplete_user.joined
    $http
      url: '/projects/' + $scope.project_id + '/members'
      method: 'POST'
      data:
        user_id: autocomplete_user.user_id
    .success (res)->
      if res.success
        $scope.members.push(res.data)
        $scope.members_edited = false
      else
        console.log res

  $scope.remove_member = ($event, member)->
    $event.preventDefault()
    $http
      url: '/projects/' + $scope.project_id + '/members/' + member.user_id
      method: 'DELETE'
    .success (res)->
      if res.success
        $scope.members = (x for x in $scope.members when x != member)
        member.member_edited = false
      else
        console.log res

  $scope.invite_member = (email)->
    $http
      url: '/projects/' + $scope.project_id + '/members/invite'

  $scope.update_member = (member)->
    member.member_error = null
    $http
      url: '/projects/' + $scope.project_id + '/members/' + member.user_id
      method: 'PATCH'
      data:
        title: member.title
        description: member.description
    .success (res)->
      if res.success
        member.member_error = null
        member.member_edited = false
      else
        member.member_error = res.message

  $scope.autocomplete_invite_user = ()->
    $http
      url: '/projects/' + $scope.project_id + '/members/invite'
      method: 'POST'
      data:
        name: $scope.autocomplete_invite_name
        email: $scope.invite_user
    .success (res)->
      if res.success
        $scope.members.push(res.data)
        $scope.members_edited = false


  $scope.next = ()->
    $location.url('/project/require' + "?id=" + $scope.project_id)

  $scope.prev = ()->
    $location.url('/project/basic' + '?id=' + $scope.project_id)


]
