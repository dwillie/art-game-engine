angular.module "app.play", []

.config ($stateProvider) ->

  $stateProvider.state "play#index",
    url: "/play"
    templateUrl: "modules/play/index.html"
    controller: "PlayIndexCtrl"
    data:
      requiresSignIn: yes

.constant "mockLocations",
  [
    {
      name: "?",
      description: "You are standing at the edge of an enormous, multiple kilometer drop, followed by a seemingly infinite expanse of flat stone to the north. A grassy plain stretches out behind you, thick tussocks of long grass waving in the wind. There is nothing of note visible for miles in any direction."
      exits: [
        { action: "move", parameter: "north", target: 0 }
        { action: "move", parameter: "south", target: 1 }
        { action: "move", parameter: "east",  target: 0 }
        { action: "move", parameter: "west",  target: 0 }
      ]
    },
    {
      name: "The Wild Plain",
      description: "Grass stretches out around you in every direction. To the north, the horizon appears closer. To the south, east and west, the field seems to stretch infinitely. Mountains decorate the eastern horizon."
      exits: [
        { action: "move", parameter: "north", target: 0 }
        { action: "move", parameter: "south", target: 1 }
        { action: "move", parameter: "east",  target: 1 }
        { action: "move", parameter: "west",  target: 1 }
      ],
      items: [
        { name: "stone", acquirable: true }
      ],
      backgroundColor: "#44A844"
    }
  ]

.controller "PlayIndexCtrl", ($scope, $timeout, mockLocations) ->
  $scope.playerInput    = ""
  $scope.messageHistory = []

  $scope.player = {
    currentLocation: 0
    inventory: []
  }

  $scope.currentLocation = ->
    mockLocations[$scope.player.currentLocation]

  addMessage = (klass, heading, body, items = []) ->
    $scope.messageHistory.push { class: klass, heading: heading, body: body, items: items }

  addResponse = (message) ->
    $scope.messageHistory.push { class: "response", body: message }

  addCurrentLocationMessage = ->
    loc = $scope.currentLocation()
    addMessage("location", loc.name, loc.description, loc.items)

  addCurrentLocationMessage()

  movePlayer = (args) ->
    actionable = _.select($scope.currentLocation().exits, (e) -> e.action == "move" )
    exit       = _.select(actionable, (e) -> e.parameter == args[1])
    if exit.length > 0
      $scope.player.currentLocation = exit[0].target
      addResponse "You make your way #{args[1]}."
      addCurrentLocationMessage()

  pickupItem = (args) ->
    itemName = args[1]
    itemIndex =  _.findIndex($scope.currentLocation().items, (i) -> i.name == itemName)
    if itemIndex >= 0
      $scope.currentLocation().items.splice(itemIndex, 1)
      $scope.player.inventory.push itemName
      addResponse "You pick up the #{itemName}"
      addCurrentLocationMessage()

  $scope.executeCommand = ->
    args = $scope.playerInput.toLowerCase().split(" ")

    switch args[0]
      when "walk", "run", "move", "proceed", "go"
        movePlayer(args)
      when "pickup", "take", "pick"
        pickupItem(args)

    $scope.playerInput = ""
