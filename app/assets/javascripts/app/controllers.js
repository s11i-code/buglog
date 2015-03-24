angular.module('BugLog.controllers',[])
.controller('DashboardController',
    function($scope, BugTypeService) {
        BugTypeService.getAll().then(function(res){
            $scope.bug_types = res.data;
        });

})
.controller('ManagementController',
    function($scope, BugTypeService) {
        BugTypeService.getAll().then(function(res){
            $scope.bug_types = res.data;
        });

});