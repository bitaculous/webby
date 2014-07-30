class @Badge
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (badge, options) ->
    @badge   = $ badge
    @options = $.extend @defaults, options

    @icon = @badge.find '> .icon'

    return

  animate: ->
    @icon
    .velocity
      rotateZ: '-360deg'
    ,
      duration: 1000
      easing: 'easeInOutBack'
    .velocity
      rotateZ: '360deg'
    ,
      duration: 1000
      easing: 'easeInOutBack'

    return