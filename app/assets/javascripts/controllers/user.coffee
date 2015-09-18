controllers = angular.module('controllers')
controllers.controller('UserController', ['$scope', '$routeParams', '$resource', '$location', '$sessionStorage', '$http',

  ($scope, $routeParams, $resource, $location, $sessionStorage, $http)->

    $http.defaults.headers.common['Authorization'] = 'Token token='+null

    Session = $resource('/users/sign_in', {format: 'json'},
      {
        'create': {method: 'POST'}
      }
    )

    User = $resource('/users', {format: 'json'},
      {
        'create': {method: 'POST'}
      }
    )

    $scope.login = ->
      Session.create({'user': $scope.user},
        ((user) ->
          $sessionStorage.user_email = user.email
          $sessionStorage.user_token = user.authentication_token
          $location.path('/'))
      )

    $scope.register = ->
      User.create({'user': $scope.user},
        ((user) ->
          $location.path('/'))
      )

])