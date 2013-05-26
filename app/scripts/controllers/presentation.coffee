angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', 'RatingService', '$routeParams', '$rootScope', ($scope, PresentationService, RatingService, $routeParams, $rootScope) ->

    $scope.presentation = PresentationService.get({presentationId: $routeParams.presentationId, eventId: $scope.defaultEvent.id})

    $scope.rateIt = (rate) ->
      RatingService.save({presentationId: $routeParams.presentationId, eventId: $scope.defaultEvent.id}, {percentage: rate})

  ]
