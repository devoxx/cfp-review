'use strict';

angular.module('Services', ['GenericServices', 'ngResource', 'Config'])
    .factory('PresentationsService', ['$resource', 'ConfigAPI', 'UserService', '$log', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentation/:presentationId', {index: 0, size: 10, userToken: UserService.getToken()}, { 'query': {method: 'GET'}});
    }])
    .factory('PresentationService', ['$resource', 'ConfigAPI', 'UserService', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentation/:presentationId', {index: 0, size: 10, userToken: UserService.getToken()}, { 'get': {method: 'GET'}});
    }])
    .factory('EventsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
        return $resource(ConfigAPI.endPoint + '/proposal/event/:eventId');
    }])
    .factory('RatingService', ['$resource', 'ConfigAPI', 'UserService', function ($resource, ConfigAPI, UserService) {
        return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentation/:presentationId/rating', {userToken: UserService.getToken()});
    }]);
