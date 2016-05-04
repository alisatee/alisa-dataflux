m = angular.module 'directives.comment'

#####

m.controller 'CommentController', (
  $scope
  DatafluxEvent
  CommentModelActions
  CommentModelStore
)->

  # Helper Functions

  _updateScope = ->
    comment = CommentModelStore.get($scope.modelId) or {}

    $scope.comment = if comment.toHash? then comment.toHash() else comment

  _updateScope()

  # Listener Methods

  CommentModelStore.$listen (event, id) ->
    _updateScope()

  # Scope Functions

  $scope.vote = (direction) ->
    comment = CommentModelStore.get($scope.modelId)

    if direction == "up" then $scope.comment.votes += 1 else $scope.comment.votes -= 1
    if $scope.comment.votes < 0 then $scope.comment.votes = 0

    comment.votes = $scope.comment.votes
    CommentModelActions.update(comment)
