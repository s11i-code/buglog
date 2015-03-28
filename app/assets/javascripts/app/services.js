angular.module('BugLog.services', [])

.factory('BugType', function($resource) {
    return $resource('/api/v1/bug_types/:id', { id: '@_id' }, {
        update: {
            method: 'PUT'
        },
        delete: { method: 'DELETE', params: {id: '@id'} }

    });
})
