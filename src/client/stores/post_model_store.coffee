m = angular.module 'stores'
console.log("posts")
#####

m.factory 'PostModelActions', (Reflux) ->
  return Reflux.createActions ['loadAll', 'create', 'update', 'delete']

#####

m.factory 'PostModelStore', (
  $q
  DatafluxEvent
  PostModel
  PostModelActions
  Reflux
)->

  Reflux.createStore

    init: ->
      console.log("hello")

    listenables: PostModelActions

    # Public Methods

    get: (id)->
      return PostModel.get(id)?.toProxy() || null

    getAll: ->
      return (model.toProxy() for model in PostModel.getAll())

    # Action Methods

    onCreate: (params = {})->
      console.log("here")
      PostModel.create params
        .then (model)=>
          console.log "created", model
          @trigger DatafluxEvent.create, model.id
          @trigger DatafluxEvent.change
        .catch (error)=>
          console.error "Could not create:", error

    onLoadAll: ->
      PostModel.findAll()
        .then (models)=>
          promises = []
          for model in models
            promises.push(PostModel.loadRelations(model, ["comments"]))

          debugger
          $q.all(promises).then =>
            PostModel
            debugger
            @trigger DatafluxEvent.change
          debugger
        .catch (error)->
          console.error "Could not load all: ", error

    onDelete: (id)->
      PostModel.destroy id
        .then =>
          console.log "deleted Todo #{id}"
          @trigger DatafluxEvent.delete, id
          @trigger DatafluxEvent.change
        .catch (error)->
          console.error "Could not create: ", error
