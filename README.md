To sort out your dependencies, execute the following commands:

```
$ npm install
$ bower install
```

Then whenever you want to build and/or run, do:

```
$ gulp watch
```

This will build everything to a `dist/` directory and serve your website at `http://localhost:9000`. A watcher will also be spawned to ensure that re-builds automatically occur whenever files change, so just keep that running while you work.
