#= require ./referencesies/reference

#= require_self

class @Referencesies
  # === Variables ===

  defaults:
    speed: 500
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

    @browse   = @references.find '> .browse'
    @previous = @browse.find '> .previous'
    @next     = @browse.find '> .next'

    initialize.call @

    return

  # === Events ===

  onInitialize: (slick) =>
    references       = slick.$slides
    currentReference = $ references[0]

    activateReference.call @, currentReference

    @index = 0

    return

  onBeforeChange: (slick, index, next) =>
    deactivateBrowse.call @

    references       = slick.$slides
    currentReference = $ references[index]

    deactivateReference.call @, currentReference

    return

  onAfterChange: (slick, index) =>
    if index isnt @index
      references       = slick.$slides
      currentReference = $ references[index]

      activateReference.call @, currentReference

      activateBrowse.call @

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
      nextArrow: '.browse a.next'
      prevArrow: '.browse a.previous'
      slide: '.reference'
      slidesToScroll: 1
      slidesToShow: 1
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
    @previous.velocity @options.activate.browse.previous.effect, {
      duration: @options.activate.browse.previous.duration
    }

    @next.velocity @options.activate.browse.next.effect, {
      duration: @options.activate.browse.next.duration
    }

    return

  deactivateBrowse = ->
    @previous.velocity @options.deactivate.browse.previous.effect, {
      duration: @options.deactivate.browse.previous.duration
    }

    @next.velocity @options.deactivate.browse.next.effect, {
      duration: @options.deactivate.browse.next.duration
    }

    return