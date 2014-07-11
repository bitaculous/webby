class @Formy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (form, options) ->
    @form    = $ form
    @options = $.extend @defaults, options

    @submit = @form.find 'a.submit'

    @locale = window.locale || 'en'

    initialize.call @

    return

  # === Events ===

  onSubmitClick: (event) =>
    submit = $ event.currentTarget

    do @form.submit

    false

  # === Private ===

  initialize = ->
    setupForm.call @

    setupSubmit.call @

    return

  setupForm = ->
    @form.validate
      lang: @locale
      errorClass: 'error'
      errorElement: 'label'
      errorPlacement: (error, element) ->
        parent = do element.parent

        error.appendTo parent

        return

    return

  setupSubmit = ->
    @submit.on 'click', @onSubmitClick

    return