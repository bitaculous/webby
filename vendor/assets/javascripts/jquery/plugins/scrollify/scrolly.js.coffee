#= require ./scrolly/roof

#= require_self

class @Scrolly
  # === Variables ===

  roof: null

  defaults:
    offsets:
      sections: -1
    scrolling:
      duration: 1500
      easing: 'easeInOutBack'
      exclude: [
        '#/home'
      ]
    debug: false

  # === Public ===

  constructor: (theatre, options) ->
    @theatre = $ theatre
    @options = $.extend @defaults, options

    @window = $ window
    @body   = $ 'body'

    @stage    = @theatre.find '> .stage'
    @sections = @stage.find '> section'

    initialize.call @

    return

  scrollTo: (target, offset = 0) ->
    if @index
      target = $ target

      if do target.present
        target.velocity 'scroll',
          offset: offset
          duration: @options.scrolling.duration
          easing: @options.scrolling.easing
          complete: @onScrollComplete

        return false

    true

  scrollByHash: (hash) ->
    if hash
      excluded = $.inArray(hash, @options.scrolling.exclude) > -1

      if not excluded
        data = @roof.outline.getScrollDataByHash hash

        @scrollTo data.target, data.offset

    return

  activateSection: (section) ->
    section = $ section
    id      = section.data 'id'
    alias   = section.data 'alias'

    @roof.outline.activateItemById alias || id

    return

  updateLocationHash: (section) ->
    section = $ section
    id      = section.data 'id'
    alias   = section.data 'alias'

    window.location.hash = "/#{alias || id}"

    return

  index: ->
    if @body.attr 'id' is 'index'
      true
    else
      false

  # === Events ===

  onWindowLoad: (event) =>
    setTimeout =>
      @scrollByHash window.location.hash

      do @roof.update
    , 1

    return

  onWindowScroll: (event) =>
    do @roof.update

    return

  onSectionEnter: (section, direction) =>
    section = $ section

    @activateSection section

    return

  onScrollComplete: (section) =>
    section = $ section

    @updateLocationHash section

    return

  # === Private ===

  initialize = ->
    setupWindow.call @

    setupRoof.call @

    setupWaypoints.call @

    return

  setupWindow = ->
    @window.on 'load', @onWindowLoad

    @window.on 'scroll', @onWindowScroll

    return

  setupRoof = ->
    roof = @theatre.find '> .roof'

    @roof = new Roof roof, @, @options.roof

    return

  setupWaypoints = ->
    @sections.each (index, section) =>
      section = $ section
      offset  = section.data 'offset'

      section.waypoint
        handler: (direction) =>
          @onSectionEnter section, direction
        offset: offset || @options.offsets.sections

      return

    return