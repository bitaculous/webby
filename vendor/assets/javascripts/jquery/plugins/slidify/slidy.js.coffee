class @Slidy
  # === Variables ===

  defaults:
    speed: 500
    autoplay:
      enabled: true
      speed: 7500
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
      autoplay: @options.autoplay.enabled
      autoplaySpeed: @options.autoplay.speed
      centerMode: true
      centerPadding: '0px'
      dots: true
      slide: '.slide'
      slidesToScroll: 1
      slidesToShow: 1
      speed: @options.speed
      onInit: @onInitialize

    return