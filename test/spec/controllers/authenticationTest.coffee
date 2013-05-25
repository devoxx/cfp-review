describe 'Controller: AuthenticationCtrl', ->
  beforeEach module 'cfpReviewApp'
  beforeEach ->
    this.addMatchers {
      toEqualData: (expected) ->
        angular.equals this.actual, expected
    }

  AuthenticationCtrl = {}
  scope = {}
  UserService = {}
  user = {}
  waitForCurrentUserThen = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    UserService = {login: jasmine.createSpy('UserService.login'), waitForCurrentUser: jasmine.createSpy('UserService.waitForCurrentUser')}
    user = {firstname: 'Vlad'}
    waitForCurrentUserThen =
      then: ->
        true
    UserService.login.andReturn(user)
    UserService.waitForCurrentUser.andReturn(waitForCurrentUserThen)

    AuthenticationCtrl = $controller('AuthenticationCtrl', {
      $scope: scope,
      UserService: UserService
    });

  it 'should call UserService.login', ->
    expect(scope.user).toBeUndefined()
    scope.emailOrUsername = 'vlad'
    scope.password = 'imir'
    scope.login()
    expect(UserService.login).toHaveBeenCalledWith('vlad', 'imir')