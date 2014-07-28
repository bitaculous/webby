class @Referencesies
  # === Variables ===

  defaults:
    speed: 500
    autoplaySpeed: 7500
    reference:
      activate:
        mobileView:
          effect: 'fadeIn'
          duration: 500
      deactivate:
        mobileView:
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

    responsive = reference.hasClass 'responsive'

    if responsive
      mobileView = reference.find '.mobile.view'

      mobileView.velocity @options.reference.activate.mobileView.effect, {
        duration: @options.reference.activate.mobileView.duration
      } if do mobileView.present

    return

  deactivateReference: (reference, slick) ->
    reference = $ reference

    responsive = reference.hasClass 'responsive'

    if responsive
      mobileView = reference.find '.mobile.view'

      mobileView.velocity @options.reference.deactivate.mobileView.effect, {
        duration: @options.reference.deactivate.mobileView.duration
      } if do mobileView.present

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
      autoplay: false
      autoplaySpeed: @options.autoplaySpeed
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