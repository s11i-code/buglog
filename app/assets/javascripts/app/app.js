angular.module('BugLog',['ngRoute', 'BugLog.controllers', 'BugLog.services'])
.config(function($routeProvider){
    $routeProvider.when('/', {
        templateUrl: '/templates/dashboard.html',
        controller: 'PagesController'
    })
        .otherwise({redirectTo: '/'});
});