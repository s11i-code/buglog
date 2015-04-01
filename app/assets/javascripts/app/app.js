angular.module('BugLog',['ngRoute', 'ngResource','ui.bootstrap', 'BugLog.controllers', 'BugLog.services'])
.config(function($routeProvider){
    $routeProvider.when('/', {
        templateUrl: '/templates/home.html',
        controller: 'HomeController'
    })
    $routeProvider.when('/management', {
        templateUrl: '/templates/management.html',
        controller: 'ManagementController'
    })
        .otherwise({redirectTo: '/'});
});