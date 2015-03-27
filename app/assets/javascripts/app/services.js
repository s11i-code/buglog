angular.module('BugLog.services', [])
.factory('BugTypeService', function ($q, $http) {

    function get() {
        //hard-coded user id until sign in is fully implemented
        return $http.get('api/v1/users/1/bug_types');
    }

    return{getAll: get};

});



