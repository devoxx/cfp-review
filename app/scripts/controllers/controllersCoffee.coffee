angular.module('cfpReviewApp').controller 'MainCtrl', ['$scope', 'TalksService', ($scope, TalksService) ->
  $scope.talks = TalksService.talks()

  $scope.stateClass = (state) ->
    switch state.toUpperCase()
      when 'DELETED' then 'label-inverse'
      when 'REJECTED' then 'label-important'
      when 'SUBMITTED' then 'label-info'
      when 'ONHOLD' then 'label'
      when 'BACKUP' then 'label'
      when 'APPROVED' then 'label-success'
      when 'ACCEPTED' then 'label-success'
      when 'DECLINED' then 'label-warning'
      else ''

  $scope.stateDisplay = (state) -> state.toUpperCase().substr(0, 3)

];
