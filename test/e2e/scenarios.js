'use strict';

/* http://docs.angularjs.org/guide/dev_guide.e2e-testing */

describe('Main', function () {

  beforeEach(function () {
    browser().navigateTo('/index.html');
  });

  describe('Main features', function () {
    it('should display a list of talk with only one selected', function () {
      expect(element('[id^=talk-]').count()).toBeGreaterThan(1);
      expect(element('[id^=talk-][class*=success]').count()).toEqual(1);
    });
  });

});
