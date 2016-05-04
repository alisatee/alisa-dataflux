#
# Copyright (C) 2015 by Looker Data Services, Inc.
# All rights reserved.
#

m = module.exports = angular.module 'stores', ['dataflux', 'models']

require './todo_model_store'
require './post_model_store'
require './comment_model_store'
