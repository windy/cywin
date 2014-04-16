#= require angular
#= require angular-cookies
#= require angular-resource
#= require angular-sanitize
#= require_self
#= require_tree ./angularjs

@app = angular.module('app', ['ngCookies', 'ngSanitize'])

@app.config(["$httpProvider", (provider) ->
    provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    provider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'
])
