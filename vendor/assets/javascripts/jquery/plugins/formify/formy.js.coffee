class @Formy
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (form, options) ->
    @form    = $ form
    @options = $.extend @defaults, options

    @success       = @form.find '> .success'
    @failure       = @form.find '> .failure'
    @error         = @form.find '> .error'
    @errorMessages = @error.find '> .messages'
    @submit        = @form.find 'a.submit'

    @errorMessagesTemplate = window.HoganTemplates['jquery/plugins/formify/templates/error/messages']

    initialize.call @

    return

  showSuccess: ->
    do @success.show

    return

  showErrors: (errors) ->
    if errors
      messages = @translateErrors errors

      output = @errorMessagesTemplate.render messages

      @errorMessages.append output

      do @error.show

    return

  translateErrors: (errors) ->
    result   = {}
    messages = []

    $.each errors, (key, message) ->
      messages.push {
        key: $.i18n._ key
        message: $.i18n._ message
      }

      return

    result.messages = messages

    result

  lock: ->
    @form.addClass 'locked'

    return

  unlock: ->
    @form.removeClass 'locked'

    return

  cleanup: ->
    do @success.hide

    do @failure.hide

    do @errorMessages.empty

    do @error.hide

    return

  # === Events ===

  beforeSubmit: (data, form, options) =>
    do @cleanup

    do @lock

    true

  onSuccess: (response, status, xhr, form) =>
    errors = response.errors

    if errors
      @showErrors errors
    else
      do @showSuccess

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