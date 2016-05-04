m = angular.module 'directives.forum'

#####

m.controller 'ForumController', (
  $scope
  DatafluxEvent
  PostModelActions
  PostModelStore
)->

  # Helper Functions
  $scope.posts = []
  $scope.newPost = {}

  PostModelActions.loadAll()

  # Listener Methods

  PostModelStore.$listen (event, id) ->
    return unless event is DatafluxEvent.change
    $scope.posts = PostModelStore.getAll()

  # Scope Functions

  $scope.addPost = ->
    $scope.newPost = {}
    $scope.showTopicTextarea = true

  $scope.createPost = ->
    PostModelActions.create($scope.newPost)
    $scope.showTopicTextarea = false

  $scope.goToPost = (id) ->
    $scope.closeupPostId = id
