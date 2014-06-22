# This is the manifest for `bundle.js`.

#= require polyfills/console
#= require polyfills/fastclick

#= require jquery
#= require jquery/plugins/slick

$ ->
  # === FastClick ===

  FastClick.attach document.body

  return