class @Slidy
  # === Variables ===

  defaults:
    speed: 500
    autoplaySpeed: 7500
    shadify:
      inactive: true
    debug: false

  # === Public ===

  constructor: (slider, options) ->
    @slider  = $ slider
    @options = $.extend @defaults, options

    @shady = $ @options.shady

    initialize.call @

    return

  # === Events ===

  onInitialize: (slick) =>
    # May I have your attention please? Will the real Shady please stand up?
    @shady.shadify @options.shadify if do @shady.present

    return

  # === Private ===

  initialize = ->
    setup.call @

    return

  setup = ->
    @slider.slick
      arrows: false
      autoplay: true
      autoplaySpeed: @options.autoplaySpeed
      centerMode: true
      centerPadding: '0px'
      dots: true
      slide: '.slide'
      slidesToScroll: 1
      slidesToShow: 1
      speed: @options.speed
      onInit: @onInitialize

    return