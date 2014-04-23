@app.controller 'ProjectCreateTeamController', [ '$scope', '$http', '$cookieStore', '$location', '$routeParams', '$upload', '$timeout', ($scope, $http, $cookieStore, $location, $routeParams, $upload, $timeout)->

  $scope.project_id = $routeParams.id
  $scope.invite_user = ''
  $scope.autocomplete_invite = false
  $scope.autocomplete_timeout = null

  $http.get('/projects/' + $scope.project_id + '/members/owner').success (res)->
    $scope.owner = res.data

  $http.get('/projects/' + $scope.project_id + '/members/team_story').success (res)->
    $scope.team_story = res.team_story

  $http.get('/projects/' + $scope.project_id + '/members').success (res)->
    $scope.members = res.data

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

  $scope.autocomplete_search_with_timeout = ()->
    if $scope.autocomplete_timeout
      $timeout.cancel( $scope.autocomplete_timeout )
    $scope.autocomplete_timeout = $timeout( $scope.autocomplete_search, 500 )

  $scope.autocomplete_search = ()->
    $scope.autocomplete_users = null
    $scope.autocomplete_invite = false
    return unless $scope.invite_user.length > 1
    $http
      url: '/projects/' + $scope.project_id + '/members/autocomplete'
      method: 'GET'
      params:
        search: $scope.invite_user
    .success (res)->
      # email邀请
      if res.email
        if res.success
          $scope.autocomplete_users = res.data
        else
          $scope.autocomplete_invite = true
          $scope.autocomplete_invite_name = res.name
      else
      # 普通用户名
        if res.success
          $scope.autocomplete_users = res.data
        else
          $scope.autocomplete_users = []

  $scope.add_member = (autocomplete_user)->
    return if autocomplete_user.joined
    $http
      url: '/projects/' + $scope.project_id + '/members'
      method: 'POST'
      params:
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
      params:
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
      params:
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
