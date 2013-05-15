describe 'Controller: MainCtrl', ->
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

  beforeEach inject ($controller, $rootScope, $httpBackend, ConfigAPI) ->
    scope = $rootScope.$new()
    PresentationService = {get: jasmine.createSpy('PresentationService.get')}
    presentation = {ratings: [{percentage: 2},{percentage: 4}]}
    PresentationService.get.andReturn(presentation)

    PresentationCtrl = $controller('PresentationCtrl', {
      $scope: scope,
      PresentationsService: PresentationService,
      $routeParams: {presentationId: 123}
    });

  it 'should attach a presentation to the scope', ->
    expect(scope.presentation).toBeDefined()
    expect(PresentationService.get).toHaveBeenCalledWith({ presentationId : 123, eventId : 8 })
    expect(scope.presentation).toEqualData(presentation)
