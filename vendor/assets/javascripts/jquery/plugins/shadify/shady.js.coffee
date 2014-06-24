class @Shady
  # === Constants ==

  @MESH:
    width: 1.2
    height: 1.2
    depth: 10
    segments: 20
    slices: 16
    xRange: 0.8
    yRange: 0.1
    zRange: 1.0
    ambient: '#555555'
    diffuse: '#FFFFFF'
    speed: 0.002

  @LIGHT:
    count: 2
    xyScalar: 1
    zOffset: 100
    ambient: '#880066'
    diffuse: '#FF8800'
    speed: 0.001
    gravity: 1200
    dampening: 0.95
    minLimit: 10
    maxLimit: null
    minDistance: 20
    maxDistance: 400
    autopilot: true
    draw: true
    bounds: do FSS.Vector3.create
    step: FSS.Vector3.create Math.randomInRange(0.2, 1.0), Math.randomInRange(0.2, 1.0), Math.randomInRange(0.2, 1.0)

  @WEBGL: 'webgl'
  @CANVAS: 'canvas'
  @SVG:'svg'

  # === Variables ===

  defaults:
    debug: false

  rendering:
    renderer: @WEBGL

  # === Public ===

  constructor: (element, options) ->
    @element = $ element
    @options = $.extend @defaults, options

    initialize.call @

    return

  animate: =>
    @now = do Date.now - @start

    do @update

    do @render

    requestAnimationFrame @animate

    return

  update: ->
    offset = Shady.MESH.depth / 2

    # Update bounds
    FSS.Vector3.copy Shady.LIGHT.bounds, @center
    FSS.Vector3.multiplyScalar Shady.LIGHT.bounds, Shady.LIGHT.xyScalar

    # Update attractor
    FSS.Vector3.setZ @attractor, Shady.LIGHT.zOffset

    # Overwrite the attractor position
    if Shady.LIGHT.autopilot
      ox = Math.sin Shady.LIGHT.step[0] * @now * Shady.LIGHT.speed
      oy = Math.cos Shady.LIGHT.step[1] * @now * Shady.LIGHT.speed

      FSS.Vector3.set(
        @attractor
        Shady.LIGHT.bounds[0] * ox
        Shady.LIGHT.bounds[1] * oy
        Shady.LIGHT.zOffset
      )

    # Animate lights
    for light in @scene.lights
      # Reset the z-position of the light
      FSS.Vector3.setZ light.position, Shady.LIGHT.zOffset

      # Calculate the force Luke!
      d = Math.clamp FSS.Vector3.distanceSquared(light.position, @attractor), Shady.LIGHT.minDistance, Shady.LIGHT.maxDistance

      f = Shady.LIGHT.gravity * light.mass / d

      FSS.Vector3.subtractVectors light.force, @attractor, light.position
      FSS.Vector3.normalise light.force
      FSS.Vector3.multiplyScalar light.force, f

      # Update the light position
      FSS.Vector3.set light.acceleration
      FSS.Vector3.add light.acceleration, light.force
      FSS.Vector3.add light.velocity, light.acceleration
      FSS.Vector3.multiplyScalar light.velocity, Shady.LIGHT.dampening
      FSS.Vector3.limit light.velocity, Shady.LIGHT.minLimit, Shady.LIGHT.maxLimit
      FSS.Vector3.add light.position, light.velocity

    # Animate vertices
    for vertex in @geometry.vertices
      ox = Math.sin vertex.time + vertex.step[0] * @now * Shady.MESH.speed
      oy = Math.cos vertex.time + vertex.step[1] * @now * Shady.MESH.speed
      oz = Math.sin vertex.time + vertex.step[2] * @now * Shady.MESH.speed

      FSS.Vector3.set (
        vertex.position
        Shady.MESH.xRange * @geometry.segmentWidth * ox
        Shady.MESH.yRange * @geometry.sliceHeight * oy
        Shady.MESH.zRange * offset * oz - offset
      )

      FSS.Vector3.add vertex.position, vertex.anchor

    # Set the geometry to dirty
    # @geometry.dirty = true

    return

  render: ->
    @renderer.render @scene

    # Draw Lights
    if Shady.LIGHT.draw
      for light in @scene.lights
        lx = light.position[0]
        ly = light.position[1]

        switch @rendering.renderer
          when Shady.CANVAS
            @renderer.context.lineWidth = 0.5

            do @renderer.context.beginPath

            @renderer.context.arc lx, ly, 10, 0, Math.PIM2
            @renderer.context.strokeStyle = light.ambientHex

            do @renderer.context.stroke
            do @renderer.context.beginPath

            @renderer.context.arc lx, ly, 4, 0, Math.PIM2
            @renderer.context.fillStyle = light.diffuseHex

            do @renderer.context.fill
          when Shady.SVG
            lx += @renderer.halfWidth
            ly = @renderer.halfHeight - ly

            light.core.setAttributeNS null, 'fill', light.diffuseHex
            light.core.setAttributeNS null, 'cx', lx
            light.core.setAttributeNS null, 'cy', ly

            @renderer.element.appendChild light.core

            light.ring.setAttributeNS null, 'stroke', light.ambientHex
            light.ring.setAttributeNS null, 'cx', lx
            light.ring.setAttributeNS null, 'cy', ly

            @renderer.element.appendChild light.ring

    return

  setRenderer: (index) ->
    if (@renderer)
      @container.removeChild @renderer.element

    switch index
      when Shady.WEBGL
        @renderer = @webglRenderer
      when Shady.CANVAS
        @renderer = @canvasRenderer
      when Shady.SVG
        @renderer = @svgRenderer

    @renderer.setSize @container.offsetWidth, @container.offsetHeight

    # Add the renderer's element to the DOM (`canvas`)
    @container.appendChild @renderer.element

    return

  resize: (width, height) ->
    @renderer.setSize width, height

    FSS.Vector3.set @center, @renderer.halfWidth, @renderer.halfHeight

    createMesh.call @

    return

  # === Events ===

  onWindowResize: (event) =>
    @resize @container.offsetWidth, @container.offsetHeight

    do @render

    return

  onMouseMove: (event) =>
    FSS.Vector3.set @attractor, event.x, @renderer.height - event.y
    FSS.Vector3.subtract @attractor, @center

    return

  onMouseClick: (event) =>
    FSS.Vector3.set @attractor, event.x, @renderer.height - event.y
    FSS.Vector3.subtract @attractor, @center

  # === Private ===

  initialize = ->
    @container = @element[0]

    @now   = do Date.now
    @start = do Date.now

    @center    = do FSS.Vector3.create
    @attractor = do FSS.Vector3.create

    createRenderer.call @

    createScene.call @

    createMesh.call @

    createLights.call @

    addEventListeners.call @

    @resize @container.offsetWidth, @container.offsetHeight

    do @animate

    return

  createRenderer = ->
    @webglRenderer  = new FSS.WebGLRenderer
    @canvasRenderer = new FSS.CanvasRenderer
    @svgRenderer    = new FSS.SVGRenderer

    @setRenderer @rendering.renderer

    return

  createScene = ->
    @scene = new FSS.Scene

    return

  createMesh = ->
    @scene.remove @mesh if @mesh

    do @renderer.clear

    # Create some geometry (`width`, `height`, `segments`, `slices`) & a material, pass them to mesh constructor, and
    # add the mesh to the scene

    @geometry = new FSS.Plane(
      Shady.MESH.width * @renderer.width
      Shady.MESH.height * @renderer.height
      Shady.MESH.segments
      Shady.MESH.slices
    )

    @material = new FSS.Material(
      Shady.MESH.ambient
      Shady.MESH.diffuse
    )

    @mesh = new FSS.Mesh(
      @geometry
      @material
    )

    @scene.add @mesh

    # Augment vertices for animation
    for vertex in @geometry.vertices
      vertex.anchor = FSS.Vector3.clone vertex.position

      vertex.step = FSS.Vector3.create(
        Math.randomInRange 0.2, 1.0
        Math.randomInRange 0.2, 1.0
        Math.randomInRange 0.2, 1.0
      )

      vertex.time = Math.randomInRange 0, Math.PIM2

    return

  createLights = ->
    for light in @scene.lights
      @scene.remove light

    do @renderer.clear

    for i in [0...Shady.LIGHT.count]
      light = new FSS.Light Shady.LIGHT.ambient, Shady.LIGHT.diffuse

      light.ambientHex = do light.ambient.format
      light.diffuseHex = do light.diffuse.format

      @scene.add light

      # Augment light for animation
      light.mass         = Math.randomInRange 0.5, 1
      light.velocity     = do FSS.Vector3.create
      light.acceleration = do FSS.Vector3.create
      light.force        = do FSS.Vector3.create

      # Ring SVG Circle
      light.ring = document.createElementNS FSS.SVGNS, 'circle'

      light.ring.setAttributeNS null, 'stroke', light.ambientHex
      light.ring.setAttributeNS null, 'stroke-width', '0.5'
      light.ring.setAttributeNS null, 'fill', 'none'
      light.ring.setAttributeNS null, 'r', '10'

      # Core SVG Circle
      light.core = document.createElementNS FSS.SVGNS, 'circle'

      light.core.setAttributeNS null, 'fill', light.diffuseHex
      light.core.setAttributeNS null, 'r', '4'

    return

  addEventListeners = ->
    window.addEventListener 'resize', @onWindowResize

    @container.addEventListener 'click', @onMouseClick
    @container.addEventListener 'mousemove', @onMouseMove

    return