#= require angular
#= require angular-cookies
#= require angular-resource
#= require angular-route
#= require angular-sanitize
#= require_self
#= require_tree ./angularjs

@app = angular.module('app', ['ngCookies', 'ngSanitize', 'ngRoute'])

@app.config ["$httpProvider", '$routeProvider', ($httpProvider, $routeProvider) ->
    # 配置 json 与 csrf
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'

    # 配置路由
    $routeProvider.when '/project/basic',
      templateUrl: 'project/basic.html'
      controller: 'ProjectCreateBasicController'
    .when '/project/team',
      templateUrl: 'project/team.html'
      controller: 'ProjectCreateTeamController'
]

