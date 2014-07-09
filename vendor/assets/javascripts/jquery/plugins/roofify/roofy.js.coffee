class @Roofy
  # === Variables ===

  defaults:
    slideDown:
      easing: 'easeOut'
      duration: 500
      delay: 150
    slideUp:
      duration: 1000
      delay: 150
    altitude:
      spacing: 10
    debug: false

  # === Public ===

  constructor: (roof, options) ->
    @roof    = $ roof
    @options = $.extend @defaults, options

    @body         = $ 'body'
    @backstage    = @roof.find '.backstage'
    @sections     = @backstage.find 'section'
    @dashboard    = @roof.find '.dashboard'
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
        }

    return

  deactivateSection: (section) ->
    if section
      isActive = section.hasClass 'active'

      if isActive
        section.velocity 'slideUp', {
          duration: @options.slideUp.duration
          delay: @options.slideUp.delay
        }

    return

  findSectionByName: (name) ->
    @backstage.find "section.#{name}"

  # === Events ===

  onWindowResize: (event) =>
    setupBackstage.call @

    return

  onControlClick: (event) =>
    control  = $ event.currentTarget
    isActive = control.hasClass 'active'

    if isActive
      label = control.data 'label'
      title = control.data 'title'

      control.removeClass 'active'
    else
      target = control.data 'target'
      label  = control.data 'active-label'
      title  = control.data 'active-title'

      section = @findSectionByName target

      @activateSection section

      control.addClass 'active'

    control.html label
    control.attr 'title', title

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