m = angular.module 'models'

m.factory 'CommentModel', (
  DS
  ModelProxy
)->

  CommentModel = DS.defineResource

    name: 'comment'

    relations:
      belongsTo:
        post:
          localField: 'post'
          localKey: 'postId'
          foreignKey: 'id'

    fields: [
      'id'
      'postId'
      'author'
      'text'
      'votes'
    ]

    methods:

      toProxy: ->
        return new ModelProxy this, fields: CommentModel.fields

m.run (CommentModel) ->
