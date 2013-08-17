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
    .factory('CommentService', ['$resource', 'ConfigAPI', 'UserService', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + 'review/event/:eventId/presentation/:presentationId/comment', {userToken: UserService.getToken()});
    }])
    .factory('FeedbackService', ['$resource', 'ConfigAPI', 'UserService', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + 'review/event/:eventId/presentation/:presentationId/feedback', {userToken: UserService.getToken()});
    }])
    .factory('KeepEventService', ['$routeParams', function ($routeParams) {
        var svc = {};
        var events = [];

        svc.keepEvents = function (evts){
            events = evts;
        };

        svc.getEvents = function (){
            return events;
        };

        var eventFromParams = function (e){
            return ('' + e.id) === ('' + $routeParams.eventId);
        };

        // search event from url param eventId, if not found use the first
        svc.initEvent = function (){
            return events.filter(eventFromParams)[0] || events[0];
        };

        return svc;
    }])
    .factory('MousetrapService',function () {
        /* jshint -W117 */
        return Mousetrap;
    })
    .factory('UserAndEventsResolverService', ['EventService', 'UserService', 'KeepEventService', '$q', '$rootScope', function (EventService, UserService, KeepEventService, $q) {
        var defer = $q.defer();
        UserService.waitForCurrentUser().then(function () {
            EventService.getEvents().then(function (events) {
                KeepEventService.keepEvents(events);
                defer.resolve();
            });
        });
        return defer.promise;
    }]);
