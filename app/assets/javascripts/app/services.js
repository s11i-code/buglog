angular.module('BugLog.services', [])
.factory('BugTypeService', function ($q, $http) {

    function get() {
        return $http.get('http://localhost:3000/api/v1/bug_types');
    }

    return{getAll: get};

});



