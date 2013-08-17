'use strict';

xdescribe('Service: Services', function () {

    beforeEach(module('cfpReviewApp'));

    beforeEach(function () {
        this.addMatchers({
            toEqualData: function (expected) {
                return angular.equals(this.actual, expected);
            }
        });
    });

    var PresentationService, UserService, EventsService, ConfigAPI,
        expected = {results: [
            {
                'expectedData': 123
            }
        ]
        },
        expectedEvent = [
            {
                'expectedData': 123
            }
        ],
        expectedUser = {firstname: 'Vlad'};

    beforeEach(inject(function (_EventsService_, _ConfigAPI_, _PresentationService_, _UserService_) {
        PresentationService = _PresentationService_;
        EventsService = _EventsService_;
        UserService = _UserService_;
        ConfigAPI = _ConfigAPI_;
    }));

    xit('should get a presentation list for event 8', inject(function ($httpBackend) {

        $httpBackend.expectGET(new RegExp(baseUri + 'review/event/8/presentation')).respond(expected);

        var actual = PresentationService.query({eventId: '8', userToken: 'xxx'});

        $httpBackend.flush();

        expect(actual).toBeDefined();
        expect(actual).toEqualData(expected);
    }));

    xit('should get a presentation for event 8', inject(function ($httpBackend) {

        $httpBackend.expectGET(new RegExp(baseUri + 'review/event/8/presentation/123')).respond(expected);

        var actual = PresentationService.get({ presentationId: 123, eventId: 8 });

        $httpBackend.flush();

        expect(actual).toBeDefined();
        expect(actual).toEqualData(expected);
    }));

    it('should get an event list', inject(function ($httpBackend) {

        $httpBackend.expectGET(new RegExp(baseUri + 'proposal/event')).respond(expectedEvent);

        var actual = EventsService.query();

        $httpBackend.flush();

        expect(actual).toBeDefined();
        expect(actual).toEqualData(expectedEvent);
    }));


    it('should get an user on login', inject(function ($httpBackend) {

        $httpBackend.expectPOST(new RegExp(baseUri + 'auth')).respond(expectedUser);

        var actual = UserService.login('vlad', 'imir').then(function (user) {
            actual = user;
        });

        $httpBackend.flush();

        expect(actual).toBeDefined();
        expect(actual.data).toEqualData(expectedUser);
    }));
});
