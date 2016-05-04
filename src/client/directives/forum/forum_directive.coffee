m = angular.module 'directives.forum'

#####

m.directive 'forum', (
)->
  controller: 'ForumController'
  restrict: 'E'
  scope: {
    commentId: "@"
  }
  template: templates['directives/forum']
