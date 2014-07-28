class @Referencesies
  # === Variables ===

  defaults:
    speed: 500
    autoplay:
      enabled: false
      speed: 7500
    reference:
      activate:
        views:
          mobile:
            effect: 'fadeIn'
            duration: 500
        title:
          label:
            effect: 'fadeIn'
            duration: 750
      deactivate:
        views:
          mobile:
            effect: 'fadeOut'
            duration: 0
        title:
          label:
            effect: 'fadeOut'
            duration: 0
    debug: false

  # === Public ===

  constructor: (references, options) ->
    @references = $ references
    @options    = $.extend @defaults, options

    initialize.call @

    return

  activateReference: (reference, slick) ->
    reference = $ reference

    @activateViewsOfReference reference

    @activateTitleOfReference reference

    return

  activateViewsOfReference: (reference) ->
    reference = $ reference

    responsive = reference.hasClass 'responsive'

    if responsive
      mobileView = reference.find '.mobile.view'

      mobileView.velocity @options.reference.activate.views.mobile.effect, {
        duration: @options.reference.activate.views.mobile.duration
      } if do mobileView.present

    return

  activateTitleOfReference: (reference) ->
    reference = $ reference

    title = reference.find '> .title'
    label = title.find '> .label'

    label.velocity @options.reference.activate.title.label.effect, {
      duration: @options.reference.activate.title.label.duration
    }

    return

  deactivateReference: (reference, slick) ->
    reference = $ reference

    @deactivateViewsOfReference reference

    @deactivateTitleOfReference reference

    return

  deactivateViewsOfReference: (reference) ->
    reference = $ reference

    responsive = reference.hasClass 'responsive'

    if responsive
      mobileView = reference.find '.mobile.view'

      mobileView.velocity @options.reference.deactivate.views.mobile.effect, {
        duration: @options.reference.deactivate.views.mobile.duration
      } if do mobileView.present

    return

  deactivateTitleOfReference: (reference) ->
    reference = $ reference

    title = reference.find '> .title'
    label = title.find '> .label'

    label.velocity @options.reference.deactivate.title.label.effect, {
      duration: @options.reference.deactivate.title.label.duration
    }

    return

  # === Events ===

  onInitialize: (slick) =>
    references       = slick.$slides
    currentReference = $ references[0]

    @activateReference currentReference, slick

    @index = 0

    return

  onBeforeChange: (slick, index, next) =>
    references       = slick.$slides
    currentReference = $ references[index]

    @deactivateReference currentReference, slick

    return

  onAfterChange: (slick, index) =>
    references       = slick.$slides
    currentReference = $ references[index]

    @activateReference currentReference, slick if index isnt @index

    @index = index

    return

  onReferenceClick: (event) =>
    reference = $ event.target

    reference = reference.closest '.reference' if not reference.hasClass 'reference'

    url = reference.data 'url'

    window.open url, '_blank' if url

    false

  # === Private ===

  initialize = ->
    setup.call @

    return

  setup = ->
    @references.slick
      autoplay: @options.autoplay.enabled
      autoplaySpeed: @options.autoplay.speed
      centerMode: false
      dots: false
      slide: '.reference'
      slidesToScroll: 1
      slidesToShow: 1
      speed: @options.speed
      onInit: @onInitialize
      onBeforeChange: @onBeforeChange
      onAfterChange: @onAfterChange

    references = @references.find '.reference'

    references.on 'click', @onReferenceClick

    return