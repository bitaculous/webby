class @Scrolly
  # === Variables ===

  defaults:
    offsets:
      sections: 0
    debug: false

  # === Public ===

  constructor: (theatre, options) ->
    @theatre = $ theatre
    @roof    = @theatre.find '.roof'
    @stage   = @theatre.find '.stage'
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Events ===

  onWindowScroll: (event) =>
    window = $ event.target

    scrollTop = do window.scrollTop

    if scrollTop > 0
      minimizeRoof.call @
    else
      expandRoof.call @

    return

  onSectionReached: (section, direction) =>
    return

  # === Private ===

  initialize = ->
    setupWindow.call @

    setupWaypoints.call @

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
            @onSectionReached section, direction
          offset: @options.offsets.sections

        return

    return

  minimizeRoof = ->
    @roof.addClass 'slim'

    return

  expandRoof = ->
    @roof.removeClass 'slim'

    return