(($, window, document) ->
  $.fn.scrollify = (options) ->
    @each ->
      element = $ @

      if element.data('scrollify') is `undefined`
        plugin = new Scrolly @, options

        element.data 'scrollify', plugin

      return
) jQuery, window, document