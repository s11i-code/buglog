angular.module('BugLog.controllers', [])

    .controller('HomeController',
    function ($scope, BugType, Vote, $interpolate) {

        $scope.alerts = []

        $scope.bug_types = BugType.query()

        $scope.closeAlert = function (index) {
            $scope.alerts.splice(index, 1);
        }

        $scope.createVote = function (bug_type) {
            var vote = new Vote({bug_type_id: bug_type.id})
            vote.$save(function (data) {
                var index = $scope.bug_types.indexOf(bug_type)
                $scope.bug_types[index].vote_count++
                $scope.bug_types[index].vote_id_by_current_user = data.data.id
            })
        };
        $scope.destroyVote = function (vote_id, bug_type) {
            Vote.delete({id: vote_id}, function () {
                var index = $scope.bug_types.indexOf(bug_type)
                $scope.bug_types[index].vote_id_by_current_user = null
                $scope.bug_types[index].vote_count--
            })
        };


        $scope.resetBugType = function (changed_bug_type) {
            var bug_type = BugType.get({ id: changed_bug_type.id }, function () {
                var index = $scope.bug_types.indexOf(changed_bug_type)
                console.log(bug_type)
                $scope.bug_types[index] = bug_type
            });
        }

        $scope.createBugType = function (bug_type) {
            var bug_type = new BugType(bug_type)
            bug_type.$save(function () {
                bug_type.owned_by_current_user = true
                $scope.bug_types.push(bug_type)
                $scope.alerts.push({type: "success", msg: $interpolate('Saved bug type {{ name }}.')(bug_type)})
            })
        }

        $scope.updateBugType = function (bug_type) {
            BugType.update({ id: bug_type.id }, bug_type, function () {
                $scope.alerts.push({type: "success", msg: $interpolate('Saved bug type {{ name }}.')(bug_type) });
            })
        }

        $scope.destroyBugType = function (bug_type) {
            confirmText = $interpolate("Are you sure you want to remove {{name}}?")(bug_type)
            if (confirm(confirmText)) {
                BugType.delete({id: bug_type.id}, function () {
                    var index = $scope.bug_types.indexOf(bug_type);
                    $scope.bug_types.splice(index, 1)
                    $scope.alerts.push({type: "success", msg: $interpolate('Deleted bug type {{ name }}.')(bug_type)})
                })
            }
        }
    })