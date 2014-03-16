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

Serve a site from local file system:

```shell
$ wagon serve
```

Push site to remote LocomotiveCMS engine:

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

### Fonts

* [Bebas Neue](http://www.fontsquirrel.com/fonts/bebas-neue "Bebas Neue")
* [Colaborate](http://www.fontsquirrel.com/fonts/colaborate "Colaborate")

Code Status
-----------

[<img src="https://gemnasium.com/bitaculous/webby.png?travis" title="Gemnasium Status" alt="Gemnasium Status" />](https://gemnasium.com/bitaculous/webby)

License
-------

Webby is released under the MIT License.