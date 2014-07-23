(($, window, document) ->
  'use strict'

  $.fn.slidify = (options) ->
    @each ->
      element = $ @

      if typeof element.data('slidify') is 'undefined'
        plugin = new Slidy @, options

        element.data 'slidify', plugin

      return
) jQuery, window, document