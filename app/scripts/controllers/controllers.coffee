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
    $scope.model = Presentation.init()

    $scope.$watch('model.states', Presentation.refreshStates, true)
    $scope.$watch('model.event', Presentation.refreshEvent)
    $scope.$watch('model.query', Presentation.resetResultAndRefresh, true)
    $scope.$watch('model.tags', Presentation.refreshTags)

    $scope.nextPage = ->
      $scope.model.index++
      Presentation.refresh() if not $scope.model.busy

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

    $scope.idToString = (id) ->
      '' + id

    ctrl
  ]
