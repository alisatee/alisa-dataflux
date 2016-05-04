m = angular.module 'directives.comment'

#####

m.directive 'comment', (
)->
  controller: 'CommentController'
  restrict: 'E'
  scope: {
    modelId: "@"
  }
  template: templates['directives/comment']
