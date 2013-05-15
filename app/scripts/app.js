'use strict';

angular.module('cfpReviewApp', ['Services', 'ui.bootstrap'])
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
  });
