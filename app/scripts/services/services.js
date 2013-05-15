'use strict';

angular.module('Services', ['ngResource', 'Config'])
  .factory('PresentationsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentations/:presentationId',
      {presentationId: '@id', index: 0, size: 10, userToken: '8a3e49943ea18167013ea52cb1503d1a'},
      { 'get':    {method:'GET'},
        'save':   {method:'POST'},
        'query':  {method:'GET'},
        'remove': {method:'DELETE'},
        'delete': {method:'DELETE'} });
  }])
  .factory('EventsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/proposal/event/:eventId', {eventId: '@id'});
  }]);
