'use strict';

angular.module('cfpReviewApp')
  .controller('MainCtrl', function ($scope, TalksService) {
    $scope.data = {
      talks: TalksService.talks()
    };
  });
