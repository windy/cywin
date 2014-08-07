@app.controller 'TalksController', [ '$scope', '$http', '$modal', ($scope, $http, $modal)->

  $scope.init = (is_talked)->
    $scope.is_talked = is_talked

  $scope.open_talk = (type, target_id)->
    modal = $modal.open
      templateUrl: 'talk.html'
      controller: 'TalkModalController',
      resolve:
        type: ->
          type
        target_id: ->
          target_id
    
    modal.result.then (is_talked)->
      $scope.is_talked = is_talked
]

@app.controller 'TalkModalController', ['$scope', '$modalInstance', '$http', 'type', 'target_id', ($scope, $modalInstance, $http, type, target_id)->
  $scope.types = [
    { id: 'project_talk', name: '投资约谈' },
    { id: 'lead_talk', name: '领投约谈' },
    { id: 'work_talk', name: '工作约谈' },
  ]
  $scope.hash = {
  }
  $scope.hash.type = ($scope.types.filter (x)-> x.id == type)[0]
  $scope.hash.talk_content = '请选择约谈类型, 再查看约谈内容'

  $scope.load_talk_content = ()->
    $scope.talk_content = '加载中...'
    $http
      url: '/talks/talk_content'
      params:
        type: $scope.hash.type.id
        target_id: target_id
    .success (res)->
      $scope.talk_content = res

  $scope.$watch 'hash.type', ()->
    $scope.load_talk_content()

  $scope.target_id = target_id

  $scope.talk = ()->
    $http
      url: '/talks'
      method: 'POST'
      data:
        type: $scope.hash.type.id
        target_id: $scope.target_id
    .success (res)->
      if res.success
        $modalInstance.close(true)
  $scope.cancel = ()->
    $modalInstance.dismiss('cancel')
]
