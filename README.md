# Bootstrappers

Bootstrappers is the base Rails application using Bootstrap template and other goodies.

## Installation

First install the bootstrappers gem:

    gem install bootstrappers

Then run:

    $ bootstrappers project_name


## Gemfile

To see the latest and greatest gems, look at Suspenders' template/Gemfile_additions, which will be appended to the default generated projectname/Gemfile.


It includes application gems like:

### View / SCSS
* [Bootstrap SCSS](https://github.com/anjlab/bootstrap-rails)
* [Bootstrap Helper](https://github.com/xdite/bootstrap-helper)
* [SimpleForm](https://github.com/plataformatec/simple_form)
* [WillPaginate](https://github.com/mislav/will_paginate/)
* [Compass](http://compass-style.org/)

### Photo Uplaod

* [CarrierWave](https://github.com/jnicklas/carrierwave)

### Social / SEO

* [SeoHelper](https://github.com/techbang/seo_helper)
* [OpenGraphHelper](https://github.com/techbang/open_graph_helper)

### Deploy 

* [Capistrano](https://github.com/capistrano/capistrano)
* [Cape](https://github.com/njonsson/cape)
* [Airbrake](https://github.com/airbrake/airbrake)
* [NewRelic RPM](https://github.com/newrelic/rpm)
* [Turbo Sprockets for Rails 3.2.x](https://github.com/ndbroadbent/turbo-sprockets-rails3) Speeds up your Rails 3 rake assets:precompile by only recompiling changed assets

### CommandLine
* [Magic encoding](https://github.com/m-ryan/magic_encoding)
* [Annotate](https://github.com/ctran/annotate_models)
* [Settingslogic](https://github.com/binarylogic/settingslogic)
* [Pry](http://pryrepl.org/)



## Remind

config/database.yml default setting:

```
development: &default
  adapter: mysql2
  encoding: utf8
  database: <%= app_name %>_development
  host: localhost
  username: root
  password: ""
```  

but we still ask for your preferences


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Issues


If you have problems, please create a [Github issue](https://github.com/xdite/bootstrappers/issues).

## Credits

Bootstrappers is maintained and funded by [@xdite](http://github.com/xdite)

some codes of bootstrappers were borrowed from [suspenders](https://github.com/thoughtbot/suspendersus)


License
-------

Bootstrappers is Copyright © 2012 xdite. It is free software, and may be redistributed under the terms specified in the LICENSE file.
