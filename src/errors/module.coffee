angular.module "app.errors", []

.config ($stateProvider) ->

  $stateProvider.state "errors",
    abstract: yes
    url: "/errors"
    template: "<ui-view/>" # Abstract state requires a template.

  .state "errors.not-found",
    url: "/not-found"
    templateUrl: "errors/not-found.html"
    data:
      requiresSignIn: no
