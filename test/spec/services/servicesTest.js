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
    AuthenticationService,
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
    ],
    expectedUser = {firstname: 'Vlad'};

  beforeEach(inject(function (_PresentationsService_, _EventsService_, _ConfigAPI_, _PresentationService_, _AuthenticationService_) {
    PresentationsService = _PresentationsService_;
    PresentationService = _PresentationService_;
    EventsService = _EventsService_;
    AuthenticationService = _AuthenticationService_,
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

  it('should get a presentation for event X', inject(function ($httpBackend) {

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/review/event/8/presentation/123")).
      respond(expected);

    var actual = PresentationService.get({ presentationId : 123, eventId : 8 });

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


  it('should get an user on login', inject(function ($httpBackend) {

    $httpBackend.expectPOST(new RegExp(ConfigAPI.endPoint + "/auth/login")).
      respond(expectedUser);

    var actual = AuthenticationService.login('vlad', 'imir').then(function (user) {
      actual = user;
    });

    $httpBackend.flush();

    expect(actual).toBeDefined();
    expect(actual).toEqualData(expectedUser);
  }));
});
