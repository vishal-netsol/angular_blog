blog = angular.module('blog', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'ngCookies',
  'ngStorage',
])

blog.config(['$routeProvider', '$httpProvider',

  ($routeProvider, $httpProvider, $cookieStore) ->

    $routeProvider
      .when('/',
        templateUrl: "blogs/index.html"
        controller: "BlogsController"
      ).when('/blogs/new',
        templateUrl: "blogs/form.html"
        controller: "BlogController"
      ).when('/blogs/:blogId',
        templateUrl: "blogs/show.html"
        controller: "BlogController"
      ).when('/blogs/:blogId/edit',
        templateUrl: "blogs/form.html"
        controller: "BlogController"
      ).when('/blogs/:blogId/comments/:commentId/edit'
        templateUrl: "comments/form.html"
        controller: "CommentController"
      ).when('/users/sign_in',
        templateUrl: "sessions/form.html"
        controller: "UserController"
      ).when('/users/register',
        templateUrl: "registrations/form.html"
        controller: "UserController"
      )


    ($httpProvider) ->
      debugger
      $httpProvider.interceptors.push ($cookies, $sessionStorage) ->
        { 'request': (config) ->
          config.headers['X-USER-EMAIL'] = $sessionStorage.user_email
          config.headers.Authorization = $sessionStorage.user_token
          config
        }
])

controllers = angular.module('controllers', [])