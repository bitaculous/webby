class @Shady
  # === Constants ==

  @WEBGL: 'WebGL'
  @CANVAS: 'Canvas'
  @SVG:'SVG'

  # === Variables ===

  defaults:
    debug: false

  rendering:
    renderer: @WEBGL

    mesh:
      width: 1.2
      height: 1.2
      depth: 4
      segments: 8
      slices: 8
      xRange: 0.5
      yRange: 0.5
      zRange: 0
      ambient: '#555555'
      diffuse: '#FFFFFF'
      speed: 0.002

    light:
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
    offset = @rendering.mesh.depth / 2

    # Update bounds
    FSS.Vector3.copy @rendering.light.bounds, @center
    FSS.Vector3.multiplyScalar @rendering.light.bounds, @rendering.light.xyScalar

    # Update attractor
    FSS.Vector3.setZ @attractor, @rendering.light.zOffset

    # Overwrite the attractor position
    if @rendering.light.autopilot
      ox = Math.sin @rendering.light.step[0] * @now * @rendering.light.speed
      oy = Math.cos @rendering.light.step[1] * @now * @rendering.light.speed

      FSS.Vector3.set(
        @attractor
        @rendering.light.bounds[0] * ox
        @rendering.light.bounds[1] * oy
        @rendering.light.zOffset
      )

    # Animate lights
    l = @scene.lights.length - 1

    while l >= 0
      light = @scene.lights[l]

      # Reset the z-position of the light
      FSS.Vector3.setZ light.position, @rendering.light.zOffset

      # Calculate the force Luke!
      d = Math.clamp FSS.Vector3.distanceSquared(light.position, @attractor), @rendering.light.minDistance, @rendering.light.maxDistance

      f = @rendering.light.gravity * light.mass / d

      FSS.Vector3.subtractVectors light.force, @attractor, light.position
      FSS.Vector3.normalise light.force
      FSS.Vector3.multiplyScalar light.force, f

      # Update the light position
      FSS.Vector3.set light.acceleration
      FSS.Vector3.add light.acceleration, light.force
      FSS.Vector3.add light.velocity, light.acceleration
      FSS.Vector3.multiplyScalar light.velocity, @rendering.light.dampening
      FSS.Vector3.limit light.velocity, @rendering.light.minLimit, @rendering.light.maxLimit
      FSS.Vector3.add light.position, light.velocity

      l--

    # Animate Vertices
    v = @geometry.vertices.length - 1

    while v >= 0
      vertex = @geometry.vertices[v]

      ox = Math.sin(vertex.time + vertex.step[0] * @now * @rendering.mesh.speed)
      oy = Math.cos(vertex.time + vertex.step[1] * @now * @rendering.mesh.speed)
      oz = Math.sin(vertex.time + vertex.step[2] * @now * @rendering.mesh.speed)

      FSS.Vector3.set(
        vertex.position
        @rendering.mesh.xRange * @geometry.segmentWidth * ox
        @rendering.mesh.yRange * @geometry.sliceHeight * oy
        @rendering.mesh.zRange * offset * oz - offset
      )

      FSS.Vector3.add vertex.position, vertex.anchor

      v--

    # Set the geometry to dirty
    @geometry.dirty = true

    return

  render: ->
    @renderer.render @scene

    # Draw Lights
    if @rendering.light.draw
      l = @scene.lights.length - 1

      while l >= 0
        light = @scene.lights[l]

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

        l--

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
      @rendering.mesh.width * @renderer.width
      @rendering.mesh.height * @renderer.height
      @rendering.mesh.segments
      @rendering.mesh.slices
    )

    @material = new FSS.Material(
      @rendering.mesh.ambient
      @rendering.mesh.diffuse
    )

    @mesh = new FSS.Mesh(
      @geometry
      @material
    )

    @scene.add @mesh

    # Augment vertices for animation
    v = @geometry.vertices.length - 1

    while v >= 0
      vertex = @geometry.vertices[v]

      vertex.anchor = FSS.Vector3.clone vertex.position

      vertex.step = FSS.Vector3.create(
        Math.randomInRange 0.2, 1.0
        Math.randomInRange 0.2, 1.0
        Math.randomInRange 0.2, 1.0
      )

      vertex.time = Math.randomInRange 0, Math.PIM2

      v--

    return

  createLights = ->
    l = @scene.lights.length - 1

    while l >= 0
      light = @scene.lights[l]

      @scene.remove light

      l--

    do @renderer.clear

    l = 0

    while l < @rendering.light.count
      light = new FSS.Light @rendering.light.ambient, @rendering.light.diffuse

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

      l++

    return

  addEventListeners = ->
    window.addEventListener 'resize', @onWindowResize

    window.addEventListener 'mousemove', @onMouseMove

    return