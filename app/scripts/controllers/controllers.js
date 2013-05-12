'use strict';

angular.module('cfpReviewApp')
  .controller('MainCtrlJS', ['$scope', 'TalksService', function ($scope, TalksService) {
    $scope.talks = TalksService.talks();
  }]);
