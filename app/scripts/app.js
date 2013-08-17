'use strict';

angular.module('cfpReviewApp', ['GenericServices', 'Services', 'ui.bootstrap', 'ngCookies', 'infinite-scroll'])
    .config(function ($routeProvider) {

        var resolver = {
            userAndEvents: 'UserAndEventsResolverService'
        };

        $routeProvider.when('/', {
            templateUrl: 'views/main.html',
            controller: 'MainCtrl',
            resolve: resolver,
            reloadOnSearch: false
        }).when('/event/:eventId/presentation/:presentationId', {
            templateUrl: 'views/presentation.html',
            controller: 'PresentationCtrl',
            resolve: resolver
        }).otherwise({
            redirectTo: '/'
        });
    }).run(['UserService', '$cookies', function (UserService, $cookies) {
        var userToken = $cookies.userToken;
        if (userToken && userToken.length > 0) {
            UserService.loginByToken(userToken);
        }
    }]);
