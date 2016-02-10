angular.module "app", [
  "ngCookies"
  "ui.router"
  "templates"
  "app.environment"
  "app.errors"
  "app.play"
  "app.enter"
  "luegg.directives"
]

.config ($urlRouterProvider) ->

  # Map the root URL to a default state.
  $urlRouterProvider.when("", "/").when "/", -> "/play"

  # Catch bad URLs.
  $urlRouterProvider.otherwise "/errors/not-found"

.run ($rootScope, $state, apiUrl) -> return

.controller "AppCtrl", ($rootScope) -> return
