# SourceMapsFixer

SourceMapsFixer is a set of [Rake](https://ruby.github.io/rake/) tasks for fixing **sourceMappingURL**s.  
It is useful in [Rails](https://rubyonrails.org) apps if you like to have your main front-end code separated in `frontend` directory, for example. But you also use [Sprockets](https://github.com/rails/sprockets-rails) to process additional assets and compile them to `public/assets`. Fingerprints are added to asset filenames during compilation, by default. It is useful in conjunction with far-future headers.

Common setup looks like this:

Module bundler like [webpack](https://webpack.js.org) outputs bundles to `app/assets/bundles`, for example. By running `bin/rails assets:precompile` _Sprockets_ compiles all assets to `public/assets`

### Problem

When _webpack_ produces bundles to `app/assets/bundles`, each contains **sourceMappingURL** at the bottom (if configured). This URL links to the corresponding source map.  
But when _Sprockets_ compile assets to `public/assets`, fingerprints are added to all asset filenames.  
**sourceMappingURL**s are intact which makes them pointing to invalid files without fingerprints.

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

Add this line to your application's Gemfile:

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


## 📜 License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## 👨‍🏭 Author
Zbigniew Humeniuk from [Art of Code](https://artofcode.co)


## 👀 See also
If you want to make your life easier in other areas of web app development, I strongly recommend you to take a look at my other project called [Loco framework](http://locoframework.org) 🙂. It is quite powerful and makes a front-end <-> back-end communication a breeze (among other things).
