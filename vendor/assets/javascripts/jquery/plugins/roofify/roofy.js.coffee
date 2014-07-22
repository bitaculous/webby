#= require ./roofy/section

class @Roofy
  # === Variables ===

  sections: []

  defaults:
    section:
      activate:
        effect: 'slideDown'
        duration: 750
        delay: 150
        easing: 'easeOut'
      deactivate:
        effect: 'slideUp'
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
    @dashboard    = @roof.find '> .dashboard'
    @controlPanel = @dashboard.find '.control-panel'

    sections = @backstage.find '> section'

    sections.each (index, section) =>
      @sections += new Section section, @dashboard, @options.section

      return

    controlPanelHeight = do @controlPanel.height

    @altitude = controlPanelHeight + @options.altitude.spacing

    initialize.call @

    return

  # === Events ===

  onWindowResize: (event) =>
    setupBackstage.call @

    return

  # === Private ===

  initialize = ->
    setupWindow.call @

    setupBackstage.call @

    return

  setupWindow = ->
    $(window).on 'resize', @onWindowResize

    return

  setupBackstage = ->
    height = do @body.height

    @backstage.css
      'max-height': height - @altitude

    return