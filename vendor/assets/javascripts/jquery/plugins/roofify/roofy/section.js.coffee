class @Section
  # === Constants ==

  @STATES: [
    'active'
    'inactive'
    'locked'
  ]

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

  update: ->
    states = do @states
    states = states.join ' '

    @element.removeClass states

    @element.addClass @state

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
        begin: @beforeActivate
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
        begin: @beforeDeactivate
        complete: @onDeactivate
      }

    return

  lockControls: ->
    controls = do @controls

    $.each controls, (index, control) =>
      @lockControl control

      return

  lockControl: (control) ->
    if control
      locked = control.hasClass 'locked'

      if not locked
        control.addClass 'locked'

    return

  unlockControls: ->
    controls = do @controls

    $.each controls, (index, control) =>
      @unlockControl control

      return

  unlockControl: (control) ->
    if control
      locked = control.hasClass 'locked'

      if locked
        control.removeClass 'locked'

    return

  states: ->
    Section.STATES

  isActive: ->
    @state == 'active'

  isInactive: ->
    @state == 'inactive'

  isLocked: ->
    @state == 'locked'

  controls: ->
    [@pointer, @close]

  # === Events ===

  beforeActivate: (section) =>
    do @lockControls

    @state = 'locked'

    do @update

    return

  onActivate: (section) =>
    do @unlockControls

    @state = 'active'

    do @update

    return

  beforeDeactivate: (section) =>
    do @lockControls

    @state = 'locked'

    do @update

    return

  onDeactivate: (section) =>
    do @unlockControls

    @state = 'inactive'

    do @update

    return

  onControlClick: (event) =>
    control = $ event.currentTarget

    do @toogle

    false

  # === Private ===

  initialize = ->
    do @update

    setupPointer.call @

    setupClose.call @

    return

  setupPointer = ->
    @pointer.on 'click', @onControlClick

    return

  setupClose = ->
    @close.on 'click', @onControlClick

    return