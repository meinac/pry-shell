# Pry::Shell

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/pry/shell`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pry-shell'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pry-shell

## Usage

Here's a [video showing how to use pry-shell](https://www.youtube.com/watch?v=Lzs_PL_BySo).

### Start the shell

    $ pry-shell

### Add breakpoints

Include this snippet in the code line you are interested:

```ruby
binding.pry_shell
```

PryShell will enable [Byebug](https://github.com/deivid-rodriguez/byebug) by default if the `pry-byebug` gem has already been installed. In case if you want to disable byebug, you can set the `with_byebug` option as false, like so;

```ruby
binding.pry_shell(with_byebug: false)
```

### Get access to the Pry session

Start the shell, add a breakpoint and make your program hit the desired code section. Afterwards, choose "Available sessions" from the shell main manu and hit "Enter". Then select your desired pry session and hit "Enter".

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pry-shell.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
