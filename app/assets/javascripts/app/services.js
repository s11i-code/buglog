angular.module('BugLog.services', [])

    .factory('BugType', function ($resource) {
        var BugType = $resource('/api/v1/bug_types/:id', { id: '@_id' }, {
            update: { method: 'PUT'},
            delete: { method: 'DELETE', params: {id: '@id'} }
        });
        BugType.prototype.isPersisted = function () {
            return !!this.id
        };
        return BugType;
    })

    .factory('Vote', function ($resource) {
        return $resource('/api/v1/votes/:id', { id: '@_id' }, {
            delete: { method: 'DELETE', params: { id: '@id'} }
        });
    })

    .factory('UserService', function ($q, $http) {
        function getCurrentUser() {
            return $http.get('/api/v1/current_user');
        }
        return{getCurrentUser: getCurrentUser};
    });
