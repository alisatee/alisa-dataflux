m = angular.module 'models'

m.factory 'PostModel', (
  DS
  ModelProxy
)->

  PostModel = DS.defineResource

    name: 'post'

    relations:
      hasMany:
        comment:
          localField: 'comments'
          foreignKey: 'postId'

    fields: [
      'id'
      'author'
      'title'
      'body'
    ]

    methods:

      toProxy: ->
        return new ModelProxy(this,
          fields: PostModel.fields
          relations: ["comments"]
        )

m.run (PostModel) ->
