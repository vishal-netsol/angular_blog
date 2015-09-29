directives = angular.module('directives')
directives.directive 'student', ->
  directive = {}
  directive.restrict = 'E'
  directive.template = 'Student: <b>{{student.name}}</b>, Roll No: <b>{{student.rollno}}</b>'
  directive.scope = student: '=name'

  directive.compile= (element, attributes) ->
    element.css 'border', '1px solid #cccccc'

  directive