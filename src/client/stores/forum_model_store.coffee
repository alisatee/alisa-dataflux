m = angular.module 'stores'

m.factory 'ForumModelStore', (
  DatafluxEvent
  Reflux
)->

  Reflux.createStore

    init: ->

    # listenables: CommentModelActions
    # Public Methods

    # get: (id)->
    #   return CommentModel.get(id)?.toProxy() || null
    #
    # getByPostId: (id)->
    #   ## Use the Post Store to get a post's comments
    #   return

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
