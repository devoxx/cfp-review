'use strict';

angular
    .module('Services', ['GenericServices', 'ngResource', 'Config'])
    .factory('PresentationService', ['$resource', 'ConfigAPI', 'UserService', '$log', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + 'review/event/:eventId/presentation/:presentationId', {index: 0, size: 10, userToken: UserService.getToken()});
    }])
    .factory('PresentationQueryService', ['$resource', 'ConfigAPI', 'UserService', '$log', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + 'review/presentation/:presentationId', {index: 0, size: 10, userToken: UserService.getToken()}, {
            'query': {method: 'POST'}
        });
    }])
    .factory('RatingService', ['$resource', 'ConfigAPI', 'UserService', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + 'review/event/:eventId/presentation/:presentationId/rating', {userToken: UserService.getToken()});
    }])
    .factory('MousetrapService',function () {
        /* jshint -W117 */
        return Mousetrap;
    })
    .factory('ResolverService', ['EventService', 'UserService', 'Presentation', '$q', '$rootScope', function (EventService, UserService, Presentation, $q, $rootScope) {
        var defer = $q.defer();
        UserService.waitForCurrentUser().then(function () {
            EventService.getEvents().then(function (events) {
                Presentation.keepEvents(events);
                defer.resolve();
            });
        });
        return defer.promise;
    }]);
