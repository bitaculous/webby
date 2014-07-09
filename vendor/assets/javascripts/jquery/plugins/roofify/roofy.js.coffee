class @Roofy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (roof, options) ->
    @roof    = $ roof
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Private ===

  initialize = ->
    alert 'Hello, from Roofy.'

    return