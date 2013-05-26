angular.module('cfpReviewApp').controller 'PresentationCtrl',
  ['$scope', 'PresentationService', 'RatingService', '$routeParams', '$log', 'MousetrapService'
    ($scope, PresentationService, RatingService, $routeParams, $log, MousetrapService) ->
      $scope.presentation = PresentationService.get({presentationId: $routeParams.presentationId, eventId: $scope.defaultEvent.id})

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

      $scope.rate = 3

      $scope.rateIt = (rate) ->
        $log.debug('change presentation rate to ' + rate)
        $scope.rate = rate
        RatingService.save({presentationId: $routeParams.presentationId, eventId: $scope.defaultEvent.id},
        {percentage: rate})

  ]
