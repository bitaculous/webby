[WEBBY](https://github.com/bitaculous/webby "webby")
====================================================

**Sources of the official Bitaculous website.**

Install
-------

    $ git clone git@github.com:bitaculous/webby.git webby
    $ cd webby
    $ bundle
    $ cp config/deploy.yml.sample config/deploy.yml

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
$ wagon push staging --resources=content_types,pages,snippets,theme_assets
```

Pull data from remote LocomotiveCMS engine:

```shell
$ wagon pull <ENV>
```

Credits
-------

Webby uses the following assets:

* [Foundation](http://foundation.zurb.com "Foundation - The most advanced responsive front-end framework in the world.")

### Fonts

* [Bebas Neue](http://www.fontsquirrel.com/fonts/bebas-neue "Bebas Neue")
* [Colaborate](http://www.fontsquirrel.com/fonts/colaborate "Colaborate")

Code Status
-----------

[<img src="https://gemnasium.com/bitaculous/webby.svg" title="Gemnasium Status" alt="Gemnasium Status" />](https://gemnasium.com/bitaculous/webby)

License
-------

Webby is released under the MIT License except all graphical assets like images, logos, etc.