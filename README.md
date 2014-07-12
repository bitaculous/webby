[Webby]
=======

**Sources of the official Bitaculous website.**

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

* [normalize.css]

### JavaScript

* [Flat Surface Shader (FSS)]
* [Modernizr]

#### Polyfills

* [Console]
* [FastClick]

#### [jQuery]

* [Form Plugin]
* [Slick]
* [Validation Plugin]
* [Velocity]
* [Waypoints]

### Fonts

* [Nexa font]
* [Font Awesome]

License
-------

Webby is released under the MIT License (MIT), see [LICENSE].

[Console]: https://github.com/h5bp/html5-boilerplate/blob/master/js/plugins.js "Avoid `console` errors in browsers that lack a console."
[FastClick]: https://github.com/ftlabs/fastclick "Polyfill to remove click delays on browsers with touch UIs."
[Flat Surface Shader (FSS)]: http://matthew.wagerfield.com/flat-surface-shader "Flat Surface Shader for rendering lit triangles to a number of contexts including WebGL, Canvas 2D and SVG."
[Font Awesome]: http://fortawesome.github.io/Font-Awesome "The iconic font and CSS toolkit"
[Form Plugin]: http://malsup.com/jquery/form "jQuery Form Plugin"
[jQuery]: http://jquery.com "The Write Less, Do More, JavaScript Library."
[LICENSE]: https://raw.githubusercontent.com/bitaculous/webby/master/LICENSE "License"
[Modernizr]: http://modernizr.com "Modernizr is a JavaScript library that detects HTML5 and CSS3 features in the user’s browser."
[Nexa font]: http://fontfabric.com/nexa-font "Nexa font"
[normalize.css]: http://necolas.github.io/normalize.css "normalize.css"
[Slick]: http://kenwheeler.github.io/slick "The last carousel you'll ever need."
[Validation Plugin]: http://jqueryvalidation.org "Form validation made easy."
[Velocity]: http://velocityjs.org "Accelerated JavaScript animation."
[Waypoints]: http://imakewebthings.com/jquery-waypoints "Waypoints is a jQuery plugin that makes it easy to execute a function whenever you scroll to an element."
[Webby]: https://github.com/bitaculous/webby "Sources of the official Bitaculous website."