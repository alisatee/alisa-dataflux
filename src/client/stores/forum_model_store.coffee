m = angular.module 'stores'

m.factory 'ForumModelStore', (
  DatafluxEvent
  Reflux
)->

  Reflux.createStore

    init: ->
      return 
    # Action Methods

    onCreate: (params = {})->
      console.log("here")
      CommentModel.create params
        .then (model)=>
          console.log "created", model
          @trigger DatafluxEvent.create, model.id
          @trigger DatafluxEvent.change
        .catch (error)=>
          console.error "Could not create:", error
