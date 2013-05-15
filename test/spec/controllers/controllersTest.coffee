describe 'Controller: MainCtrl', ->
  beforeEach module 'cfpReviewApp'
  beforeEach ->
    this.addMatchers {
      toEqualData: (expected) ->
        angular.equals this.actual, expected
    }

  MainCtrl= {}
  scope= {}
  PresentationsService= {}
  EventsService= {}
  presentation = {}
  event = {}
  presentations = []
  events = []

  beforeEach inject ($controller, $rootScope, $httpBackend, ConfigAPI) ->
    scope = $rootScope.$new()
    PresentationsService = {query: jasmine.createSpy('PresentationsService.query')}
    presentation = {ratings: [{percentage: 2},{percentage: 4}]}
    presentations = {results: [presentation]}
    PresentationsService.query.andReturn(presentations)

    EventsService = {query: jasmine.createSpy('EventsService.query')}
    event = {name: "Sample"}
    events = [event]
    EventsService.query.andReturn(events)

    $httpBackend.expectGET(new RegExp(ConfigAPI.endPoint + "/proposal/event")).respond(events)

    MainCtrl = $controller('MainCtrl', {
      $scope: scope,
      PresentationsService: PresentationsService
    });

    $httpBackend.flush()

  it 'should calculate average rating on a presentation', ->
    actual = scope.averageRating presentation
    expect(actual).toBeDefined()
    expect(actual).toEqual 3

  it 'should calculate average rating with result "?" if presentation ratings are undefined', ->
    actual = scope.averageRating {}
    expect(actual).toBeDefined()
    expect(actual).toEqual '?'

  it 'should update rating', ->
    scope.updateRating presentation
    expect(presentation.rating).toEqual 3

  it 'should not update rating if presentation ratings are undefined', ->
    prez = {}
    scope.updateRating prez
    expect(prez.rating).toEqual '?'

  it 'should enrich presentation', ->
    scope.enrichPresentations presentations
    expect(presentation.rating).toEqual 3

  it 'should attach a list of talks to the scope', ->
    expect(scope.presentations).toBeDefined()
    expect(PresentationsService.query).toHaveBeenCalledWith(scope.enrichPresentations)
    expect(scope.presentations.results.length).toEqual(1)
    expect(scope.presentations.results).toEqualData([presentation])

  it 'should return state class to use depending of state value', ->
    expect(scope.stateClass('Deleted')).toEqual('label-inverse')
    expect(scope.stateClass('Rejected')).toEqual('label-important')
    expect(scope.stateClass('Submitted')).toEqual('label-info')
    expect(scope.stateClass('Onhold')).toEqual('label')
    expect(scope.stateClass('Backup')).toEqual('label')
    expect(scope.stateClass('Approved')).toEqual('label-success')
    expect(scope.stateClass('Accepted')).toEqual('label-success')
    expect(scope.stateClass('Declined')).toEqual('label-warning')
    expect(scope.stateClass('anything else')).toEqual('')

  it 'should return first 3 letter upper cased', ->
    expect(scope.stateDisplay('Deleted')).toEqual('DEL')

  it 'should return undefined if state is undefined', ->
    expect(scope.stateDisplay(undefined)).toBeUndefined()

  it 'should return rating class to use depending of rating value', ->
    expect(scope.ratingClass(5)).toEqual('label-success')
    expect(scope.ratingClass(3)).toEqual('label-warning')
    expect(scope.ratingClass(1)).toEqual('label-important')
    expect(scope.ratingClass('bad input')).toEqual('')

  it 'should return first letter upper cased', ->
    expect(scope.typeDisplay({name: 'Conference'})).toEqual('C')

  it 'should return undefined if type.name is undefined', ->
    expect(scope.typeDisplay({})).toBeUndefined()