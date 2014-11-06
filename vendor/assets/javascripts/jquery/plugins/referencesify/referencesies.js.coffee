#= require ./referencesies/reference

#= require_self

class @Referencesies
  # === Variables ===

  defaults:
    speed: 1000
    autoplay:
      enabled: false
      speed: 7500
    activate:
      browse:
        previous:
          effect: 'transition.slideRightIn'
          duration: 500
        next:
          effect: 'transition.slideLeftIn'
          duration: 500
    deactivate:
      browse:
        previous:
          effect: 'transition.fadeOut'
          duration: 250
        next:
          effect: 'transition.fadeOut'
          duration: 250
    debug: false

  # === Public ===

  constructor: (references, options) ->
    @references = $ references
    @options    = $.extend @defaults, options

    @window = $ window

    @body = $ 'body'

    @browse   = @references.find '> .browse'
    @previous = @browse.find '> .previous'
    @next     = @browse.find '> .next'

    initialize.call @

    return

  # === Events ===

  onInitialize: (slick) =>
    @slick = slick

    @index = 0

    currentReference = getReference.call @, slick, 0

    activateReference.call @, currentReference

    tranform.call @

    @window.on 'resize', @onWindowResize

    return

  onBeforeChange: (slick, index, next) =>
    deactivateBrowse.call @

    currentReference = getReference.call @, slick, index

    deactivateReference.call @, currentReference

    return

  onAfterChange: (slick, index) =>
    if index isnt @index
      currentReference = getReference.call @, slick, index

      activateReference.call @, currentReference

      activateBrowse.call @

    @index = index

    return

  onWindowResize: (event) =>
    clearTimeout @timeout

    @timeout = setTimeout @onWindowResized, 500

    return

  onWindowResized: =>
    tranform.call @

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
      nextArrow: '.browse a.next'
      prevArrow: '.browse a.previous'
      slide: '.slick-slide'
      slidesToScroll: 1
      slidesToShow: 3
      speed: @options.speed

      onInit: @onInitialize
      onBeforeChange: @onBeforeChange
      onAfterChange: @onAfterChange

    return

  activateReference = (reference) ->
    instance = reference.data 'reference'

    do instance.activate if instance?

    return

  deactivateReference = (reference) ->
    instance = reference.data 'reference'

    do instance.deactivate if instance?

    return

  activateBrowse = ->
    @previous.velocity @options.activate.browse.previous.effect,
      duration: @options.activate.browse.previous.duration

    @next.velocity @options.activate.browse.next.effect,
      duration: @options.activate.browse.next.duration

    return

  deactivateBrowse = ->
    @previous.velocity @options.deactivate.browse.previous.effect,
      duration: @options.deactivate.browse.previous.duration

    @next.velocity @options.deactivate.browse.next.effect,
      duration: @options.deactivate.browse.next.duration

    return

  getReference = (slick, index) ->
    references = slick.$slides

    $ references[index]

  tranform = ->
    bodyWidth       = do @body.width
    referencesWidth = do @references.width

    difference  = bodyWidth - referencesWidth
    translateX  = difference / 2

    @references.velocity
      translateX: translateX

    return