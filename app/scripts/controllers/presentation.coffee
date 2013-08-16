angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', 'Presentation', 'RatingService', '$routeParams', '$log', 'MousetrapService','UserService'
    ($scope, PresentationService, Presentation, RatingService, $routeParams, $log, MousetrapService, UserService) ->
      $scope.presentation = PresentationService.get({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId}, (prez) ->
        $scope.avgRate = Presentation.averageRating(prez))

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
      )

      addShortcutToRateFor rate for rate in [0..5]

      $scope.rateIt = (rate) ->
        $log.debug('change presentation rate to ' + rate)
        $scope.rate = rate
        RatingService.save({presentationId: $routeParams.presentationId, eventId: $routeParams.eventId},
          {percentage: rate})

      $scope.thumbnailUrl = (user) ->
          return UserService.thumbnailUrl(user)

  ]
