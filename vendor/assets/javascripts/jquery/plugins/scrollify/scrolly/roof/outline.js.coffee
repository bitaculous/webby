class @Outline
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (outline, scrolly, options) ->
    @outline = $ outline
    @scrolly = scrolly
    @options = $.extend @defaults, options

    @links = @outline.find 'a'

    initialize.call @

    return

  getScrollDataByLink: (link) ->
    if link
      if link.attr 'data-target'
        data =
          target: link.data 'target'
          offset: link.data 'offset'

        return data

    null

  getScrollDataByHash: (hash) ->
    if hash
      link = @findLinkByHash hash

      return @getScrollDataByLink link

    null

  findItemById: (id) ->
    @outline.find "li.#{id}"

  findLinkByHash: (hash) ->
    @outline.find "a[data-href='#{hash}']"

  # === Events ===

  onLinkClick: (event) =>
    link = $ event.target
    data = @getScrollDataByLink link

    @scrolly.scrollTo data.target, data.offset

  # === Private ===

  initialize = ->
    setupLinks.call @

    return

  setupLinks = ->
    @links.on 'click', @onLinkClick

    return