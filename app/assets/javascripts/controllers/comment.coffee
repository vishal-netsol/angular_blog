controllers = angular.module("controllers")

controllers.controller('CommentController', ['$scope', '$routeParams', '$location', '$resource', '$http', '$sessionStorage'
  ($scope, $routeParams, $location, $resource, $http, $sessionStorage) ->
    

    $http.defaults.headers.common['Authorization'] = 'Token token='+$sessionStorage.user_token

    $http.defaults.headers.common['user_email'] = $sessionStorage.user_email

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