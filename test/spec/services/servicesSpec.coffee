describe 'Service: Services', ->
  beforeEach module 'cfpReviewApp'

  TalksService = {}
  beforeEach inject (_TalksService_) ->
    TalksService = _TalksService_

  it 'should get a talk list', ->
    actual = TalksService.talks()
    expect(actual).toBeDefined()
    expect(actual.length).toEqual(40)


