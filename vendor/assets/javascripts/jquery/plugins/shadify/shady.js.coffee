class @Shady
  # === Variables ===

  defaults:
    debug: false

  # === Public ===

  constructor: (element, options) ->
    @element   = $ element
    @container = @element[0]
    @options   = $.extend @defaults, options

    initialize.call @

    return

  # === Private ===

  initialize = ->
    offsetHeight = @container.offsetHeight
    offsetWidth  = @container.offsetWidth

    # Create a Renderer for the context you would like to render to. You can use either the `WebGLRenderer`,
    # `CanvasRenderer` or `SVGRenderer`.
    @renderer = new FSS.WebGLRenderer

    # Add the Renderer's element to the DOM (`canvas`).
    @container.appendChild @renderer.element

    # Resize Renderer to the Container dimensions.
    @renderer.setSize offsetWidth, offsetHeight

    # Create a Scene.
    @scene = new FSS.Scene

    # Create some Geometry (`width`, `height`, `segments`, `slices`) & a Material, pass them to a Mesh constructor, and
    # add the Mesh to the Scene.
    geometry = new FSS.Plane offsetWidth, offsetHeight, 4, 2
    material = new FSS.Material '#444444', '#FFFFFF'
    mesh     = new FSS.Mesh geometry, material

    @scene.add mesh

    # Create and add a Light to the Scene.
    light = new FSS.Light '#FF0000', '#0000FF'

    @scene.add light

    # Finally, render the Scene.
    @renderer.render @scene

    return