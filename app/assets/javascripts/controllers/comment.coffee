controllers = angular.module("controllers")

controllers.controller('CommentController', ['$scope', '$routeParams', '$location', '$resource', '$http', '$sessionStorage', '$localStorage',
  ($scope, $routeParams, $location, $resource, $http, $sessionStorage, $localStorage) ->
    
    token = if $sessionStorage.user_token then $sessionStorage.user_token else $localStorage.user_token
    email = if $sessionStorage.user_email then $sessionStorage.user_email else $localStorage.user_email

    $http.defaults.headers.common['Authorization'] = 'Token token='+token

    $http.defaults.headers.common['user_email'] = email

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