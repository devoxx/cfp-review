angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', 'PresentationQuery', 'RatingService', '$routeParams', '$log', 'MousetrapService','UserService', 'CommentService', 'FeedbackService', 'Tags'
    ($scope, PresentationService, PresentationQuery, RatingService, $routeParams, $log, MousetrapService, UserService, CommentService, FeedbackService, Tags) ->

      calculateAvgRate = (prez) ->
        $scope.avgRate = PresentationQuery.averageRating(prez)

      fetchPresentation = ->
        PresentationService.get({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId}, calculateAvgRate)

      $scope.model = PresentationQuery.getModel()
      $scope.model.presentation = fetchPresentation()
      $scope.model.presentationIndex = PresentationQuery.findPresentationIndex($routeParams.presentationId)
      $scope.model.rate = PresentationQuery.findCurrentUserRating($scope.model.presentation)

      addShortcutToRateFor = (rate) ->
        MousetrapService.bind(rate.toString(), ->
          $scope.$apply(->
            $scope.rateIt(rate)
          )
        )

      removeShortcutToRateFor = (rate) ->
        MousetrapService.unbind(rate.toString())

      $scope.$on('$routeChangeStart', ->
        removeShortcutToRateFor rate for rate in [0..5]
        MousetrapService.unbind(['p', 'left', 'up'])
        MousetrapService.unbind(['n', 'right', 'down'])
      )

      addShortcutToRateFor rate for rate in [0..5]

      MousetrapService.bind(['p', 'left', 'up'], ->
        $scope.$apply(->
          $scope.previous()
        )
      )

      MousetrapService.bind(['n', 'right', 'down'], ->
        $scope.$apply(->
          $scope.next()
        )
      )

      $scope.rateIt = (rate) ->
        $log.debug('change presentation rate to ' + rate)
        $scope.model.rate = rate
        RatingService.save({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId},
          {percentage: rate})

      $scope.thumbnailUrl = (user) ->
          UserService.thumbnailUrl(user)

      $scope.previous = () ->
        PresentationQuery.previous()

      $scope.next = () ->
        PresentationQuery.next()

      $scope.comingFromSearch = () ->
        PresentationQuery.comingFromSearch()

      $scope.addComment = ->
        return if !$scope.newComment
        CommentService.save({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId},
        {text: $scope.newComment, user: UserService.getCurrentUser(), createdOn: Date.now()})

      $scope.addFeedback = ->
        return if !$scope.newFeedback
        FeedbackService.save({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId},
        {text: $scope.newFeedback, user: UserService.getCurrentUser(), createdOn: Date.now()})

      $scope.getTags = (partialTagName) ->
        Tags.query(partialTagName)

      filterTagNames = (tags) ->
        byName = (tag) ->
          tag?.name
        if tags then tags.map(byName) else []

      $scope.addTag = ->
        tags = $scope.model.presentation.tags
        if filterTagNames(tags).indexOf($scope.model.newTag) == -1

          Tags.query($scope.model.newTag).then (data) ->

            byName = (tag) ->
              tag.name == this.newTag
            tagToAdd = data?.filter(byName, $scope.model)[0]

            if tagToAdd
              tags.push(tagToAdd)
            else
              tagToAdd = {name: $scope.model.newTag}
              Tags.addTags([tagToAdd]).then ->
                tags.push tagToAdd

            $scope.model.newTag = ''

  ]
