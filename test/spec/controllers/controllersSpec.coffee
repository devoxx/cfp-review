describe 'Controller: MainCtrl', ->
  beforeEach module 'cfpReviewApp'

  MainCtrl= {}
  scope= {}
  TalksService= {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    TalksService = {talks: jasmine.createSpy('TalksService.talks')}
    TalksService.talks.andReturn(["a talk", "another one"])

    MainCtrl = $controller('MainCtrl', {
      $scope: scope,
      TalksService: TalksService
    });

  it 'should attach a list of talks to the scope', ->
    expect(scope.talks).toBeDefined()
    expect(scope.talks.length).toBeGreaterThan(1)


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
