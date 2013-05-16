angular.module('cfpReviewApp').controller 'AuthenticationCtrl',
  ['$scope', 'AuthenticationService', '$rootScope', ($scope, AuthenticationService, $rootScope) ->
    $scope.login = ->
      $rootScope.user = AuthenticationService.login $scope.emailOrUsername, $scope.password

  ];
