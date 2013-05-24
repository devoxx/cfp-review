'use strict';

/* http://docs.angularjs.org/guide/dev_guide.e2e-testing */

describe('Main', function () {

  beforeEach(function () {
    browser().navigateTo('/index.html');
  });

  describe('Display presentations', function () {
    it('should display a list of presentation', function () {
      expect(element('[id^=presentation-]').count()).toBeGreaterThan(1);
      expect(element('[id^=presentation-][class*=success]').count()).toEqual(1);
    });
  });

});
