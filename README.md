# telegraph-parser

Gem to pull and parse articles from Telegra.ph.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telegraph-parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telegraph-parser

## Usage

Load parser to your project.

```ruby
require 'telegraph/parser'

```

Load article from Telegra.ph:

```ruby
article = Telegraph::Parser::Article.load('Пять-врагов-государства-12-10')
```

Article contains attributes:

```ruby
article.id
 => "Пять-врагов-государства-12-10"

article.title
 => "Пять врагов государства"

 article.author
 => "Алексей ШЕРСТНЕВ"

article.content
 => "<article><p><br></p>\n<figure><div class=\"figure_wrapper\">....

article.imagese.images
=> {"/6e4ecf2f73df0e2a97028.gif"=>
  "GIF89a\xF4\x01\xDC\x00\xF7\xFF\x00\x00\x00\x00/B9\x8A\x94\x8C\xAB\xB0\xAA\x15\x18!z\x87\x840\x01\x05&)1\xC7\xA0\xA0WffK\x01\x06\x06\x14\x15\x93\n'\xA21Gvzy\xA8\x00\x12ivv)CC\x13!\x18\x....

```

telegraph-parser will change images names in src attribute

```
http://telegra.ph/file/6e4ecf2f73df0e2a97028.gif => 6e4ecf2f73df0e2a97028.gif

```


You can add prefix to image filenames:

```ruby
article = Telegraph::Parser::Article.load('Пять-врагов-государства-12-10', image_prefix: '/static')

article.images.keys.first
=> "/static/6e4ecf2f73df0e2a97028.gif"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/svernidub/telegraph-parser.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

