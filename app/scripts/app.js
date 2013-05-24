'use strict';

angular.module('cfpReviewApp', ['Services', 'Generic Services', 'ui.bootstrap', 'ngCookies'])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/:presentationId', {
        templateUrl: 'views/presentation.html',
        controller: 'PresentationCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  })
  .run(['UserService', 'EventService', function (UserService, EventService) {
    UserService.loginByToken();
    UserService.waitLoggedIn().then(function () {
      EventService.load();
    });
  }]).controller('LoginCtrl', function ($scope, UserService) {
    $scope.model = {};
    $scope.login = function () {
      UserService.login($scope.model.email, $scope.model.password);
    };
    $scope.currentUser = UserService.getCurrentUser;
    $scope.logout = UserService.logout;
  });

