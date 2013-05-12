angular.module('cfpReviewApp').controller 'MainCtrlCoffee', ['$scope', 'TalksService', ($scope, TalksService) ->
  $scope.talks = TalksService.talks()

];
