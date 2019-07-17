# Frapp

Note: This is the absolute beginning of the app. **Version 0.1.0 will have the basic app creation**
CLI interface to quickly prototype Flutter App's using the BLoC pattern with a Rails API server. 


## Installation

Install:

    $ gem install frapp

## Usage

Check the version  
`frapp --version`

Create a new Flutter and Rails app.  
`frapp new my_app`  
Note: This is still in development however this will create a new Parent directory for the Rails and Flutter App.  
```
|__ my_app  
  |__ my_app_server  
  |__ my_app_ui
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flippakitten/frapp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Frapp project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flippakitten/frapp/blob/master/CODE_OF_CONDUCT.md).
