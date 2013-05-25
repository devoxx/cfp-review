'use strict';

angular.module('cfpReviewApp', ['GenericServices', 'Services', 'ui.bootstrap', 'ngCookies']).config(function ($routeProvider) {
        $routeProvider.when('/', {
                templateUrl: 'views/main.html',
                controller: 'MainCtrl'
            }).when('/presentation/:presentationId', {
                templateUrl: 'views/presentation.html',
                controller: 'PresentationCtrl'
            }).otherwise({
                redirectTo: '/'
            });
    }).run([ 'UserService', 'EventService', '$rootScope', '$cookies', 'EventBus', function (UserService, EventService, $rootScope, $cookies, EventBus) {
        var userToken = $cookies.userToken;
        if (userToken && userToken.length > 0) {
            EventBus.onLoginSuccess($rootScope, function () {
                EventService.load().then(function () {
                    $rootScope.events = EventService.getEvents();
                    $rootScope.defaultEvent = $rootScope.events[0];
                    $rootScope.$broadcast('APP_LOADED');
                });
            });

            UserService.loginByToken(userToken);
        }
    }]);
