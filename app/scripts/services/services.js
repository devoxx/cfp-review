'use strict';

angular.module('Services', [])
  .factory('TalksService',function () {
    var talks = [
      { id: '1', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'What’s New in JavaFX', state: 'Approved', rate: 4, voters: 5, type: 'C'},
      { id: '2', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Java EE 7, Infinite Extensibility meets Infinite Reuse', state: 'Submitted', rate: 5, voters: 5, type: 'C'},
      { id: '3', eventfirstName: 'Devoxx', lastName: 'Belgium', title: '7 Things: How to make good teams great', state: 'Deleted', rate: 3, voters: 5, type: 'H'},
      { id: '4', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'What\'s new with Google App Engine and Compute Engine?', state: 'Rejected', rate: 4, voters: 5, type: 'T'},
      { id: '5', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Securing the client side: Building safe web applications with HTML5', state: 'Onhold', rate: 3, voters: 5, type: 'C'},
      { id: '6', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Engineering Elegance: The Secrets of Square\'s Stack', state: 'Backup', rate: 3, voters: 5, type: 'C'},
      { id: '7', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Designing REST-ful APIs with Spring 3', state: 'Accepted', rate: 4, voters: 5, type: 'C'},
      { id: '8', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'On the road to JDK 8: Lambda, parallel libraries, and more', state: 'Declined', rate: 5, voters: 5, type: 'H'},
      { id: '9', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'What\'s new with Android', state: 'Submitted', rate: 3, voters: 5, type: 'T'},
      { id: '10', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Eclipse: An Application Lifecycle Management Success Story', state: 'Approved', rate: 4, voters: 5, type: 'C'},
      { id: '11', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Smart, Small, Connected: Java in the Internet of Things', state: 'Approved', rate: 3, voters: 5, type: 'H'},
      { id: '12', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Using Java for robotics with Aldebaran\'s humanoid robot NAO', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '13', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Home Automation for Geeks', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '14', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'OpenShift State of the Union', state: 'Submitted', rate: 4, voters: 5, type: 'T'},
      { id: '15', eventfirstName: 'Devoxx', lastName: 'Belgium', title: 'Closures and Collections - the World After Eight', state: 'Approved', rate: 5, voters: 5, type: 'H'},

      { id: '20', eventfirstName: 'Devoxx', lastName: 'France', title: 'Developers: Prima Donna\'s of the 21st Century', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '21', eventfirstName: 'Devoxx', lastName: 'France', title: 'Elastifiez votre application : du SQL au NoSQL en moins d\'une heure', state: 'Submitted', rate: 5, voters: 5, type: 'C'},
      { id: '22', eventfirstName: 'Devoxx', lastName: 'France', title: 'RealityIS_AGraph', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '23', eventfirstName: 'Devoxx', lastName: 'France', title: '"Faciliter le développement d’applications Web hors-ligne en JAVA avec GWT"', state: 'Submitted', rate: 4, voters: 5, type: 'T'},
      { id: '24', eventfirstName: 'Devoxx', lastName: 'France', title: 'Le Space-Mountain du développement Java d\'entreprise', state: 'Submitted', rate: 5, voters: 5, type: 'H'},
      { id: '25', eventfirstName: 'Devoxx', lastName: 'France', title: 'Comparing JVM Web Frameworks', state: 'Submitted', rate: 4, voters: 5, type: 'T'},
      { id: '26', eventfirstName: 'Devoxx', lastName: 'France', title: 'BigData@DevoxxFr, Saison 2', state: 'Submitted', rate: 3, voters: 5, type: 'T'},
      { id: '27', eventfirstName: 'Devoxx', lastName: 'France', title: 'Java EE 7 en détail', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '28', eventfirstName: 'Devoxx', lastName: 'France', title: 'No(Geo)SQL', state: 'Submitted', rate: 5, voters: 5, type: 'C'},
      { id: '29', eventfirstName: 'Devoxx', lastName: 'France', title: 'What Every Hipster Should Know About Functional Programming', state: 'Submitted', rate: 4, voters: 5, type: 'C'},
      { id: '30', eventfirstName: 'Devoxx', lastName: 'France', title: 'Architecting for Continuous Delivery', state: 'Submitted', rate: 3, voters: 5, type: 'C'},

      { id: '100', eventfirstName: 'Devoxx', lastName: 'France', title: '55 New features in Java SE 8', state: 'Submitted', rate: 4, voters: 5, type: 'C'},
      { id: '101', eventfirstName: 'Devoxx', lastName: 'France', title: 'Continuous Delivery', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '102', eventfirstName: 'Devoxx', lastName: 'France', title: 'JSR 347 - standardising data grids for Java', state: 'Submitted', rate: 5, voters: 5, type: 'C'},
      { id: '103', eventfirstName: 'Devoxx', lastName: 'France', title: 'Apache TomEE, Java EE 6 Web Profile on Tomcat', state: 'Submitted', rate: 4, voters: 5, type: 'C'},
      { id: '104', eventfirstName: 'Devoxx', lastName: 'France', title: 'Are your GC logs speaking to you, the G1GC edition', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '105', eventfirstName: 'Devoxx', lastName: 'France', title: 'Effective IDE Usage', state: 'Submitted', rate: 4, voters: 5, type: 'C'},
      { id: '106', eventfirstName: 'Devoxx', lastName: 'France', title: 'Banking, how hard can it be?', state: 'Submitted', rate: 4, voters: 5, type: 'C'},
      { id: '107', eventfirstName: 'Devoxx', lastName: 'France', title: 'Functional is cool, but do you know OO?', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '108', eventfirstName: 'Devoxx', lastName: 'France', title: 'Build a web app with WebRTC', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '109', eventfirstName: 'Devoxx', lastName: 'France', title: 'Performance Testing Java Applications', state: 'Submitted', rate: 4, voters: 5, type: 'C'},
      { id: '110', eventfirstName: 'Devoxx', lastName: 'France', title: 'Securing the Future with Java', state: 'Submitted', rate: 5, voters: 5, type: 'C'},
      { id: '111', eventfirstName: 'Devoxx', lastName: 'France', title: 'Teaching Java to a 10-year old', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '112', eventfirstName: 'Devoxx', lastName: 'France', title: 'Lambdas and Collections in Java 8', state: 'Submitted', rate: 3, voters: 5, type: 'C'},
      { id: '113', eventfirstName: 'Devoxx', lastName: 'France', title: 'Hitting the limits of your hardware with Java', state: 'Submitted', rate: 5, voters: 5, type: 'C'}
    ];

    return {
      talks: function () {
        return talks;
      }
    };
  });
