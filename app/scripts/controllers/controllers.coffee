angular.module('cfpReviewApp').controller 'MainCtrl',
  ['$scope', 'PresentationQueryService', 'Presentation', '$timeout', ($scope, PresentationQueryService, Presentation, $timeout) ->
# sample payload to search prezos
#    {
#      "eventId": 9,
#      "type": {"id": 1}, //nullable
#      "track": {"id": 1}, //nullable
#      "states": ["DELETED"], //nullable, A set consisting of following elements: DELETED, REJECTED, SUBMITTED, ONHOLD, BACKUP, APPROVED, ACCEPTED, DECLINED
#      "alreadyRated": true, //nullable, aplies to the logged in user (return all if null, return only rated by him/her, return only non-rated by him/her)
#      "favouritesOnly": true, //nullable, return all, favourites, non-favourites
#      "invitesOnly": true, //nullable, same logic as above
#      "alreadyScheduled": true, //nullable, same logic as above
#      "myCommentWasLast": true, //nullable, aplies to the logged in user (return all  if null, only those on which the last comment is his/hers, only those on which the last comment is not his/hers and he/she commented on it anyway)
#      "tags": ["tag1", "tag2"], //nullable, A set of strings, freeform
#      "query": "searchstring" //nullable, freeform string, used to look if presentation title, description, author name, lastname or company contains the given string
#    }

    $scope.states = [
      {id: 'DELETED', value: false},
      {id: 'REJECTED', value: true},
      {id: 'SUBMITTED', value: true},
      {id: 'ONHOLD', value: true},
      {id: 'BACKUP', value: true},
      {id: 'APPROVED', value: true},
      {id: 'ACCEPTED', value: true},
      {id: 'DECLINED', value: true}
    ]

    ctrl = {}

    ctrl.addStateIfSelected = (memo, s)->
      memo.push(s.id) if s.value
      memo

    ctrl.refreshStates = ->
     $scope.query.states = $scope.states.reduce(ctrl.addStateIfSelected, [])

    $scope.$watch('states', ctrl.refreshStates, true)

    ctrl.initQuery = ->
      $scope.query =
        eventId: $scope.event.id
        type: null
        track: null
        states: $scope.states.reduce(ctrl.addStateIfSelected, [])
        alreadyRated: null
        favouritesOnly: null
        invitesOnly: null
        alreadyScheduled: null
        myCommentWasLast: null
        tags: null
        query: null
      $scope.index = 0
      $scope.model =
        presentations: []
      $scope.busy = false

    $scope.event = $scope.defaultEvent
    ctrl.initQuery()

    ctrl.refreshEvent = ->
      return if !$scope.event
      ctrl.initQuery()

    $scope.$watch('event', ctrl.refreshEvent)

    ctrl.addPresentations = (prezos) ->
      $scope.model.count = prezos.count
      ctrl.enrichPresentations(prezos)
      $scope.model.presentations.push p for p in prezos.results
      $scope.busy = false
      $scope.resetResultAndRefresh() if $scope.retry
      $scope.retry = false

    $scope.refresh = ->
      $scope.busy = true
      PresentationQueryService.query({index: $scope.index}, $scope.query, ctrl.addPresentations)

    $scope.resetResultAndRefresh = ->
      if $scope.busy
        $scope.retry = true
        return
      $scope.index = 0
      $scope.model =
        presentations: []
      $scope.refresh()

    $scope.$watch('query', $scope.resetResultAndRefresh, true)

    ctrl.nextPage = ->
      $scope.index++
      $scope.refresh() if not $scope.busy

    ctrl.trim = (e)->
      e.trim()

    ctrl.refreshTags = ->
      return if !$scope.tags
      $scope.query.tags = $scope.tags.split(',').map(ctrl.trim)

    $scope.$watch('tags', ctrl.refreshTags)

    # set presentation.rating property with calculated average rating
    ctrl.updateRating = (prez) ->
      prez.rating = Presentation.averageRating(prez)

    # for each presentation in list calculate average rating
    ctrl.enrichPresentations = (presentations) ->
      ctrl.updateRating prez for prez in presentations.results

    $scope.stateClass = (state) ->
      switch state?.toUpperCase()
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

    $scope.typeDisplay = (type) -> type?.name?.toUpperCase().substr(0, 1)

    ctrl
  ]
