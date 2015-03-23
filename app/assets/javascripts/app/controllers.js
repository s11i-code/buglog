angular.module('BugLog.controllers',[])
.controller('DashboardController',
    function($scope, BugTypeService) {
        BugTypeService.getAll().then(function(res){
            $scope.bugTypes = res.data;
        });

})
.controller('ManagementController',
    function($scope, BugTypeService) {
        console.log('dksaldk')
        BugTypeService.getAll().then(function(res){
            $scope.bugTypes = res.data;
        });

});