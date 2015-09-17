controllers = angular.module('controllers')

controllers.controller('BlogsController', [ '$scope', '$routeParams', '$location', '$resource',

  ($scope, $routeParams, $location, $resource)->

    Blog = $resource('blogs/:blogId', {blogId: "@id", format: 'json'})

    Blog.query((results) -> $scope.blogs = results)

    $scope.newBlog = -> $location.path("blogs/new")

    $scope.view = (blogId)-> $location.path("blogs/#{blogId}")

    $scope.edit = (blogId)-> $location.path("blogs/#{blogId}/edit")

])