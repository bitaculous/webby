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
    @elements      = @form.find '.element'
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
    do @disabledElements

    @form.addClass 'locked'

    return

  unlock: ->
    do @enabledElements

    @form.removeClass 'locked'

    return

  isLocked: ->
    @form.hasClass 'locked'

  enabledElements: ->
    @elements.prop 'disabled', false

    return

  disabledElements: ->
    @elements.prop 'disabled', true

    return

  cleanup: ->
    do @success.hide

    do @failure.hide

    do @errorMessages.empty

    do @error.hide

    return

  # === Events ===

  beforeRequestSend: (xhr, settings) =>
    do @cleanup

    do @lock

    return

  onRequestDone: (data, status, xhr) =>
    do @showSuccess if status == 'success'

    return

  onRequestFail: (xhr, status, error) =>
    status = xhr.status

    switch status
      when 422
        response = xhr.responseJSON
        errors   = response.errors

        @showErrors errors
      else
        do @failure.show

    do @unlock

    return

  onRequestComplete: (xhr, status) =>
    return

  onFormSubmit: (event) =>
    url  = @form.data 'public-submission-url'
    data = do @form.serialize

    if url
      request = $.ajax
        url: url
        type: 'POST'
        data: data
        dataType: 'json'
        beforeSend: @beforeRequestSend

      request.done @onRequestDone
      request.fail @onRequestFail
      request.always @onRequestComplete

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