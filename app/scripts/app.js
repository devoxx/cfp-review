'use strict';

angular.module('cfpReviewApp', ['Services', 'ui.bootstrap'])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrlJS'
      })
      .when('/coffee', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrlCoffee'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
