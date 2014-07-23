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
#= require jquery/plugins/slidify
#= require jquery/plugins/velocity

#= require_self

$ ->
  # === Shared variables ===

  html     = $ 'html'
  theatre  = $ '.theatre'
  stage    = theatre.find '> .stage'

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

        do slider.slidify if do slider.present

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