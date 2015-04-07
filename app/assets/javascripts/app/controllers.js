angular.module('BugLog.controllers', [])

    .controller('HomeController',
    function ($scope, BugType, UserService, Vote, $modal, $interpolate) {

        $scope.addAlert = function(type, message){
            $scope.alerts = []
            $scope.alerts.push({type: type, msg: message })
        }

        UserService.getCurrentUser().then(function(res){
            $scope.currentUser = res.data;
        });

        $scope.alerts = []

        $scope.bug_types = BugType.query()

        $scope.closeAlert = function (index) {
            $scope.alerts.splice(index, 1);
        }

        $scope.createVote = function (bug_type) {
            if(!assureSignedIn()) return
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

        $scope.resetBugType = function (edited_bug_type) {
            edited_bug_type.editMode = false
            if(edited_bug_type.isPersisted()) {
                var bug_type = BugType.get({ id: edited_bug_type.id }, function () {
                    var index = $scope.bug_types.indexOf(edited_bug_type)
                    $scope.bug_types[index] = bug_type
                });
            }
            else {
                var index = $scope.bug_types.indexOf(edited_bug_type);
                $scope.bug_types.splice(index, 1)
            }
        }

        $scope.newBugType = function () {
            if(!assureSignedIn()) return
            var bug_type = new BugType()
            bug_type.editMode = true
            $scope.bug_types.unshift(bug_type)
        }

        $scope.createOrUpdateBugType = function (edited_bug_type) {
             var onSuccess = function(refreshed_bug_type){
                $scope.addAlert("success", $interpolate('Saved bug type {{ name }}.')(refreshed_bug_type))
                refreshed_bug_type.editMode = false
                var index = $scope.bug_types.indexOf(edited_bug_type);
                $scope.bug_types[index] = refreshed_bug_type
             }
            if(edited_bug_type.isPersisted()) {
                $scope.updateBugType(edited_bug_type, onSuccess)
            }
            else {
                $scope.createBugType(edited_bug_type, onSuccess)
            }
        }

        $scope.createBugType = function (bug_type, onSuccess) {
            bug_type.$save(function () {
                bug_type.owned_by_current_user = true
                onSuccess(bug_type)
            })
        }

        $scope.updateBugType = function (bug_type, onSuccess) {
            BugType.update({ id: bug_type.id }, bug_type, function () {
                onSuccess(bug_type)
            })
        }

        $scope.destroyBugType = function (bug_type) {
            confirmText = $interpolate("Are you sure you want to remove {{name}}?")(bug_type)
            if (confirm(confirmText)) {
                BugType.delete({id: bug_type.id}, function () {
                    var index = $scope.bug_types.indexOf(bug_type);
                    $scope.bug_types.splice(index, 1)
                    $scope.addAlert("success", $interpolate('Deleted bug type {{ name }}.')(bug_type))
                })
            }
        }
        $scope.openSignInModal = function (size) {
            var modalInstance = $modal.open({
                templateUrl: 'myModalContent.html',
                controller: 'ModalController',
                size: size,
                resolve: {
                }
            })

            modalInstance.result.then(function () {
            }, function () {
            })
        };

        function assureSignedIn(){
            if(!$scope.currentUser) {
                $scope.openSignInModal('sm')
                return false
            }
            else {
                return true
            }
        }
    })

.controller('ModalController', function ($scope, $modalInstance) {

    $scope.ok = function () {
        $modalInstance.close();
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});
