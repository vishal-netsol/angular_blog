controllers = angular.module('controllers')
controllers.controller("BlogController", ['$scope', '$routeParams',
'$resource', '$location', '$http', '$sessionStorage', '$localStorage'
  
  ($scope, $routeParams, $resource, $location, $http, $sessionStorage, $localStorage)->

    token = if $sessionStorage.user_token then $sessionStorage.user_token else $localStorage.user_token
    email = if $sessionStorage.user_email then $sessionStorage.user_email else $localStorage.user_email

    $http.defaults.headers.common['Authorization'] = 'Token token='+token

    $http.defaults.headers.common['user_email'] = email

    Blog = $resource('/blogs/:blogId', {blogId: "@id", format: 'json'},
      {
        'save': {method: 'PUT'},
        'create': {method: 'POST'}
      }
    )

    Comment = $resource("/blogs/#{$routeParams.blogId}/comments", {format: 'json'}, 
      {
        'create': {method: 'POST'}
      }
    )

    delComment = $resource("/blogs/#{$routeParams.blogId}/comments/:commentId", {commentId: "@id", format: 'json'}, 
      {
        'delete': {method: 'DELETE'}
      }
    )

    if $routeParams.blogId and $sessionStorage.user_token
      Comment.query((results) -> $scope.comments = results)
      
      Blog.get({blogId: $routeParams.blogId},
        ((blog) -> $scope.blog = blog)
      )
    else
      $scope.blog = {}

    $scope.cancel = ->
      if $scope.blog.id
        $location.path("/blogs/#{$scope.blog.id}")
      else
        $location.path('/')

    $scope.back = -> $location.path("/")

    $scope.edit = -> $location.path("/blogs/#{$scope.blog.id}/edit")

    $scope.save = ->
      if $scope.blog.id
        $scope.blog.$save(
          ( ()-> $location.path("/blogs/#{$scope.blog.id}"))
        )
      else
        Blog.create($scope.blog,
          (newBlog)-> $location.path("/")
        )

    $scope.delete = ->
      $scope.blog.$delete(
        () -> $location.path("/")
      )

    $scope.addComment = ->
      Comment.create($scope.comment,
        (comment) -> 
          $location.path("/blogs/#{$scope.blog.id}")
          $scope.comment={}
          $scope.comments.push(comment)
      )

    $scope.editComment = (commentId)-> $location.path("/blogs/#{$scope.blog.id}/comments/#{commentId}/edit")

    $scope.deleteComment = (commentId, index)->
      delComment.delete({commentId: commentId},
        () ->
          $scope.comments.splice(index, 1)
      )
      

])