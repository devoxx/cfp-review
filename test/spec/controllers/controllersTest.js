'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('cfpReviewApp'));

  var MainCtrl,
    scope,
    TalksService;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();

    TalksService = {talks: jasmine.createSpy('TalksService.talks')};
    TalksService.talks.andReturn(["a talk", "another one"]);

    MainCtrl = $controller('MainCtrl', {
      $scope: scope,
      TalksService: TalksService
    });
  }));

  it('should attach a list of talks to the scope', function () {
    expect(scope.data).toBeDefined();
    expect(scope.data.talks).toBeDefined();
    expect(scope.data.talks.length).toBeGreaterThan(1);
  });
});
