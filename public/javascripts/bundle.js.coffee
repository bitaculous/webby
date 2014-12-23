# This is the manifest for `bundle.js`.

#= require polyfills/console
#= require polyfills/fastclick

#= require hogan

#= require jquery
#= require jquery/plugins/formify
#= require jquery/plugins/i18n
#= require jquery/plugins/referencesify
#= require jquery/plugins/roofify
#= require jquery/plugins/scrollify
#= require jquery/plugins/shadify
#= require jquery/plugins/slick
#= require jquery/plugins/slidify

#= require iframe_resizer

#= require velocity
#= require velocity/ui

#= require_self

$ ->
  # === Shared variables ===

  theatre = $ '.theatre'

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
      overview = stage.find '> .overview'

      if do overview.present
        shady  = overview.find '> .shady'
        slider = overview.find '> .slider'

        if do slider.present
          slider.slidify
            shady: shady
            shadify:
              colors: [
                ['#4D1515', '#F22440']
              ]
              offsets:
                width: 0
                height: 44
              randomize: true

      work = stage.find '> .work'

      if do work.present
        references = work.find '.references'

        do references.referencesify if do references.present

      content = stage.find '> .content'

      if do content.present
        piwik = content.find 'iframe.piwik'

        piwik.iFrameResize {
          autoResize: true
          bodyMargin: '0 1em 2em'
        } if do piwik.present

  return