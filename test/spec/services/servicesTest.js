'use strict';

describe('Service: Services', function () {

  beforeEach(module('cfpReviewApp'));

  beforeEach(function () {
    this.addMatchers({
      toEqualData: function (expected) {
        return angular.equals(this.actual, expected);
      }
    });
  });

  var PresentationsService,
    EventsService,
    ConfigAPI,
    expected = {results: [
      {
        "expectedData": 123
      }
    ]
    },
    expectedEvent = [
      {
        "expectedData": 123
      }
    ];

  beforeEach(inject(function (_PresentationsService_, _EventsService_, _ConfigAPI_) {
    PresentationsService = _PresentationsService_;
    EventsService = _EventsService_;
    ConfigAPI = _ConfigAPI_
  }));

  it('should get a presentation list', inject(function ($httpBackend) {

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/review/event/presentations")).
      respond(expected);

    var actual = PresentationsService.query();

    $httpBackend.flush();

    expect(actual).toBeDefined();
    expect(actual).toEqualData(expected);
  }));

  it('should get a presentation list for event X', inject(function ($httpBackend) {

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/review/event/X/presentations")).
      respond(expected);

    var actual = PresentationsService.query({eventId: 'X'});

    $httpBackend.flush();

    expect(actual).toBeDefined();
    expect(actual).toEqualData(expected);
  }));

  it('should get an event list', inject(function ($httpBackend) {

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/proposal/event")).
      respond(expectedEvent);

    var actual = EventsService.query();

    $httpBackend.flush();

    expect(actual).toBeDefined();
    expect(actual).toEqualData(expectedEvent);
  }));

});
