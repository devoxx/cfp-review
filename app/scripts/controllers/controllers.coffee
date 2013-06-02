angular.module('cfpReviewApp').controller 'MainCtrl',
  ['$scope', 'PresentationService', '$rootScope', 'UserService', '$routeParams', '$log', '$http', ($scope, PresentationService, $rootScope, UserService, $routeParams, $log, $http) ->

    $scope.eventId = $routeParams.eventId ? $scope.defaultEvent.id

    $scope.model =
      presentations: []
    $scope.busy = false
    $scope.index = 0

    $scope.addPresentations = (prezos) ->
      $scope.model.count = prezos.count
      $scope.enrichPresentations(prezos)
      for i in [0..prezos.results.length-1]
        $scope.model.presentations.push(prezos.results[i])
        $scope.busy = false

    $scope.nextPage = ->
      return if $scope.busy
      $scope.busy = true
      PresentationService.query({eventId: $scope.eventId, index: $scope.index++}, $scope.addPresentations)

    $scope.nextPage()

    # calculate average rating of a presentation
    $scope.averageRating = (prez) ->
      return '?' if not prez.ratings? or prez.ratings.length == 0
      sum = prez.ratings.reduce (x, y) ->
        sum =
          percentage: x.percentage + y.percentage
      sum.percentage / prez.ratings.length

    # set presentation.rating property with calculated average rating
    $scope.updateRating = (prez) ->
      prez.rating = $scope.averageRating prez

    # for each presensation in list calculate average rating
    $scope.enrichPresentations = (presentations) ->
      $scope.updateRating prez for prez in presentations.results

    $scope.stateClass = (state) ->
      switch state.toUpperCase()
        when 'DELETED' then 'label-inverse'
        when 'REJECTED' then 'label-important'
        when 'SUBMITTED' then 'label-info'
        when 'ONHOLD' then 'label'
        when 'BACKUP' then 'label'
        when 'APPROVED' then 'label-success'
        when 'ACCEPTED' then 'label-success'
        when 'DECLINED' then 'label-warning'
        else
          ''

    $scope.ratingClass = (rating) ->
      switch
        when 4 <= rating <= 5 then 'label-success'
        when 2 <= rating < 4 then 'label-warning'
        when 0 <= rating < 2 then 'label-important'
        else
          ''

    $scope.stateDisplay = (state) -> state?.toUpperCase().substr(0, 3)

    $scope.typeDisplay = (type) -> type.name?.toUpperCase().substr(0, 1)

  ]
