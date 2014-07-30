#= require ./roof/badge

#= require_self

class @Roof
  # === Variables ===

  badge: null

  defaults:
    breakPoints:
      minimize: 40
    debug: false

  # === Public ===

  constructor: (roof, options) ->
    @roof    = $ roof
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

    return

  setupBadge = ->
    badge = @roof.find '.badge'

    @badge = new Badge badge

    return