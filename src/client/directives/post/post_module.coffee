m = module.exports = angular.module 'directives.post', [
  'dataflux'
  'stores'
]

require './post_controller'
require './post_directive'
