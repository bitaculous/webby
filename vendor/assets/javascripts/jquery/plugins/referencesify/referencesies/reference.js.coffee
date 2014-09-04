class @Reference
  # === Variables ===

  defaults:
    activate:
      views:
        mobile:
          effect: 'fadeIn'
          duration: 500
      caption:
        effect: 'fadeIn'
        duration: 500
    deactivate:
      views:
        mobile:
          effect: 'fadeOut'
          duration: 250
      caption:
        effect: 'fadeOut'
        duration: 250
    debug: false

  # === Public ===

  constructor: (reference, options) ->
    @reference = $ reference
    @options   = $.extend @defaults, options

    @responsive = @reference.hasClass 'responsive'
    @interior   = @reference.find '> .interior'
    @touchZone  = @interior.find '.touch-zone'
    @views      = @interior.find '> .views'
    @mobileView = @views.find '.mobile.view'
    @caption    = @interior.find '> .caption'
    @label      = @caption.find '> .label'

    initialize.call @

    return

  activate: ->
    activateViews.call @

    activateCaption.call @

    return

  deactivate: ->
    deactivateViews.call @

    deactivateCaption.call @

    return

  # === Events ===

  onTouchZoneClick: (event) =>
    touchZone = $ event.target

    reference = touchZone.closest '.reference'

    url = reference.data 'url'

    window.open url, '_blank' if url?

    false

  # === Private ===

  initialize = ->
    setup.call @

    return

  setup = ->
    @touchZone.on 'click', @onTouchZoneClick

    return

  activateViews = ->
    if @responsive
      @mobileView.velocity @options.activate.views.mobile.effect,
        duration: @options.activate.views.mobile.duration

    return

  activateCaption = ->
    @caption.velocity @options.activate.caption.effect,
      duration: @options.activate.caption.duration

    return

  deactivateViews = ->
    if @responsive
      @mobileView.velocity @options.deactivate.views.mobile.effect,
        duration: @options.deactivate.views.mobile.duration

    return

  deactivateCaption = ->
    @caption.velocity @options.deactivate.caption.effect,
      duration: @options.deactivate.caption.duration

    return