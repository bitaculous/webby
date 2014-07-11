class @Formy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (form, options) ->
    @form    = $ form
    @options = $.extend @defaults, options

    @submit = @form.find 'a.submit'

    initialize.call @

    return

  # === Events ===

  onSubmitClick: (event) =>
    submit = $ event.currentTarget

    do @form.submit

    false

  # === Private ===

  initialize = ->
    setupSubmit.call @

    return

  setupSubmit = ->
    @submit.on 'click', @onSubmitClick

    return