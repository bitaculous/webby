#= require ./roof/badge
#= require ./roof/outline

#= require_self

class @Roof
  # === Variables ===

  badge: null

  outline: null

  defaults:
    breakPoints:
      minimize: 40
    debug: false

  # === Public ===

  constructor: (roof, scrolly, options) ->
    @roof    = $ roof
    @scrolly = scrolly
    @options = $.extend @defaults, options

    @window = $ window

    initialize.call @

    return

  update: ->
    scrollTop = do @window.scrollTop

    if scrollTop > @options.breakPoints.minimize
      do @minimize
    else
      do @expand

    return

  minimize: ->
    @roof.addClass 'slim'

    return

  expand: ->
    @roof.removeClass 'slim'

    return

  # === Private ===

  initialize = ->
    setupBadge.call @

    setupOutline.call @

    return

  setupBadge = ->
    badge = @roof.find '.badge'

    @badge = new Badge badge, @scrolly, @options.badge

    return

  setupOutline = ->
    outline = @roof.find 'nav.outline'

    @outline = new Outline outline, @scrolly, @options.outline

    return