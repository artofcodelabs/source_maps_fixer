# SourceMapsFixer

SourceMapsFixer is a set of [Rake](https://ruby.github.io/rake/) tasks for fixing **sourceMappingURL**s.  
It is helpful for [Rails](https://rubyonrails.org) apps where the main front-end code lives in the separate directory like `frontend`. But the app also uses [Sprockets](https://github.com/rails/sprockets-rails) to process outputted bundles and additional assets inside `app/assets` directory. `bin/rails assets:precompile` command compiles assets to `public/assets` directory. Fingerprints are added to asset filenames during compilation by default. It is useful in conjunction with far-future headers.

### Problem

When [webpack](https://webpack.js.org) produces bundles to `app/assets/bundles`, each contains **sourceMappingURL** at the bottom (if configured). This URL links to the corresponding source map.  
But when _Sprockets_ compile assets to `public/assets`, fingerprints are added to all asset filenames.  
**sourceMappingURL**s are intact, which makes them point to invalid files without fingerprints.

### Solution

_SourceMapsFixer_ fixes **sourceMappingURL**s inside bundles.  


## 🎮 Usage

Instead of running

```bash
$ bin/rails assets:precompile
```

run

```bash
$ bin/rails assets:prepare
```


## 📥 Installation

Add *source\_maps\_fixer* to your application's Gemfile:

```ruby
gem 'source_maps_fixer'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install source_maps_fixer
```


## 📈 Changelog

### Major releases 🎙

#### 0.2 _(2022-02-11)_
##### 💥 breaking changes

* *source\_maps\_fixer* works with Rails 7 and Ruby 3.1.
* it drops support for Ruby 2.6
* it supports sprockets-rails ~> 3.3.0. Version 3.4.0 works differently. `bin/rails assets:precompile` correctly replaces *sourceMappingURL*s for JS files but adds unnecessary comments


## 📜 License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## 👨‍🏭 Author
Zbigniew Humeniuk from [Art of Code](https://artofcode.co)


## 👀 See also
If you want to make your life easier in other areas of web app development, I strongly recommend you to take a look at my other project called the [Loco framework](http://locoframework.org) 🙂. It is pretty powerful and makes a front-end <-> back-end communication a breeze (among other things).
