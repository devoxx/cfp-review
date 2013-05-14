'use strict';

describe('Service: Services (JS version)', function () {

  beforeEach(module('cfpReviewApp'));

  var PresentationsService,
    presentation = {
      "id": 1480
    };

  beforeEach(inject(function (_PresentationsService_, $httpBackend) {
    PresentationsService = _PresentationsService_;

    $httpBackend.expectGET(new RegExp("payload/presentation.json")).
      respond([presentation]);
  }));

  it('should get a presentation list', inject(function ($httpBackend) {
    var actual = PresentationsService.query();

    $httpBackend.flush();

    expect(actual).toBeDefined();
    expect(actual.length).toEqual(1);
  }));

});
