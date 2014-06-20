[Webby](https://github.com/bitaculous/webby "Sources of the official Bitaculous website.")
==========================================================================================

**Sources of the official Bitaculous website.**

[![Gemnasium Status](https://gemnasium.com/bitaculous/webby.svg)](https://gemnasium.com/bitaculous/webby)

Install
-------

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

### Fonts

* [Nexa free font](http://fontfabric.com/nexa-free-font "Nexa free font") which is released under the Fontfabric™ Free
Font EULA.

License
-------

[Webby](https://github.com/bitaculous/webby "Sources of the official Bitaculous website.") is released under the MIT
License (MIT), see [LICENSE](https://raw.githubusercontent.com/bitaculous/webby/master/LICENSE "License").