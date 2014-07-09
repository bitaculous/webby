(($, window, document) ->
  $.fn.roofify = (options) ->
    @each ->
      element = $ @

      if element.data('roofify') is `undefined`
        plugin = new Roofy @, options

        element.data 'roofify', plugin

      return
) jQuery, window, document