'use strict';

angular.module('Services', ['GenericServices', 'ngResource', 'Config']).factory('PresentationService', ['$resource', 'ConfigAPI', 'UserService', '$log', function ($resource, ConfigAPI, UserService) {
        return $resource(baseUri + 'review/event/:eventId/presentation/:presentationId', {index: 0, size: 10, userToken: UserService.getToken()}, {
            'get': {method: 'GET'},
            'query': {method: 'GET'}
        });
    }]).factory('EventsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
        return $resource(baseUri + 'proposal/event/:eventId');
    }]).factory('RatingService', ['$resource', 'ConfigAPI', 'UserService', function ($resource, ConfigAPI, UserService) {
        return $resource(baseUri + 'review/event/:eventId/presentation/:presentationId/rating', {userToken: UserService.getToken()});
    }]).factory('MousetrapService',function () {
        /* jshint -W117 */
        return Mousetrap;
    }).factory('ResolverService', ['EventService', 'UserService', '$q', '$rootScope', function (EventService, UserService, $q, $rootScope) {
        var defer = $q.defer();
        UserService.waitForCurrentUser().then(function () {
            EventService.getEvents().then(function (events) {
                $rootScope.events = events;
                $rootScope.defaultEvent = events[0];
                defer.resolve();
            });
        });
        return defer.promise;
    }]);
