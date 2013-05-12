'use strict';

angular.module('cfpReviewApp', ['Services', 'ui.bootstrap'])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/mainUsingJS', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrlJS'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
