'use strict';

describe('Controller: MainCtrlJS', function () {

  // load the controller's module
  beforeEach(module('cfpReviewApp'));

  var MainCtrlJS,
    scope,
    TalksService;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();

    TalksService = {talks: jasmine.createSpy('TalksService.talks')};
    TalksService.talks.andReturn(["a talk", "another one"]);

    MainCtrlJS = $controller('MainCtrlJS', {
      $scope: scope,
      TalksService: TalksService
    });
  }));

  it('should attach a list of talks to the scope', function () {
    expect(scope.talks).toBeDefined();
    expect(scope.talks.length).toBeGreaterThan(1);
  });
});
