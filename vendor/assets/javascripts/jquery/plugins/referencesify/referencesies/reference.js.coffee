class @Reference
  # === Variables ===

  defaults:
    activate:
      views:
        mobile:
          breakpoint: 480
          effect: 'fadeIn'
          duration: 500
      caption:
        effect: 'fadeIn'
        duration: 500
    deactivate:
      views:
        mobile:
          breakpoint: 480
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

    @body = $ 'body'

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
      bodyWidth = do @body.width
      visible   = @mobileView.css('opacity') > 0

      if bodyWidth < @options.activate.views.mobile.breakpoint or not visible
        @mobileView.velocity @options.activate.views.mobile.effect,
          duration: @options.activate.views.mobile.duration

    return

  activateCaption = ->
    @caption.velocity @options.activate.caption.effect,
      duration: @options.activate.caption.duration

    return

  deactivateViews = ->
    if @responsive
      bodyWidth = do @body.width
      visible   = @mobileView.css('opacity') > 0

      if bodyWidth < @options.deactivate.views.mobile.breakpoint and visible
        @mobileView.velocity @options.deactivate.views.mobile.effect,
          duration: @options.deactivate.views.mobile.duration

    return

  deactivateCaption = ->
    @caption.velocity @options.deactivate.caption.effect,
      duration: @options.deactivate.caption.duration

    return