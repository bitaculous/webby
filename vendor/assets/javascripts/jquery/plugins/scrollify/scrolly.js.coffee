class @Scrolly
  # === Variables ===

  defaults:
    breakPoints:
      minimizeRoof: 40
    offsets:
      top: -1
      sections: 0
    scrolling:
      duration: 1500
      easing: 'easeInOutBack'
    debug: false

  # === Public ===

  constructor: (theatre, options) ->
    @theatre = $ theatre
    @options = $.extend @defaults, options

    @top = $ @options.top

    @window    = $ window
    @roof      = @theatre.find '> .roof'
    @dashboard = @roof.find '> .dashboard'
    @badge     = @dashboard.find '.badge'
    @icon      = @badge.find '> .icon'
    @outline   = @dashboard.find '.outline'
    @stage     = @theatre.find '> .stage'
    @sections  = @stage.find '> section'

    initialize.call @

    return

  updateRoof: ->
    scrollTop = do @window.scrollTop

    if scrollTop > @options.breakPoints.minimizeRoof
      minimizeRoof.call @
    else
      expandRoof.call @

    return

  scrollFromOutlineLink: (link) ->
    link = $ link

    if link.attr 'data-target'
      target = link.data 'target'
      offset = link.data 'offset'

      if @scrollTo target, offset
        return false

    true

  scrollTo: (target, offset = 0) ->
    if @home
      target = $ target

      if do target.present
        target.velocity 'scroll',
          offset: offset
          duration: @options.scrolling.duration
          easing: @options.scrolling.easing

        return true

    false

  animateIcon: ->
    # @icon
    # .velocity
    #   rotateZ: '-360deg'
    # ,
    #   duration: 1000
    #   easing: 'easeInOutBack'
    # .velocity
    #   rotateZ: '360deg'
    # ,
    #   duration: 1000
    #   easing: 'easeInOutBack'

    return

  home: ->
    pathname = window.location.pathname

    if pathname is '/'
      true
    else
      false

  # === Events ===

  onWindowLoad: (event) =>
    setTimeout =>
      do @updateRoof
    , 1

    return

  onWindowScroll: (event) =>
    do @updateRoof

    return

  onTopEnter: (top, direction) =>
    do @animateIcon if direction is 'up'

    return

  onSectionEnter: (section, direction) =>
    return

  onOutlineLinkClick: (event) =>
    link = $ event.target

    @scrollFromOutlineLink link

    false

  # === Private ===

  initialize = ->
    setupWindow.call @

    setupOutline.call @

    setupWaypoints.call @

    return

  setupWindow = ->
    @window.on 'load', @onWindowLoad

    @window.on 'scroll', @onWindowScroll

    return

  setupOutline = ->
    links = @outline.find 'a'

    links.on 'click', @onOutlineLinkClick

    return

  setupWaypoints = ->
    @top.waypoint
      handler: (direction) =>
        @onTopEnter @top, direction
      offset: @options.offsets.top

    @sections.each (index, section) =>
      section = $ section
      offset  = section.data 'offset'

      section.waypoint
        handler: (direction) =>
          @onSectionEnter section, direction
        offset: offset || @options.offsets.sections

      return

    return

  minimizeRoof = ->
    @roof.addClass 'slim'

    return

  expandRoof = ->
    @roof.removeClass 'slim'

    return