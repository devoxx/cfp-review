angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', 'PresentationQuery', 'RatingService', '$routeParams', '$log', 'MousetrapService','UserService'
    ($scope, PresentationService, PresentationQuery, RatingService, $routeParams, $log, MousetrapService, UserService) ->

      calculateAvgRate = (prez) ->
        $scope.avgRate = PresentationQuery.averageRating(prez)

      fetchPresentation = ->
        PresentationService.get({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId}, calculateAvgRate)

      $scope.presentation = fetchPresentation()

      $scope.rate = 3

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
        $scope.rate = rate
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

      $scope.model = PresentationQuery.getModel()
      $scope.model.presentationIndex = PresentationQuery.findPresentationIndex($routeParams.presentationId)

  ]
