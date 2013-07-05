describe 'Controller: PresentationCtrl', ->
  beforeEach module 'cfpReviewApp'
  beforeEach ->
    this.addMatchers {
      toEqualData: (expected) ->
        angular.equals this.actual, expected
    }

  PresentationCtrl= {}
  scope= {}
  PresentationService= {}
  presentation = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    scope.defaultEvent =
      id: 8
    PresentationService = {get: jasmine.createSpy('PresentationService.get')}
    presentation = {ratings: [{percentage: 2},{percentage: 4}]}
    PresentationService.get.andReturn(presentation)

    PresentationCtrl = $controller('PresentationCtrl', {
      $scope: scope,
      PresentationService: PresentationService,
      $routeParams: {presentationId: 123}
    });

  it 'should attach a presentation to the scope', ->
    expect(scope.presentation).toBeDefined()
    expect(PresentationService.get).toHaveBeenCalled()
    expect(scope.presentation).toEqualData(presentation)
