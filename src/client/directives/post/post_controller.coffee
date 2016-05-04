m = angular.module 'directives.post'

#####

m.controller 'PostController', (
  $scope
  DatafluxEvent
  CommentModelActions
  CommentModelStore
  PostModelActions
  PostModelStore
)->

  $scope.expanded = false

  _updateScope = ->
    $scope.post =  PostModelStore.get($scope.modelId)

  _updateScope()

  # Helper Functions


  # Listener Methods

  PostModelStore.$listen (event, id) ->
    return unless event is DatafluxEvent.change
    _updateScope()

  CommentModelStore.$listen (event, id) ->
    return unless event is DatafluxEvent.change
    _updateScope()

  # Scope Functions
  $scope.addComment = ->
    $scope.comment = {}
    $scope.comment.postId = $scope.post.id
    $scope.comment.votes = 0
    $scope.toggleCommentTextBox = true

  $scope.createComment = ->
    CommentModelActions.create($scope.comment)
    $scope.toggleCommentTextBox = false

  $scope.expandPost = ->
    $scope.expanded = true

  $scope.delete = ->
    PostModelActions.delete($scope.modelId)
