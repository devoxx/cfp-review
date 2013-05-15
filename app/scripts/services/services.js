'use strict';

angular.module('Services', ['ngResource', 'Config'])
  .factory('PresentationsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentations/:presentationId',
      {index: 0, size: 10, userToken: '8a3e49943ea18167013ea52cb1503d1a'},
      { 'query':  {method:'GET'}});
  }])
  .factory('PresentationService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentation/:presentationId',
      {index: 0, size: 10, userToken: '8a3e49943ea18167013ea52cb1503d1a'},
      { 'get':    {method:'GET'}});
  }])
  .factory('EventsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/proposal/event/:eventId', {eventId: '@id'});
  }]);
