[Webby]
=======

**Sources of the official Bitaculous website.**

[![Gemnasium Status][Gemnasium Status]][Gemnasium]

Installation
------------

    $ git clone git@github.com:bitaculous/webby.git webby
    $ cd webby
    $ bundle
    $ cp ressources/config/deploy.yml config/deploy.yml

Usage
-----

Serve Webby from local file system:

```shell
$ wagon serve
```

Push Webby to remote LocomotiveCMS engine:

```shell
$ wagon push <ENV>
$ wagon push <ENV> --data
$ wagon push <ENV> --data --translations
$ wagon push <ENV> --resources=<content_entries>, <content_types>, <pages>, <snippets>, <theme_assets>, <translations>
```

Pull data from remote LocomotiveCMS engine:

```shell
$ wagon pull <ENV>
```

Credits
-------

### Webby uses the following gems:

* [Assetify]
* [Breakpoint]
* [Compass]
* [HoganAssets]
* [Initializify]
* [kramdown]
* [Liquids]
* [LocomotiveCMS Mounter]
* [LocomotiveCMS Wagon]
* [Modular Scale]
* [Sassy Maps]
* [Susy]
* [Vendorify]

Webby uses the following assets:

### CSS

* [normalize.css]

### JavaScript

* [Flat Surface Shader (FSS)]
* [Modernizr]
* [jQuery]

#### jQuery Plugins

* [i18n]
* [Slick]
* [Validation Plugin]
* [Velocity]
* [Waypoints]

#### Polyfills

* [Console]
* [FastClick]

### Fonts

* [Nexa font]
* [Font Awesome]

License
-------

Webby is released under the [MIT License (MIT)], see [LICENSE].

[Assetify]: http://bitaculous.github.io/assetify "“All your assets are belong to us”"
[Breakpoint]: https://github.com/Team-Sass/breakpoint, "Really simple media queries in Sass"
[Compass]: http://compass-style.org "An open-source CSS Authoring Framework."
[Console]: https://github.com/h5bp/html5-boilerplate/blob/master/js/plugins.js "Avoid `console` errors in browsers that lack a console."
[FastClick]: https://github.com/ftlabs/fastclick "Polyfill to remove click delays on browsers with touch UIs."
[Flat Surface Shader (FSS)]: http://matthew.wagerfield.com/flat-surface-shader "Flat Surface Shader for rendering lit triangles to a number of contexts including WebGL, Canvas 2D and SVG."
[Font Awesome]: http://fortawesome.github.io/Font-Awesome "The iconic font and CSS toolkit"
[Gemnasium]: https://gemnasium.com/bitaculous/webby "Webby at Gemnasium"
[Gemnasium Status]: http://img.shields.io/gemnasium/bitaculous/webby.svg?style=flat "Gemnasium Status"
[HoganAssets]: https://github.com/leshill/hogan_assets "Compiles your mustache templates with hogan.js on sprockets and the Rails asset pipeline."
[i18n]: https://github.com/recurser/jquery-i18n "A jQuery plugin for doing client-side translations in javascript."
[Initializify]: http://bitaculous.github.io/initializify "Put in the condition appropriate to the start of an operation."
[jQuery]: http://jquery.com "The Write Less, Do More, JavaScript Library."
[kramdown]: http://kramdown.gettalong.org "fast, pure-Ruby Markdown-superset converter"
[LICENSE]: https://raw.githubusercontent.com/bitaculous/webby/master/LICENSE "License"
[Liquids]: http://bitaculous.github.io/liquids "A package of misc liquid blocks, tags and filters for Wagon and LocomotiveCMS engine."
[LocomotiveCMS Mounter]: https://github.com/locomotivecms/wagon, "Mount in memory any LocomotiveCMS site, from a template on the filesystem, a zip file or even an online engine."
[LocomotiveCMS Wagon]: https://github.com/locomotivecms/wagon, "The right tool to create and modify a LocomotiveCMS website locally."
[MIT License (MIT)]: http://opensource.org/licenses/MIT "The MIT License (MIT)"
[Modernizr]: http://modernizr.com "Modernizr is a JavaScript library that detects HTML5 and CSS3 features in the user’s browser."
[Modular Scale]: https://github.com/Team-Sass/modular-scale "Modular scale calculator built into your Sass"
[Nexa font]: http://fontfabric.com/nexa-font "Nexa font"
[normalize.css]: http://necolas.github.io/normalize.css "normalize.css"
[Sassy Maps]: https://github.com/Team-Sass/Sassy-Maps "Map helper functions for Sass 3.3 and up"
[Slick]: http://kenwheeler.github.io/slick "The last carousel you'll ever need."
[Susy]: http://susy.oddbird.net "Susy is a toolkit for building layouts of all types with a simple, natural syntax."
[Validation Plugin]: http://jqueryvalidation.org "Form validation made easy."
[Velocity]: http://velocityjs.org "Accelerated JavaScript animation."
[Vendorify]: http://bitaculous.github.io/vendorify, "Put your vendor assets where they belong."
[Waypoints]: http://imakewebthings.com/jquery-waypoints "Waypoints is a jQuery plugin that makes it easy to execute a function whenever you scroll to an element."
[Webby]: https://github.com/bitaculous/webby "Sources of the official Bitaculous website."