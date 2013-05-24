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
    PresentationService,
    EventService,
    ConfigAPI,
    expected = {results: [
      {
        "expectedData": 123
      }
    ]
    };

  beforeEach(inject(function (_PresentationsService_, _EventService_, _ConfigAPI_, _PresentationService_) {
    PresentationsService = _PresentationsService_;
    PresentationService = _PresentationService_;
    EventService = _EventService_;
    ConfigAPI = _ConfigAPI_
  }));

  it('should get a presentation list', inject(function ($httpBackend) {

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/review/event/8/presentations")).
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

  it('should get a presentation for event X', inject(function ($httpBackend) {

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/review/event/8/presentation/123")).
      respond(expected);

    var actual = PresentationService.get({ presentationId : 123, eventId : 8 });

    $httpBackend.flush();

    expect(actual).toBeDefined();
    expect(actual).toEqualData(expected);
  }));

});
