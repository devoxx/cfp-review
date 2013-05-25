angular.module('cfpReviewApp').controller 'AuthenticationCtrl',
  ['$scope', 'UserService', ($scope, UserService) ->
    $scope.login = ->
      UserService.login $scope.emailOrUsername, $scope.password

    UserService.waitForCurrentUser().then((data) ->
      $scope.user = data)

    $scope.logout = ->
      UserService.logout
      $scope.user = null

  ];
