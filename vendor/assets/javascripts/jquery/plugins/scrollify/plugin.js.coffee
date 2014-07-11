(($, window, document) ->
  'use strict'

  $.fn.scrollify = (options) ->
    @each ->
      element = $ @

      if typeof element.data('scrollify') is 'undefined'
        plugin = new Scrolly @, options

        element.data 'scrollify', plugin

      return
) jQuery, window, document