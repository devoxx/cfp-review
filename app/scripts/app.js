'use strict';

angular.module('cfpReviewApp', ['GenericServices', 'Services', 'ui.bootstrap', 'ngCookies'])
    .config(function ($routeProvider) {

        var resolver = {
            userAndEvents: function(EventService, UserService, $q, $rootScope) {
                var defer = $q.defer();
                UserService.waitForCurrentUser().then(function(){
                    EventService.getEvents().then(function(events){
                        $rootScope.events = events;
                        $rootScope.defaultEvent = events[0];
                        defer.resolve();
                    });
                });
                return defer.promise;
            }
        };

        $routeProvider.when('/', {
            templateUrl: 'views/main.html',
            controller: 'MainCtrl',
            resolve: resolver
        }).when('/presentation/:presentationId', {
            templateUrl: 'views/presentation.html',
            controller: 'PresentationCtrl',
            resolve: resolver
        }).otherwise({
            redirectTo: '/'
        });
    }).run([ 'UserService', 'EventService', '$rootScope', '$cookies', function (UserService, EventService, $rootScope, $cookies) {
        var userToken = $cookies.userToken;
        if (userToken && userToken.length > 0) {
            UserService.loginByToken(userToken);
        }
    }]);
