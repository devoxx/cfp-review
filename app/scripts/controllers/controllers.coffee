angular.module('cfpReviewApp').controller 'MainCtrl',
  ['$scope', 'PresentationQueryService', 'Presentation', '$rootScope', 'UserService', '$routeParams', '$log', '$http', ($scope, PresentationQueryService, Presentation, $rootScope, UserService, $routeParams, $log, $http) ->

    $scope.query =
      eventId: $routeParams.eventId ? $scope.defaultEvent.id
      type: null
      track: null
      states: null
      alreadyRated: null
      favouritesOnly: null
      invitesOnly: null
      alreadyScheduled: null
      myCommentWasLast: null
      tags: null
      query: null

    $scope.model =
      presentations: []
    $scope.busy = false
    $scope.index = 0

    $scope.types = [
      {id:null, name:'' },
      {id:1, name:'Conference' },
      {id:2, name:'University' },
      {id:3, name:'Tools in Action' },
      {id:4, name:'Hands-on Labs' },
      {id:5, name:'BOF' },
      {id:6, name:'Quickie' }
    ]

    $scope.tracks = [
      {id:null, name:'' },
      {id:1, name:'Web' },
      {id:2, name:'NoSQL' }
    ]

    $scope.addPresentations = (prezos) ->
      $scope.model.count = prezos.count
      $scope.enrichPresentations(prezos)
      for i in [0..prezos.results.length-1]
        $scope.model.presentations.push(prezos.results[i])
        $scope.busy = false

    $scope.refresh = ->
      return if $scope.busy
      $scope.busy = true
      PresentationQueryService.query({index: $scope.index}, $scope.query, $scope.addPresentations)

    $scope.nextPage = ->
      $scope.index++
      $scope.refresh()

    $scope.nextPage()

    $scope.$watch('query', $scope.refresh, true)

    $scope.trim = (e)->
      e.trim()

    $scope.refreshTags = ->
      return if !$scope.tags
      $scope.query.tags = $scope.tags.split(',').map($scope.trim)

    $scope.$watch('tags', $scope.refreshTags)

    # set presentation.rating property with calculated average rating
    $scope.updateRating = (prez) ->
      prez.rating = Presentation.averageRating(prez)

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
