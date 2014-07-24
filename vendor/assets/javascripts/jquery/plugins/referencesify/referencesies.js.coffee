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

  # === Private ===

  initialize = ->
    setup.call @

    return

  setup = ->
    @references.slick
      autoplay: false
      autoplaySpeed: @options.autoplaySpeed
      centerMode: true
      centerPadding: '0px'
      dots: false
      slide: '.reference'
      slidesToScroll: 1
      slidesToShow: 1
      speed: @options.speed

    return