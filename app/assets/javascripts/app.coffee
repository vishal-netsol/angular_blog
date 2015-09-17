blog = angular.module('blog', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

blog.config(['$routeProvider',
  ($routeProvider) ->

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
      )
])

controllers = angular.module('controllers', [])