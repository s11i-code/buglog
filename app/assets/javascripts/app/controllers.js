angular.module('BugLog.controllers', [])

    .controller('DashboardController',
    function ($scope, BugType) {
        $scope.bug_types = BugType.query()
    })

    .controller('ManagementController',
    function ($scope, BugType) {

        $scope.bug_types = BugType.query()

        $scope.alerts = []

        $scope.closeAlert = function (index) {
            $scope.alerts.splice(index, 1);
        }

        $scope.updateBugType = function (bug_type) {
            BugType.update({ id: bug_type.id }, bug_type, function () {
                $scope.alerts.push({type: "success", msg: 'Saved!'});
            })
        }
    })