angular.module "app.enter", []

.directive 'ngEnter', ->
  (scope, element, attrs) ->
    element.bind "keypress", (event) ->
      if (event.which == 13)
        scope.$apply(-> scope.$eval(attrs.ngEnter))
        event.preventDefault()
