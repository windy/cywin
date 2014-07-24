@app.controller 'DeliverProjectController', ['$scope', '$http', '$modal', ($scope, $http, $modal)->
  $scope.open_deliver_project_modal = (delivered_user_id)->
    modal = $modal.open
      templateUrl: 'deliver_project_modal.html'
      controller: 'DeliverProjectModalController',
      resolve:
        delivered_user_id: ->
          delivered_user_id
]

@app.controller 'DeliverProjectModalController', ['$scope', '$http', '$modalInstance', 'delivered_user_id', ($scope, $http, $modalInstance, delivered_user_id)->
  $scope.init_delivered_user_info = (user_id)->
    $http
      url: '/users/' + user_id
    .success (res)->
      $scope.delivered_user_info = res

  $scope.init_delivering_projects = ()->
    $http
      url: '/delivering_projects'
    .success (res)->
      $scope.delivering_projects = res

  $scope.init_delivered_user_info(delivered_user_id)
  $scope.init_delivering_projects()

  $scope.select_project = (project)->
    $scope.deliver_error = null
    $scope.selected_project = project

  $scope.is_delivering_projects_empty = ()->
    Utils.is_empty($scope.delivering_projects)

  $scope.deliver = ()->
    if ! $scope.selected_project
      $scope.deliver_error = '请先选择一个项目'
    else
      $http
        url: '/delivering_projects/' + $scope.selected_project.id
        method: 'PATCH'
        data:
          user_id: delivered_user_id
      .success (res)->
        $modalInstance.close()

  $scope.cancel = ()->
    $modalInstance.dismiss('cancel')
]
