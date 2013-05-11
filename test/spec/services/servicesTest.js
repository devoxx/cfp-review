'use strict';

describe('Service: Services', function () {

  // load the service's module
  beforeEach(module('cfpReviewApp'));

  // instantiate service
  var TalksService;
  beforeEach(inject(function (_TalksService_) {
    TalksService = _TalksService_;
  }));

  it('should get a talk list ', function () {
    var actual = TalksService.talks();
    expect(actual).toBeDefined();
    expect(actual.length).toEqual(40);
  });

});
