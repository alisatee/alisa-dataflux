m = angular.module 'stores'

#####

m.factory 'CommentModelActions', (Reflux) ->
  return Reflux.createActions ['create', 'update', 'delete']

#####

m.factory 'CommentModelStore', (
  DatafluxEvent
  CommentModel
  CommentModelActions
  Reflux
)->

  Reflux.createStore

    init: ->

    listenables: CommentModelActions
    # Public Methods

    get: (id)->
      return CommentModel.get(id)?.toProxy() || null

    # Action Methods

    onCreate: (params = {})->
      CommentModel.create params
        .then (model)=>
          console.log "created", model
          @trigger DatafluxEvent.create, model.id
          @trigger DatafluxEvent.change
        .catch (error)=>
          console.error "Could not create:", error

    onUpdate: (proxy) ->
      return unless proxy.checkDirty()

      params = proxy.toHash()
      delete params.id

      CommentModel.update proxy.id, params
        .then (model)=>
          console.log "updated ", model
          @trigger DatafluxEvent.update, model.id
          @trigger DatafluxEvent.change
        .catch (error)->
          console.error "Could not update: ", error
