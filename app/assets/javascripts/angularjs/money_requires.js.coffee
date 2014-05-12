@app.controller 'MoneyRequireController', [ '$scope', '$http', ($scope, $http)->
  $scope.init = (project_id)->
    $scope.project_id = project_id
    $scope.init_opened()
    $scope.init_history()

  $scope.init_opened = ()->
    $http
      url: '/money_requires/opened.json'
      params:
        project_id: $scope.project_id
    .success (res)->
      if res == "null"
        $scope.opened = null
      else
        $scope.opened = res

  $scope.init_history = ()->
    $http
      url: '/money_requires/history.json'
      params:
        project_id: $scope.project_id
    .success (res)->
      $scope.histories = res

  $scope.format_start_end_time = (money_require)->
    if money_require
      end = money_require.end || ''
      '( ' + money_require.start + ' - ' + end + ' )'
    else
      ''
  $scope.format_status = (status)->
    switch status
      # ready -> leader_needed -> leader_need_confirmed -> opened -> closed
      when 'ready' then '未开始'
      when 'leader_needed' then '寻找领投人'
      when 'leader_need_confirmed' then '领投确认中'
      when 'opened' then '融资中'
      when 'closed' then '已结束'
  $scope.format_leader = (leader)->
    if leader
      leader.name + ' 正在领投'
    else
      '空缺中'
]
