# This is the manifest for `bundle.js`.

#= require polyfills/console
#= require polyfills/fastclick

#= require jquery
#= require jquery/plugins/shadify
#= require jquery/plugins/slick

$ ->
  # === Shared variables ===

  html     = $ 'html'
  theatre  = $ '.theatre'
  roof     = theatre.find '.roof'
  stage    = theatre.find '.stage'
  basement = theatre.find '.basement'

  # === Events ===

  onSliderInitialized = (slick) ->
    slider  = slick.$slider
    outline = slider.closest '.outline'
    shady   = outline.find '.shady'

    # May I have your attention please? Will the real Shady please stand up?
    do shady.shadify if do shady.present

    return

  # === FastClick ===

  FastClick.attach document.body

  # === Stage ===

  if do stage.present
    outline = stage.find '.outline'

    if do outline.present
      slider = outline.find '.slider'

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

  return