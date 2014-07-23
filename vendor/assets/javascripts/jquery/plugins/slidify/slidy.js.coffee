class @Slidy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (slider, options) ->
    @slider  = $ slider
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Private ===

  initialize = ->
    alert 'Hello, from Slidy!'

    return