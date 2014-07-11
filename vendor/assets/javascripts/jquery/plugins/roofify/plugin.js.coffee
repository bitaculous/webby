(($, window, document) ->
  'use strict'

  $.fn.roofify = (options) ->
    @each ->
      element = $ @

      if typeof element.data('roofify') is 'undefined'
        plugin = new Roofy @, options

        element.data 'roofify', plugin

      return
) jQuery, window, document