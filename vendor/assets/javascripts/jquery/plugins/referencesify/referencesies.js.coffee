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

  # === Events ===

  onInitialize: (slick, foo) =>
    references       = slick.$slides
    currentReference = $ references[0]

    isResponsive = currentReference.hasClass 'responsive'

    if isResponsive
      mobileView = currentReference.find '.mobile.view'

      mobileView.velocity 'fadeIn', {
        duration: 1000
      } if do mobileView.present

    return

  onBeforeChange: (slick, index, next) ->
    references       = slick.$slides
    currentReference = $ references[index]

    isResponsive = currentReference.hasClass 'responsive'

    if isResponsive
      mobileView = currentReference.find '.mobile.view'

      mobileView.velocity 'fadeOut', {
        duration: 500
      } if do mobileView.present

    return

  onAfterChange: (slick, index) ->
    references       = slick.$slides
    currentReference = $ references[index]

    isResponsive = currentReference.hasClass 'responsive'

    if isResponsive
      mobileView = currentReference.find '.mobile.view'

      mobileView.velocity 'fadeIn', {
        duration: 1000
      } if do mobileView.present

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