class @Formy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (form, options) ->
    @form    = $ form
    @options = $.extend @defaults, options

    @locale = window.locale || 'en'

    @success = @form.find '.success'
    @failure = @form.find '.failure'
    @error   = @form.find '.error'
    @submit  = @form.find 'a.submit'

    initialize.call @

    return

  showErrors: (errors) ->
    explanation = @error.find '> .explanation'

    do @error.show

    return

  lock: ->
    @form.addClass 'locked'

    return

  unlock: ->
    @form.removeClass 'locked'

    return

  cleanup: ->
    do @success.hide

    do @failure.hide

    do @error.hide

    return

  # === Events ===

  beforeSubmit: (data, form, options) =>
    do @cleanup

    do @lock

    true

  onSuccess: (response, status, xhr, form) =>
    errors = response.errors

    @showErrors errors if errors

    do @unlock

    return

  onError: (xhr, status, error) =>
    do @failure.show

    return

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

    publicSubmissionUrl = @form.data 'public-submission-url'

    if publicSubmissionUrl
      @form.ajaxForm
        url: publicSubmissionUrl
        iframe: true
        dataType: 'json'
        beforeSubmit: @beforeSubmit
        success: @onSuccess
        error: @onError

    return

  setupSubmit = ->
    @submit.on 'click', @onSubmitClick

    return