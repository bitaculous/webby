(($, window, document) ->
  $.fn.shadify = (options) ->
    @each ->
      element = $ @

      if element.data('shadify') is `undefined`
        plugin = new Shady @, options

        element.data 'shadify', plugin

      return
) jQuery, window, document