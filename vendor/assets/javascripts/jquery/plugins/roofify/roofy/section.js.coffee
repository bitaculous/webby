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
    if do @inactive
      @section.velocity @options.activate.effect,
        easing: @options.activate.easing
        delay: @options.activate.delay
        duration: @options.activate.duration
        begin: @beforeActivate
        complete: @onActivate

    return

  deactivate: ->
    if do @active
      @section.velocity @options.deactivate.effect,
        easing: @options.deactivate.easing
        delay: @options.deactivate.delay
        duration: @options.deactivate.duration
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

  updatePointer: ->
    if do @active
      label = @pointer.data 'active-label'
      title = @pointer.data 'active-title'

      @pointer.addClass 'active'
    else
      label = @pointer.data 'label'
      title = @pointer.data 'title'

      @pointer.removeClass 'active'

    @pointer.html label
    @pointer.attr 'title', title

    return

  states: ->
    Section.STATES

  active: ->
    @state == 'active'

  inactive: ->
    @state == 'inactive'

  locked: ->
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

    do @updatePointer

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

    do @updatePointer

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