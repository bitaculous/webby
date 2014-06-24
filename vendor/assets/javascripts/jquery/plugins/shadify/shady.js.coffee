class @Shady
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (element, options) ->
    @element   = $ element
    @container = @element[0]
    @options   = $.extend @defaults, options

    @renderer = new FSS.WebGLRenderer
    @scene    = new FSS.Scene
    @light    = new FSS.Light '#111122', '#FF0022'
    @geometry = new FSS.Plane @container.offsetWidth, @container.offsetHeight, 10, 5
    @material = new FSS.Material '#FFFFFF', '#FFFFFF'
    @mesh     = new FSS.Mesh @geometry, @material
    @now      = do Date.now
    @start    = do Date.now

    initialize.call @

    @renderer.setSize @container.offsetWidth, @container.offsetHeight

    do @animate

    return

  animate: =>
    @now = do Date.now - @start
    @light.setPosition 300 * Math.sin(@now * 0.001), 200 * Math.cos(@now * 0.0005), 60
    @renderer.render @scene

    requestAnimationFrame @animate
    # requestAnimationFrame(@animate.bind @)

    return

  # === Private ===

  initialize = ->
    @scene.add @mesh
    @scene.add @light

    @container.appendChild @renderer.element

    return