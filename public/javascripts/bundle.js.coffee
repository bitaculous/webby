# This is the manifest for `bundle.js`.

#= require polyfills/console
#= require polyfills/fastclick

#= require jquery
#= require jquery/plugins/slick

$ ->
  # === Shared variables ===

  html     = $ 'html'
  theatre  = $ '.theatre'
  roof     = theatre.find '.roof'
  stage    = theatre.find '.stage'
  basement = theatre.find '.basement'

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
          autoplaySpeed: 5000
          centerMode: true
          centerPadding: '0px'
          dots: true
          fade: true
          slide: '.slide'
          slidesToScroll: 1
          slidesToShow: 1
          speed: 500
        }

  return