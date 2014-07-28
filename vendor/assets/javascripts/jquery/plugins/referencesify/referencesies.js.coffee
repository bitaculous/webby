class @Referencesies
  # === Variables ===

  defaults:
    autoplaySpeed: 7500
    speed: 500
    debug: false

  # === Public ===

  constructor: (references, options) ->
    @references = $ references
    @options    = $.extend @defaults, options

    initialize.call @

    return

  activateReference: (reference) ->
    reference = $ reference

    responsive = reference.hasClass 'responsive'

    if responsive
      mobileView = reference.find '.mobile.view'

      mobileView.velocity 'fadeIn', {
        duration: 750
      } if do mobileView.present

    return

  deactivateReference: (reference) ->
    reference = $ reference

    responsive = reference.hasClass 'responsive'

    if responsive
      mobileView = reference.find '.mobile.view'

      mobileView.velocity 'fadeOut', {
        duration: 150
      } if do mobileView.present

    return

  # === Events ===

  onInitialize: (slick) =>
    references       = slick.$slides
    currentReference = $ references[0]

    @activateReference currentReference

    return

  onBeforeChange: (slick, index, next) =>
    references       = slick.$slides
    currentReference = $ references[index]

    @deactivateReference currentReference

    return

  onAfterChange: (slick, index) =>
    references       = slick.$slides
    currentReference = $ references[index]

    @activateReference currentReference

    return

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

    return