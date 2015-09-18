controllers = angular.module('controllers')

controllers.controller('BlogsController', [ '$scope', '$routeParams', '$location', '$resource', '$http', '$sessionStorage'

  ($scope, $routeParams, $location, $resource, $http, $sessionStorage)->

    $http.defaults.headers.common['Authorization'] = 'Token token='+$sessionStorage.user_token

    $http.defaults.headers.common['user_email'] = $sessionStorage.user_email

    Session = $resource("/users/sign_out", {format: 'json'}, 
      {
        'delete': {method: 'DELETE'}
      }
    )

    Blog = $resource('blogs/:blogId', {blogId: "@id", format: 'json'})

    if $sessionStorage.user_token
      Blog.query((results) -> $scope.blogs = results)

    $scope.newBlog = -> $location.path("blogs/new")

    $scope.view = (blogId)-> $location.path("blogs/#{blogId}")

    $scope.edit = (blogId)-> $location.path("blogs/#{blogId}/edit")

    $scope.login = -> $location.path('/users/sign_in')

    $scope.register = -> $location.path("/users/register")

    $scope.logout = ->
      Session.delete(
        () ->
          $sessionStorage.user_email = ''
          $sessionStorage.user_token = ''
          window.sessionStorage.setItem('ngStorage-user_token', null)
          window.sessionStorage.setItem('ngStorage-user_email', null)
          $scope.blogs = {}
      )
      

])