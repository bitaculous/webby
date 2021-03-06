class @Badge
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (badge, scrolly, options) ->
    @badge   = $ badge
    @scrolly = scrolly
    @options = $.extend @defaults, options

    @logo = @badge.find '> .logo'

    return

  animate: ->
    @logo
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