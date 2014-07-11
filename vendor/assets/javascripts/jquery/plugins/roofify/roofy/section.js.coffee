class @Section
  # === Variables ===

  state: 'inactive'

  defaults:
    debug: false

  # === Public ===

  constructor: (element, dashboard, options) ->
    @element   = $ element
    @dashboard = $ dashboard
    @options   = $.extend @defaults, options

    @id = @element.data 'id'

    controlPanel = @dashboard.find '.control-panel'

    @pointer = controlPanel.find "a.control[data-id='#{@id}']"

    @close = @element.find 'a.close'

    initialize.call @

    return

  isActive: ->
    @state == 'active'

  isInactive: ->
    @state == 'inactive'

  isLocked: ->
    @state == 'locked'

  controls: ->
    [@pointer, @close]

  toogle: ->
    switch @state
      when 'active'
        do @deactivate
      when 'inactive'
        do @activate

    return

  activate: ->
    inactive = do @isInactive

    if inactive
      @element.velocity 'slideDown', {
        easing: @options.slideDown.easing
        duration: @options.slideDown.duration
        delay: @options.slideDown.delay
        before: @beforeActivate
        complete: @onActivate
      }

    return

  deactivate: ->
    active = do @isActive

    if active
      @element.velocity 'slideUp', {
        easing: @options.slideDown.easing
        duration: @options.slideDown.duration
        delay: @options.slideDown.delay
        before: @beforeDeactivate
        complete: @onDeactivate
      }

    return

  lockControl: (control) ->
    if control
      locked = control.hasClass 'locked'

      if not locked
        control.addClass 'locked'

    return

  unlockControl: (control) ->
    if control
      locked = control.hasClass 'locked'

      if locked
        control.removeClass 'locked'

    return

  # === Events ===

  beforeActivate: (section) =>
    @state = 'locked'

    return

  onActivate: (section) =>
    @state = 'active'

    return

  beforeDeactivate: (section) =>
    @state = 'locked'

    return

  onDeactivate: (section) =>
    @state = 'inactive'

    return

  onControlClick: (event) =>
    control = $ event.currentTarget

    do @toogle

    false

  # === Private ===

  initialize = ->
    setupPointer.call @

    setupClose.call @

    return

  setupPointer = ->
    @pointer.on 'click', @onControlClick

    return

  setupClose = ->
    @close.on 'click', @onControlClick

    return