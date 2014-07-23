class @Scrolly
  # === Variables ===

  defaults:
    offsets:
      sections: 0
    debug: false

  # === Public ===

  constructor: (theatre, options) ->
    @theatre = $ theatre
    @options = $.extend @defaults, options

    @window = $ window
    @roof   = @theatre.find '> .roof'
    @stage  = @theatre.find '> .stage'

    initialize.call @

    return

  updateRoof: ->
    scrollTop = do @window.scrollTop

    if scrollTop > 0
      minimizeRoof.call @
    else
      expandRoof.call @

    return

  # === Events ===

  onWindowScroll: (event) =>
    do @updateRoof

    return

  onSectionEnter: (section, direction) =>
    return

  # === Private ===

  initialize = ->
    setupWindow.call @

    setupWaypoints.call @

    do @updateRoof

    return

  setupWindow = ->
    $(window).on 'scroll', @onWindowScroll

    return

  setupWaypoints = ->
    if do @stage.present
      sections = @stage.find '> section'

      sections.each (index, section) =>
        section = $ section

        section.waypoint
          handler: (direction) =>
            @onSectionEnter section, direction
          offset: @options.offsets.sections

        return

    return

  minimizeRoof = ->
    @roof.addClass 'slim'

    return

  expandRoof = ->
    @roof.removeClass 'slim'

    return