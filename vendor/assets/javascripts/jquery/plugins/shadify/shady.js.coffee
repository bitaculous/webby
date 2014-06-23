class @Shady
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (canvas, options) ->
    @canvas  = $ canvas
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Private ===

  initialize = ->
    alert 'Hello, from shady.'

    return