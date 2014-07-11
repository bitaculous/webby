(($, window, document) ->
  'use strict'

  $.fn.formify = (options) ->
    @each ->
      element = $ @

      if typeof element.data('formify') is 'undefined'
        plugin = new Formy @, options

        element.data 'formify', plugin

      return
) jQuery, window, document