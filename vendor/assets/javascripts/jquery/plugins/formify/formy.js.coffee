class @Formy
  # === Variables ===

  defaults:
    fieldsets:
      hide:
        effect: 'slideUp'
        duration: 150
    success:
      show:
        effect: 'fadeIn'
        duration: 150
    debug: false

  # === Public ===

  constructor: (form, options) ->
    @form    = $ form
    @options = $.extend @defaults, options

    @success       = @form.find '> .success'
    @failure       = @form.find '> .failure'
    @error         = @form.find '> .error'
    @errorMessages = @error.find '> .messages'
    @fieldsets     = @form.find '> fieldset'
    @elements      = @form.find '.element'
    @submit        = @form.find 'a.submit'

    @errorMessagesTemplate = window.HoganTemplates['jquery/plugins/formify/templates/error/messages']

    initialize.call @

    return

  isLocked: ->
    @form.hasClass 'locked'

  # === Events ===

  onSuccess: =>
    hideFieldsets.call @

    return

  beforeRequestSend: (xhr, settings) =>
    cleanup.call @

    lock.call @

    return

  onRequestDone: (data, status, xhr) =>
    do @onSuccess if status == 'success'

    return

  onRequestFail: (xhr, status, error) =>
    status = xhr.status

    switch status
      when 422
        response = xhr.responseJSON
        errors   = response.errors

        showErrors.call @, errors
      else
        showFailure.call @

    unlock.call @

    return

  onFormSubmit: (event) =>
    url = @form.data 'public-submission-url'

    if url
      request = $.ajax
        url: url
        type: 'POST'
        data: do @form.serialize
        dataType: 'json'
        beforeSend: @beforeRequestSend

      request.done @onRequestDone

      request.fail @onRequestFail

    false

  onSubmitClick: (event) =>
    submit = $ event.currentTarget

    do @form.submit if not do @isLocked

    false

  # === Private ===

  initialize = ->
    setupForm.call @

    setupSubmit.call @

    return

  setupForm = ->
    @form.validate
      submitHandler: @onFormSubmit
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

  hideFieldsets = ->
    @fieldsets.velocity @options.fieldsets.hide.effect,
      duration: @options.fieldsets.hide.duration
      complete: showSuccess.call @

    return

  showSuccess = ->
    @success.velocity @options.success.show.effect,
      duration: @options.success.show.duration

    return

  showErrors = (errors) ->
    if errors
      messages = translateErrors.call @, errors

      output = @errorMessagesTemplate.render messages

      @errorMessages.append output

      do @error.show

    return

  translateErrors = (errors) ->
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

  showFailure = ->
    do @failure.show

    return

  lock = ->
    disabledElements.call @

    @form.addClass 'locked'

    return

  unlock = ->
    enabledElements.call @

    @form.removeClass 'locked'

    return

  enabledElements = ->
    @elements.prop 'disabled', false

    return

  disabledElements = ->
    @elements.prop 'disabled', true

    return

  cleanup = ->
    do @success.hide

    do @failure.hide

    do @errorMessages.empty

    do @error.hide

    return