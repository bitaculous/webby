#= require ./referencesies/reference

#= require_self

class @Referencesies
  # === Variables ===

  defaults:
    speed: 500
    autoplay:
      enabled: false
      speed: 7500
    debug: false

  # === Public ===

  constructor: (references, options) ->
    @references = $ references
    @options    = $.extend @defaults, options

    initialize.call @

    return

  # === Events ===

  onInitialize: (slick) =>
    references       = slick.$slides
    currentReference = $ references[0]

    instance = currentReference.data 'reference'

    do instance.activate if instance?

    @index = 0

    return

  onBeforeChange: (slick, index, next) =>
    references       = slick.$slides
    currentReference = $ references[index]

    instance = currentReference.data 'reference'

    do instance.deactivate if instance?

    return

  onAfterChange: (slick, index) =>
    if index isnt @index
      references       = slick.$slides
      currentReference = $ references[index]

      instance = currentReference.data 'reference'

      do instance.activate if instance?

    @index = index

    return

  # === Private ===

  initialize = ->
    references = @references.find '.reference'

    references.each (index, reference) =>
      reference = $ reference

      reference.data 'reference', new Reference(reference, @options.reference)

      return

    setup.call @

    return

  setup = ->
    @references.slick
      autoplay: @options.autoplay.enabled
      autoplaySpeed: @options.autoplay.speed
      centerMode: true
      centerPadding: '0px'
      dots: false
      responsive: [
        {
          breakpoint: 1152
          settings:
            slidesToShow: 1
        }
      ]
      slide: '.reference'
      slidesToScroll: 1
      slidesToShow: 3
      speed: @options.speed
      onInit: @onInitialize
      onBeforeChange: @onBeforeChange
      onAfterChange: @onAfterChange

    return