angular.module('BugLog.controllers', [])

    .controller('DashboardController',
    function ($scope, BugType) {
        $scope.bug_types = BugType.query()
    })

    .controller('ManagementController',
    function ($scope, BugType, $interpolate) {

        $scope.bug_types = BugType.query()

        $scope.alerts = []

        $scope.closeAlert = function (index) {
            $scope.alerts.splice(index, 1);
        }

        $scope.createBugType = function (bug_type) {
            bug_type = new BugType(bug_type)
            bug_type.$save(function () {
                $scope.bug_types.push(bug_type)
                $scope.alerts.push({type: "success", msg: $interpolate('Saved bug type {{ name }}.')(bug_type)})
            })
        }

        $scope.updateBugType = function (bug_type) {
            BugType.update({ id: bug_type.id }, bug_type, function () {
                $scope.alerts.push({type: "success", msg: $interpolate('Saved bug type {{ name }}.')(bug_type) });
            })
        }

        $scope.destroyBugType = function (index, bug_type) {
            confirmText = $interpolate("Are you sure you want to remove {{name}}?")(bug_type)
            if (confirm(confirmText)) {
                BugType.delete({id: bug_type.id}, function () {
                    $scope.bug_types.splice(index, 1)
                    $scope.alerts.push({type: "success", msg: $interpolate('Deleted bug type {{ name }}.')(bug_type)})
                })
            }

        }
    })