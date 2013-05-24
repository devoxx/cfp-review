'use strict';

angular.module('Services', ['ngResource', 'Config'])
  .factory('PresentationsService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentations/:presentationId',
      {index: 0, size: 10, userToken: '8a70969c3ea59931013eaf19e55a7dab', eventId: 8},
      { 'query': {method: 'GET'}});
  }])
  .factory('PresentationService', ['$resource', 'ConfigAPI', function ($resource, ConfigAPI) {
    return $resource(ConfigAPI.endPoint + '/review/event/:eventId/presentation/:presentationId',
      {index: 0, size: 10, userToken: '8a70969c3ea59931013eaf19e55a7dab', eventId: 8},
      { 'get': {method: 'GET'}});
  }]);
