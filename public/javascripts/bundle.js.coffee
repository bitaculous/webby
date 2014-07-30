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
#= require jquery/plugins/velocity

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
      abstract = stage.find '> .abstract'

      if do abstract.present
        shady  = abstract.find '> .shady'
        slider = abstract.find '> .slider'

        slider.slidify {
          shady: shady
        } if do slider.present

      work = stage.find '> .work'

      if do work.present
        references = work.find '.references'

        do references.referencesify if do references.present

  return