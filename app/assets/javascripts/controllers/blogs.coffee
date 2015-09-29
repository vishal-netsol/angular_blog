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
          window.sessionStorage.clear()
          $scope.blogs = {}
      )

    $scope.Vishal = {}
    $scope.Vishal.name = "Vishal"
    $scope.Vishal.rollno = "26"

    $scope.tree = [
      {
        name: 'States'
        link: '#'
        subtree: [
          {
            name: 'state 1'
            link: 'state1'
            subtree: [ {
              name: 'state 1'
              link: 'state1'
              subtree: [ {
                name: 'vishal'
                link: 'vishal'
              } ]
            } ]
          }
          {
            name: 'state 2'
            link: 'state2'
          }
        ]
      }
      {
        name: 'No states'
        link: '#'
        subtree: [ {
          name: 'no state connected'
          link: '#'
        } ]
      }
      {
        name: 'divider'
        link: '#'
      }
      {
        name: 'State has not been set up'
        link: '#'
      }
      {
        name: 'divider'
        link: '#'
      }
      {
        name: 'Here again no state set up'
        link: '#'
      }
    ]
      

])