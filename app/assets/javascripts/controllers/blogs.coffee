controllers = angular.module('controllers')

controllers.controller('BlogsController', [ '$scope', '$routeParams', '$location', '$resource', '$http', '$sessionStorage', '$localStorage',

  ($scope, $routeParams, $location, $resource, $http, $sessionStorage, $localStorage)->

    token = if $sessionStorage.user_token then $sessionStorage.user_token else $localStorage.user_token
    email = if $sessionStorage.user_email then $sessionStorage.user_email else $localStorage.user_email

    $http.defaults.headers.common['Authorization'] = 'Token token='+token

    $http.defaults.headers.common['user_email'] = email

    Session = $resource("/users/sign_out", {format: 'json'}, 
      {
        'delete': {method: 'DELETE'}
      }
    )

    Blog = $resource('blogs/:blogId', {blogId: "@id", format: 'json'})

    if token
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
          window.localStorage.clear()
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