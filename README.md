[Webby](https://github.com/bitaculous/webby "Sources of the official Bitaculous website.")
==========================================================================================

**Sources of the official Bitaculous website.**

[![Gemnasium Status](https://gemnasium.com/bitaculous/webby.svg)](https://gemnasium.com/bitaculous/webby)

Installation
------------

    $ git clone git@github.com:bitaculous/webby.git webby
    $ cd webby
    $ bundle
    $ cp ressources/config/deploy.yml config/deploy.yml

Usage
-----

Serve webby from local file system:

```shell
$ wagon serve
```

Push webby to remote LocomotiveCMS engine:

```shell
$ wagon push <ENV>
$ wagon push <ENV> --data
$ wagon push <ENV> --resources=content_types,pages,snippets,theme_assets
```

Pull data from remote LocomotiveCMS engine:

```shell
$ wagon pull <ENV>
```

Credits
-------

Webby uses the following assets:

### CSS

* [normalize.css](http://necolas.github.io/normalize.css "normalize.css")

### JavaScript

* [Flat Surface Shader [FSS]](http://matthew.wagerfield.com/flat-surface-shader "Flat Surface Shader for rendering lit triangles to a number of contexts including WebGL, Canvas 2D and SVG")
* [Modernizr](http://modernizr.com "Modernizr is a JavaScript library that detects HTML5 and CSS3 features in the user’s browser.")

#### Polyfills

* [Console](https://github.com/h5bp/html5-boilerplate/blob/master/js/plugins.js "Avoid `console` errors in browsers that lack a console.")
* [FastClick](https://github.com/ftlabs/fastclick "Polyfill to remove click delays on browsers with touch UIs.")

#### [jQuery](http://jquery.com "The Write Less, Do More, JavaScript Library.")

* [AnimateScroll](http://plugins.compzets.com/animatescroll "A Simple jQuery Plugin for Animating Scroll.")
* [slick](http://kenwheeler.github.io/slick "The last carousel you'll ever need.")
* [Velocity](http://velocityjs.org "Accelerated JavaScript animation.")
* [Waypoints](http://imakewebthings.com/jquery-waypoints "Waypoints is a jQuery plugin that makes it easy to execute a function whenever you scroll to an element.")

### Fonts

* [Nexa font](http://fontfabric.com/nexa-font "Nexa font")
* [Font Awesome](http://fortawesome.github.io/Font-Awesome "The iconic font and CSS toolkit")

License
-------

[Webby](https://github.com/bitaculous/webby "Sources of the official Bitaculous website.") is released under the MIT
License (MIT), see [LICENSE](https://raw.githubusercontent.com/bitaculous/webby/master/LICENSE "License").