angular.module('cfpReviewApp').factory 'PresentationQuery',
  ['PresentationService', 'PresentationQueryService', '$routeParams', '$location'
    (PresentationService, PresentationQueryService, $routeParams, $location) ->

      model = {}
      events = {}

      keepEvents = (evts) ->
        events = evts

      eventFromParams = (e)->
        '' + e.id == '' + $routeParams.eventId

      # search event from url param eventId, if not found use the first
      initEvent = ->
        events.filter(eventFromParams)[0] || events[0]

      # calculate average rating of a presentation
      averageRating = (prez) ->
        return '?' if not prez.ratings? or prez.ratings.length == 0
        sum = prez.ratings.reduce (x, y) ->
          sum =
            percentage: x.percentage + y.percentage
        sum.percentage / prez.ratings.length

      #
      # utilities to filter/map/reduce array
      #

      statesFromParams = (s) ->
        s.value = this.indexOf(s.id) != -1
        s

      filterById = (elt) ->
        '' + this.id == '' + elt.id

      inside = (array, id) ->
        return if !id
        array.filter(filterById, {id: id})[0]

      addStateIfSelected = (memo, s) ->
        memo.push(s.id) if s.value
        memo

      # use params from url to initiate query
      initQuery = ->
        typeFromParam =
          id: $routeParams.type
        trackFromParam =
          id: $routeParams.track
        query =
          eventId: model.event.id
          type: if inside(model.event.types, $routeParams.type) then typeFromParam else null
          track: if inside(model.event.tracks, $routeParams.track) then trackFromParam else null
          states: if $routeParams.states then $routeParams.states.split(',') else model.states.reduce(addStateIfSelected, [])
          alreadyRated: $routeParams.alreadyRated || null
          favouritesOnly: $routeParams.favouritesOnly || null
          invitesOnly: $routeParams.invitesOnly || null
          alreadyScheduled: $routeParams.alreadyScheduled || null
          myCommentWasLast: $routeParams.myCommentWasLast || null
          query: $routeParams.query || null
        query

      # use states from url param if found, else use default config
      initStates = ->
        statesParams = if $routeParams.states then $routeParams.states.split(',') else []
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
        if $routeParams.states then defaultStates.map(statesFromParams, statesParams) else defaultStates

      # use tags from url param if found, replacing separator ',' with ' '
      initTags = ->
        $routeParams.tags.replace(/,/g, ' ') if $routeParams.tags

      resetResult = ->
        model.index = 0
        model.count = 0
        model.presentations = []

      init = ->
        model =
          event: initEvent()
          events: events
          states: initStates()
          tags: initTags()
          busy: false
          size: 10
        model.query = initQuery()
        model.busy = false
        resetResult()
        model

      getModel = ->
        model

      trim = (e)->
        e.trim()

      # refresh 'query.tags' with value of 'tags', splitting tags on space and trim result
      refreshTags = ->
        model.query.tags = if model.tags && model.tags != '' then model.tags.split(' ').map(trim) else null

      # refresh 'query.states' with value of 'states', only selected states are added to query
      refreshStates = ->
        model.query.states = model.states.reduce(addStateIfSelected, [])

      # on refresh event, update url param eventId with new one and update query
      refreshEvent = ->
        return if !model.event
        $location.search(angular.extend($location.search(), {eventId: model.event.id}))
        model.query = initQuery()
        model.busy = false
        resetResult()

      # set presentation.rating property with calculated average rating
      updateRating = (prez) ->
        prez.rating = averageRating(prez)

      # for each presentation in list calculate average rating
      enrichPresentations = (presentations) ->
        updateRating prez for prez in presentations.results

      addPresentations = (prezos) ->
        model.count = prezos.count
        enrichPresentations(prezos)
        model.presentations.push p for p in prezos.results
        model.busy = false
        resetResultAndRefresh() if model.retry
        model.retry = false

      canIncrement = () ->
        ( model.index + 1 ) < ( model.count / model.size )

      # fetch results from API then enrich result before display
      refresh = (incrementIndex) ->
        return if !canIncrement() and incrementIndex
        model.index++ if incrementIndex
        model.busy = true
        PresentationQueryService.query({index: model.index, size: model.size}, model.query, addPresentations).$then

      # create search and update url with selected query parameters
      updateSearchFromQuery = () ->
        search =
          eventId: model.query.eventId
        if model.query.states
          search.states = model.query.states.join(',') if model.query.states
        if model.query.alreadyRated
          search.alreadyRated = model.query.alreadyRated
        if model.query.favouritesOnly
          search.favouritesOnly = model.query.favouritesOnly
        if model.query.invitesOnly
          search.invitesOnly = model.query.invitesOnly
        if model.query.alreadyScheduled
          search.alreadyScheduled = model.query.alreadyScheduled
        if model.query.myCommentWasLast
          search.myCommentWasLast = model.query.myCommentWasLast
        if model.query.tags
          search.tags = model.query.tags
        if model.query.query && model.query.query != ''
          search.query = model.query.query
        if model.query.type
          search.type = model.query.type.id
        if model.query.track
          search.track = model.query.track.id
        $location.search(search)

      resetResultAndRefresh = ->
        if model.busy
          model.retry = true
          return
        resetResult()
        model.query.query = null if model.query.query == ''
        updateSearchFromQuery()
        refresh()

      comingFromSearch = ->
        model.presentations?.length > 0

      findPresentationIndex = (id) ->
        return if !model.presentations
        found = model.presentations.filter(filterById, {id: id})
        if found[0] then model.presentations.indexOf(found[0]) else -1

      gotoPresentation = (id) ->
        if id
          $location.path('/event/' + $routeParams.eventId + '/presentation/' + id)

      previous = ->
        presentationIndex = findPresentationIndex($routeParams.presentationId)
        newPresentationId = if presentationIndex > 0 then model.presentations[presentationIndex - 1].id else null
        gotoPresentation(newPresentationId)

      getNextPresentationId = (presentationIndex) ->
        newIndex = presentationIndex + 1
        if newIndex < model.presentations.length
           model.presentations[newIndex].id
        else
          # in case, we didn't load all prezos, then we load next page then goto next prez
          refresh(true)(->
            gotoPresentation(model.presentations[newIndex].id)
          )
          null

      next = ->
        presentationIndex = findPresentationIndex($routeParams.presentationId)
        newPresentationId = if presentationIndex < model.count then getNextPresentationId(presentationIndex) else null
        gotoPresentation(newPresentationId)

      service =
        averageRating: averageRating
        keepEvents: keepEvents
        initEvent: initEvent
        init: init
        refreshStates: refreshStates
        refreshEvent: refreshEvent
        refreshTags: refreshTags
        refresh: refresh
        resetResultAndRefresh: resetResultAndRefresh
        comingFromSearch: comingFromSearch
        previous: previous
        next: next
        getModel: getModel
        findPresentationIndex: findPresentationIndex

      return service
  ]
