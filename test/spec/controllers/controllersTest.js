'use strict';

describe('Controller: MainCtrlJS', function () {

  beforeEach(module('cfpReviewApp'));

  var MainCtrlJS,
    scope,
    PresentationsService;

  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();

    PresentationsService = {query: jasmine.createSpy('PresentationsService.query')};
    PresentationsService.query.andReturn(["a presentation", "another one"]);

    MainCtrlJS = $controller('MainCtrlJS', {
      $scope: scope,
      PresentationsService: PresentationsService
    });

  }));

  it('should attach a list of presentations to the scope', function () {
    expect(scope.presentations).toBeDefined();
    expect(scope.presentations.length).toBeGreaterThan(1);
  });

});
