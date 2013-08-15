angular.module('cfpReviewApp').controller 'MainCtrl',
  ['$scope', 'PresentationQueryService', 'Presentation', '$location', '$routeParams', ($scope, PresentationQueryService, Presentation, $location, $routeParams) ->
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

    ctrl = {}
    $scope.model = {}

    #
    # manage event selection
    #

    eventFromParams = (e)->
      "" + e.id == $routeParams.eventId

    ctrl.initEvent = ->
      $scope.model.event = $scope.events.filter(eventFromParams)[0] || $scope.defaultEvent

    ctrl.initEvent()

    #
    # manage states selection
    #

    statesFromParams = (s) ->
      s.value = ctrl.statesParams.indexOf(s.id) != -1
      s

    ctrl.initStates = ->
      ctrl.statesParams = if $routeParams.states then $routeParams.states.split(',') else []
      defaultStates = [
        {id: 'DELETED', value: false},
        {id: 'REJECTED', value: true},
        {id: 'SUBMITTED', value: true},
        {id: 'ONHOLD', value: true},
        {id: 'BACKUP', value: true},
        {id: 'APPROVED', value: true},
        {id: 'ACCEPTED', value: true},
        {id: 'DECLINED', value: true}
      ]
      $scope.states = if $routeParams.states then defaultStates.map(statesFromParams) else defaultStates

    ctrl.initStates()

    ctrl.addStateIfSelected = (memo, s) ->
      memo.push(s.id) if s.value
      memo

    ctrl.refreshStates = ->
     $scope.query.states = $scope.states.reduce(ctrl.addStateIfSelected, [])

    $scope.$watch('states', ctrl.refreshStates, true)

    #
    # manage query selection
    #

    filterById = (elt) ->
      this.id == "" + elt.id

    inside = (array, id) ->
      return if !id
      array.filter(filterById, {id: id})[0]

    ctrl.initQueryAndResetResults = () ->
      typeFromParam =
        id: $routeParams.type
      trackFromParam =
        id: $routeParams.track
      $scope.query =
        eventId: $scope.model.event.id
        type: if inside($scope.model.event.types, $routeParams.type) then typeFromParam else null
        track: if inside($scope.model.event.tracks, $routeParams.track) then trackFromParam else null
        states: if $routeParams.states then $routeParams.states.split(',') else $scope.states.reduce(ctrl.addStateIfSelected, [])
        alreadyRated: $routeParams.alreadyRated || null
        favouritesOnly: $routeParams.favouritesOnly || null
        invitesOnly: $routeParams.invitesOnly || null
        alreadyScheduled: $routeParams.alreadyScheduled || null
        myCommentWasLast: $routeParams.myCommentWasLast || null
        tags: if $routeParams.tags then $routeParams.tags.split(',') else null
        query: $routeParams.query || null
      $scope.index = 0
      $scope.model.presentations = []
      $scope.busy = false

    ctrl.initQueryAndResetResults()

    ctrl.refreshEvent = ->
      return if !$scope.model.event
      $location.search({eventId: $scope.model.event.id})
      ctrl.initQueryAndResetResults()

    $scope.$watch('model.event', ctrl.refreshEvent)

    #
    # utility to manage type and track selection
    #

    $scope.idToString =(id) ->
      "" + id

    #
    # manage results display
    #

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
      $scope.query.query = null if $scope.query.query == ''
      $scope.index = 0
      $scope.model.presentations = []
      search =
        eventId: $scope.query.eventId
      if $scope.query.states
        search.states = $scope.query.states
      if $scope.query.alreadyRated
        search.alreadyRated = $scope.query.alreadyRated
      if $scope.query.favouritesOnly
        search.favouritesOnly = $scope.query.favouritesOnly
      if $scope.query.invitesOnly
        search.invitesOnly = $scope.query.invitesOnly
      if $scope.query.alreadyScheduled
        search.alreadyScheduled = $scope.query.alreadyScheduled
      if $scope.query.myCommentWasLast
        search.myCommentWasLast = $scope.query.myCommentWasLast
      if $scope.query.tags
        search.tags = $scope.query.tags
      if $scope.query.query && $scope.query.query != ''
        search.query = $scope.query.query
      if $scope.query.type
        search.type = $scope.query.type.id
      if $scope.query.track
        search.track = $scope.query.track.id
      $location.search(search)
      $scope.refresh()

    $scope.$watch('query', $scope.resetResultAndRefresh, true)

    ctrl.nextPage = ->
      $scope.index++
      $scope.refresh() if not $scope.busy

    #
    # manage tags selection
    #

    ctrl.initTags = ->
      $scope.tags = $routeParams.tags if $routeParams.tags

    ctrl.initTags()

    ctrl.trim = (e)->
      e.trim()

    ctrl.refreshTags = ->
      $scope.query.tags = if $scope.tags && $scope.tags != '' then $scope.tags.split(',').map(ctrl.trim) else null

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
