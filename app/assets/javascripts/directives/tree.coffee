directives = angular.module('directives')

directives.directive('tree', ->
  {
    restrict: 'E'
    replace: true
    scope: tree: '='
    templateUrl: 'tree/navbar-ul.html'
  }
).directive 'leaf', ($compile) ->
  {
    restrict: 'E'
    replace: true
    scope: leaf: '='
    templateUrl: 'tree/navbar-li.html'
    link: (scope, element, attrs) ->
      if angular.isArray(scope.leaf.subtree)
        element.append '<tree tree="leaf.subtree"></tree>'
        parent = element.parent()
        classFound = false
        while parent.length > 0 and !classFound
          if parent.hasClass('navbar-right')
            classFound = true
          parent = parent.parent()
        if classFound
          element.addClass 'dropdown-submenu-right'
        else
          element.addClass 'dropdown-submenu'
        $compile(element.contents()) scope
      return

  }
angular.module('tree/navbar-li.html', []).run [
  '$templateCache'
  ($templateCache) ->
    $templateCache.put 'tree/navbar-li.html', '<li ng-class="{divider: leaf.name == \'divider\'}">\n' + '    <a ui-sref="{{leaf.link}}" ng-if="leaf.name !== \'divider\'">{{leaf.name}}</a>\n' + '</li>'
    return
]
angular.module('tree/navbar-ul.html', []).run [
  '$templateCache'
  ($templateCache) ->
    $templateCache.put 'tree/navbar-ul.html', '<ul class=\'dropdown-menu\'>\n' + '    <leaf ng-repeat=\'leaf in tree\' leaf=\'leaf\'></leaf>\n' + '</ul>'
    return
]