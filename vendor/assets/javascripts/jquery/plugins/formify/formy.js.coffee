class @Formy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (form, options) ->
    @form    = $ form
    console.log @form
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Private ===

  initialize = ->
    alert 'Hello, from Formy.'

    return