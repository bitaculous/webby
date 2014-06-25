class @Scrolly
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (theatre, options) ->
    @theatre = $ theatre
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Private ===

  initialize = ->
    alert 'Hello, from Scrolly!'

    return