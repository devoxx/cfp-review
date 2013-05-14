'use strict';

angular.module('cfpReviewApp')
  .controller('MainCtrlJS', ['$scope', 'PresentationsService', function ($scope, PresentationsService) {
    $scope.presentations = PresentationsService.query();

  }]);
