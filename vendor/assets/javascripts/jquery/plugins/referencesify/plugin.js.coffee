(($, window, document) ->
  'use strict'

  $.fn.referencesify = (options) ->
    @each ->
      element = $ @

      if typeof element.data('referencesify') is 'undefined'
        plugin = new Referencesies @, options

        element.data 'referencesify', plugin

      return
) jQuery, window, document