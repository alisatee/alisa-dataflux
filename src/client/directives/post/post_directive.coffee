m = angular.module 'directives.post'

#####

m.directive 'post', (
)->
  controller: 'PostController'
  restrict: 'E'
  scope: {
    modelId: "@"
  }
  template: templates['directives/post']
