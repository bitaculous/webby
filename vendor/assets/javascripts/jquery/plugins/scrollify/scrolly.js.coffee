class @Scrolly
  # === Variables ===

  defaults:
    offsets:
      roof: -1
    debug: false

  # === Public ===

  constructor: (theatre, options) ->
    @theatre = $ theatre
    @roof    = @theatre.find '.roof'
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Events ===

  onRoofReached: (roof, direction) =>
    if direction is 'down'
      roof.addClass 'slim'
    else
      roof.removeClass 'slim'

    return

  # === Private ===

  initialize = ->
    setupWaypoints.call @

    return

  setupWaypoints = ->
    @roof.waypoint
      handler: (direction) =>
        @onRoofReached @roof, direction
      offset: @options.offsets.roof

    return