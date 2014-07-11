class @Roofy
  # === Variables ===

  defaults:
    slideDown:
      easing: 'easeOut'
      duration: 750
      delay: 150
    slideUp:
      easing: 'easeIn'
      duration: 500
      delay: 150
    altitude:
      spacing: 10
    debug: false

  # === Public ===

  constructor: (roof, options) ->
    @roof    = $ roof
    @options = $.extend @defaults, options

    @body         = $ 'body'
    @backstage    = @roof.find '> .backstage'
    @sections     = @backstage.find '> section'
    @dashboard    = @roof.find '> .dashboard'
    @controlPanel = @dashboard.find '.control-panel'
    @controls     = @controlPanel.find 'a.control'

    controlPanelHeight = do @controlPanel.height

    @altitude = controlPanelHeight + @options.altitude.spacing

    initialize.call @

    return

  activateSection: (section) ->
    if section
      isActive = section.hasClass 'active'

      if not isActive
        section.velocity 'slideDown', {
          easing: @options.slideDown.easing
          duration: @options.slideDown.duration
          delay: @options.slideDown.delay
          before: @beforeSectionActivate
          complete: @onSectionActivate
        }

    return

  deactivateSection: (section) ->
    if section
      isActive = section.hasClass 'active'

      if isActive
        section.velocity 'slideUp', {
          easing: @options.slideDown.easing
          duration: @options.slideDown.duration
          delay: @options.slideDown.delay
          before: @beforeSectionDeactivate
          complete: @onSectionDeactivate
        }

    return

  activateControl: (control) ->
    if control
      isActive = control.hasClass 'active'

      if not isActive
        label = control.data 'active-label'
        title = control.data 'active-title'

        control.html label

        control.attr 'title', title

        control.addClass 'active'

    return

  deactivateControl: (control) ->
    if control
      isActive = control.hasClass 'active'

      if isActive
        label = control.data 'label'
        title = control.data 'title'

        control.html label

        control.attr 'title', title

        control.removeClass 'active'

    return

  findSectionById: (id) ->
    @backstage.find "section[data-id='#{id}']"

  findControlById: (id) ->
    @controlPanel.find "a.control[data-id='#{id}']"

  # === Events ===

  onWindowResize: (event) =>
    setupBackstage.call @

    return

  beforeSectionActivate: (section) =>
    section = $ section

    return

  onSectionActivate: (section) =>
    section = $ section
    id      = section.data 'id'

    control = @findControlById id

    @activateControl control

    section.addClass 'active'

    return

  beforeSectionDeactivate: (section) =>
    section = $ section

    return

  onSectionDeactivate: (section) =>
    section = $ section
    id      = section.data 'id'

    control = @findControlById id

    @deactivateControl control

    section.removeClass 'active'

    return

  onControlClick: (event) =>
    control  = $ event.currentTarget
    id       = control.data 'id'
    isActive = control.hasClass 'active'

    section = @findSectionById id

    if isActive
      @deactivateSection section
    else
      @activateSection section

    false

  onCloseClick: (event) =>
    close   = $ event.currentTarget
    section = close.closest 'section'

    @deactivateSection section

    false

  # === Private ===

  initialize = ->
    setupWindow.call @

    setupBackstage.call @

    setupSections.call @

    setupControls.call @

    return

  setupWindow = ->
    $(window).on 'resize', @onWindowResize

    return

  setupBackstage = ->
    height = do @body.height

    @backstage.css {
      'max-height': height - @altitude
    }

    return

  setupSections = ->
    @sections.each (index, section) =>
      section = $ section
      close   = section.find 'a.close'

      close.on 'click', @onCloseClick

    return

  setupControls = ->
    @controls.on 'click', @onControlClick

    return