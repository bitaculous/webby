#= require ./roofy/section

#= require_self

class @Roofy
  # === Variables ===

  sections: []

  defaults:
    altitude:
      spacing: 10
    debug: false

  # === Public ===

  constructor: (roof, options) ->
    @roof    = $ roof
    @options = $.extend @defaults, options

    @window = $ window

    @body = $ 'body'

    @backstage    = @roof.find '> .backstage'
    @dashboard    = @roof.find '> .dashboard'
    @controlPanel = @dashboard.find '.control-panel'

    sections = @backstage.find '> section'

    sections.each (index, section) =>
      @sections += new Section section, @, @options.section

      return

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
    @window.on 'resize', @onWindowResize

    return

  setupBackstage = ->
    height = do @body.height

    controlPanelHeight = do @controlPanel.height

    altitude = controlPanelHeight + @options.altitude.spacing

    @backstage.css
      'max-height': height - altitude

    return