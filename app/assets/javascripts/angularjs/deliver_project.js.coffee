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

  $scope.selected_projects = []


  $scope.init_delivering_projects = ()->
    $http
      url: '/delivering_projects'
    .success (res)->
      $scope.delivering_projects = res

  $scope.init_delivered_user_info(delivered_user_id)
  $scope.init_delivering_projects()

  $scope.toggle_project = (project)->
    $scope.deliver_error = null
    if $scope.is_selected_project(project)
      $scope.selected_projects = _.without($scope.selected_projects, project)
    else
      $scope.selected_projects.push(project)

  $scope.is_selected_project = (project)->
    _.findWhere($scope.selected_projects, {id: project.id})


  $scope.is_delivering_projects_empty = ()->
    Utils.is_empty($scope.delivering_projects)

  $scope.deliver = ()->
    if _.isEmpty($scope.selected_projects)
      $scope.deliver_error = '请至少选择一个项目'
    else
      ids = _.map $scope.selected_projects, (project)->
        project.id
      $http
        url: '/delivering_projects/'
        method: 'POST'
        data:
          user_id: delivered_user_id
          ids: ids
      .success (res)->
        $modalInstance.close()

  $scope.cancel = ()->
    $modalInstance.dismiss('cancel')
]
