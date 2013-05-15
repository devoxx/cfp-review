angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationsService', '$routeParams', ($scope, PresentationsService, $routeParams) ->

    $scope.presentation = PresentationsService.get({presentationId: $routeParams.presentationId, eventId: 8});

    $scope.typeDisplay = (type) -> type.name?.toUpperCase().substr(0, 1)

  ];
