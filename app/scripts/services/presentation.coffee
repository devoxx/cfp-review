angular.module('cfpReviewApp').factory 'Presentation',
  ['PresentationService'
    (PresentationService) ->
      # calculate average rating of a presentation
      prezentation=
        averageRating: (prez) ->
          return '?' if not prez.ratings? or prez.ratings.length == 0
          sum = prez.ratings.reduce (x, y) ->
            sum =
              percentage: x.percentage + y.percentage
          sum.percentage / prez.ratings.length

      return prezentation
  ]
