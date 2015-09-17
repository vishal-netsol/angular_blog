controllers = angular.module("controllers")

controllers.controller('CommentController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource) ->
    
    Comment = $resource('/blogs/:blogId/comments/:commentId', {format: 'json'},
      {
        'save': {method: 'PUT'}
      }
    )

    Comment.get({blogId: $routeParams.blogId, commentId: $routeParams.commentId},
      ( (comment)-> $scope.comment=comment )
    )

    $scope.updateComment = ->
      $scope.comment.$save({blogId: $routeParams.blogId, commentId: $routeParams.commentId},
        ( ()-> $location.path("/blogs/#{$routeParams.blogId}/") )
      )

])