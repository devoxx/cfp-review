angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', '$routeParams', ($scope, PresentationService, $routeParams) ->

    $scope.presentation = PresentationService.get({presentationId: $routeParams.presentationId, eventId: 8});

  ];
