class @Slidy
  # === Variables ===

  defaults:
    slick:
      autoplaySpeed: 1000
      speed: 500
    debug: false

  # === Public ===

  constructor: (slider, options) ->
    @slider  = $ slider
    @options = $.extend @defaults, options

    initialize.call @

    return

  # === Events ===

  onInitialize: (slick) ->
    slider   = slick.$slider
    abstract = slider.closest '.abstract'
    shady    = abstract.find '> .shady'

    # May I have your attention please? Will the real Shady please stand up?
    shady.shadify {
      inactive: true
    } if do shady.present

    return

  # === Private ===

  initialize = ->
    setup.call @

    return

  setup = ->
    @slider.slick
      arrows: false
      autoplay: true
      autoplaySpeed: @options.slick.autoplaySpeed
      centerMode: true
      centerPadding: '0px'
      dots: true
      slide: '.slide'
      slidesToScroll: 1
      slidesToShow: 1
      speed: @options.slick.speed
      onInit: @onInitialize

    return