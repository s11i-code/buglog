angular.module('BugLog.controllers',[])
.controller('PagesController',
    function($scope, BugTypeService) {
        BugTypeService.getAll().then(function(res){
            $scope.bugTypes = res.data;
        });

});