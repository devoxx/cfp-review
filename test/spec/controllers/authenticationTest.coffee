describe 'Controller: AuthenticationCtrl', ->
  beforeEach module 'cfpReviewApp'
  beforeEach ->
    this.addMatchers {
      toEqualData: (expected) ->
        angular.equals this.actual, expected
    }

  AuthenticationCtrl= {}
  scope= {}
  AuthenticationService= {}
  user = {}
  rootScope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    rootScope = $rootScope
    AuthenticationService = {login: jasmine.createSpy('AuthenticationService.login')}
    user = {firstname: 'Vlad'}
    AuthenticationService.login.andReturn(user)

    AuthenticationCtrl = $controller('AuthenticationCtrl', {
      $scope: scope,
      AuthenticationService: AuthenticationService,
      $rootScope: rootScope
    });

  it 'should attach a user to the scope on login', ->
    expect(scope.user).toBeUndefined()
    scope.emailOrUsername = 'vlad'
    scope.password = 'imir'
    scope.login()
    expect(AuthenticationService.login).toHaveBeenCalledWith('vlad', 'imir')
    expect(rootScope.user).toEqualData(user)
