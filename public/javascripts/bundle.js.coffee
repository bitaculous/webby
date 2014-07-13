# This is the manifest for `bundle.js`.

#= require polyfills/console
#= require polyfills/fastclick

#= require hogan

#= require jquery
#= require jquery/plugins/formify
#= require jquery/plugins/i18n
#= require jquery/plugins/roofify
#= require jquery/plugins/scrollify
#= require jquery/plugins/shadify
#= require jquery/plugins/slick
#= require jquery/plugins/velocity

#= require_self

$ ->
  # === Shared variables ===

  html     = $ 'html'
  theatre  = $ '.theatre'
  stage    = theatre.find '> .stage'

  # === Events ===

  onSliderInitialized = (slick) ->
    slider   = slick.$slider
    abstract = slider.closest '.abstract'
    shady    = abstract.find '> .shady'

    # May I have your attention please? Will the real Shady please stand up?
    shady.shadify {
      inactive: true
    } if do shady.present

    return

  # === FastClick ===

  FastClick.attach document.body

  # === Theatre ===

  if do theatre.present
    do theatre.scrollify

    roof = theatre.find '> .roof'

    if do roof.present
      do roof.roofify

      backstage = roof.find '> .backstage'

      if do backstage.present
        contact = backstage.find '> .contact'

        if do contact.present
          request = contact.find '.request'

          do request.formify if do request.present

    stage = theatre.find '> .stage'

    if do stage.present
      abstract = stage.find '> .abstract'

      if do abstract.present
        slider = abstract.find '> .slider'

        if do slider.present
          slider.slick {
            arrows: false
            autoplay: true
            autoplaySpeed: 7500
            centerMode: true
            centerPadding: '0px'
            dots: true
            slide: '.slide'
            slidesToScroll: 1
            slidesToShow: 1
            speed: 500
            onInit: onSliderInitialized
          }

      work = stage.find '> .work'

      if do work.present
        references = work.find '.references'

        if do references.present
          references.slick {
            autoplay: false
            autoplaySpeed: 7500
            centerMode: true
            centerPadding: '0px'
            dots: false
            slide: '.reference'
            slidesToScroll: 1
            slidesToShow: 1
            speed: 500
          }

  return