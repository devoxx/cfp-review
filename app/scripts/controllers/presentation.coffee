angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', 'RatingService', '$routeParams', ($scope, PresentationService, RatingService, $routeParams) ->

    $scope.presentation = PresentationService.get({presentationId: $routeParams.presentationId, eventId: $scope.defaultEvent.id});

    $scope.rateIt = (rate) ->
      RatingService.save({presentationId: $routeParams.presentationId, eventId: $scope.defaultEvent.id}, {percentage: rate})

  ];
