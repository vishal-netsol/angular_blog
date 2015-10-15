blog = angular.module('blog', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'ngCookies',
  'ngStorage',
  'directives',
  'ui.bootstrap'
])

blog.config(['$routeProvider', '$httpProvider',

  ($routeProvider, $httpProvider, $cookieStore) ->

    requireAuthentication = ->
      { load: ($q, $location) ->
        if(window.sessionStorage.key('ngStorage-user_token') or window.localStorage.key('ngStorage-user_token'))
          true
        else
          alert("Please login before continuing!!")
          $location.path('/')
      }


    $routeProvider
      .when('/',
        templateUrl: "blogs/index.html"
        controller: "BlogsController"
      ).when('/blogs/new',
        templateUrl: "blogs/form.html"
        controller: "BlogController"
        resolve: requireAuthentication()
      ).when('/blogs/:blogId',
        templateUrl: "blogs/show.html"
        controller: "BlogController"
        resolve: requireAuthentication()
      ).when('/blogs/:blogId/edit',
        templateUrl: "blogs/form.html"
        controller: "BlogController"
        resolve: requireAuthentication()
      ).when('/blogs/:blogId/comments/:commentId/edit'
        templateUrl: "comments/form.html"
        controller: "CommentController"
        resolve: requireAuthentication()
      ).when('/users/sign_in',
        templateUrl: "sessions/form.html"
        controller: "UserController"
      ).when('/users/register',
        templateUrl: "registrations/form.html"
        controller: "UserController"
      )
])

controllers = angular.module('controllers', [])
directives = angular.module('directives', [])