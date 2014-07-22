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

  constructor: (section, dashboard, options) ->
    @section   = $ section
    @dashboard = $ dashboard
    @options   = $.extend @defaults, options

    @id = @section.data 'id'

    controlPanel = @dashboard.find '.control-panel'

    @pointer = controlPanel.find "> a.control[data-id='#{@id}']"

    @close = @section.find 'a.close'

    initialize.call @

    return

  update: ->
    states = do @states
    states = states.join ' '

    @section.removeClass states

    @section.addClass @state

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
      @section.velocity @options.activate.effect,
        easing: @options.activate.easing
        duration: @options.activate.duration
        delay: @options.activate.delay
        begin: @beforeActivate
        complete: @onActivate

    return

  deactivate: ->
    active = do @isActive

    if active
      @section.velocity @options.deactivate.effect,
        easing: @options.deactivate.easing
        duration: @options.deactivate.duration
        delay: @options.deactivate.delay
        begin: @beforeDeactivate
        complete: @onDeactivate

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