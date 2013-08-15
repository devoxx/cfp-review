angular.module('cfpReviewApp').controller 'AuthenticationCtrl',
  ['$scope', 'UserService', 'EventBus', '$cookies', '$location',
    ($scope, UserService, EventBus, $cookies, $location) ->
      $scope.login = ->
        UserService.login $scope.emailOrUsername, $scope.password

      UserService.waitForCurrentUser().then((data) ->
        $scope.user = data)

      $scope.logout = ->
        UserService.logout
        $scope.user = null

      EventBus.onLoginSuccess($scope, (user, userToken) ->
        $scope.user = user
        $cookies.userToken = userToken
        $scope.loginError = null
      )

      EventBus.onLoginFailed($scope, (reason) ->
        $scope.loginDisabled = false
        $scope.loginError = reason
      )

      EventBus.onLoggedOut($scope, ->
        $cookies.userToken = ''
        $scope.user = null
        $scope.loginDisabled = false
        $location.path('/')
      )

  ]
