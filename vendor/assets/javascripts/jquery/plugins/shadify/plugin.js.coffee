(($, window, document) ->
  'use strict'

  $.fn.shadify = (options) ->
    @each ->
      element = $ @

      if typeof element.data('shadify') is 'undefined'
        plugin = new Shady @, options

        element.data 'shadify', plugin

      return
) jQuery, window, document