[![Build Status](https://travis-ci.com/flippakitten/frap.svg?branch=master)](https://travis-ci.com/flippakitten/frap)
[![Gem Version](https://badge.fury.io/rb/frap.svg)](https://badge.fury.io/rb/frap) 
[![Join the chat at https://gitter.im/frap-flutter-rails-cli/community](https://badges.gitter.im/frap-flutter-rails-cli/community.svg)](https://gitter.im/frap-flutter-rails-cli/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Maintainability](https://api.codeclimate.com/v1/badges/4a8f6e079b127cdb0b79/maintainability)](https://codeclimate.com/github/flippakitten/frap/maintainability)
# Frap 
CLI interface to quickly prototype Flutter App's using the BLoC pattern with a Rails API server.  

[changelog](https://github.com/flippakitten/frap/wiki/Change-Log-Published)  
[roadmap](https://github.com/flippakitten/frap/projects/2)  

## Prerequisites

Ensure the following are installed:
* [Flutter](https://flutter.dev/docs/get-started/install)
* [Ruby 2.6.5](https://rvm.io/rvm/install) (I've used RVM but you can install it anyway)
* Rails 6.0.1

## Installation

Install:

    $ gem install frap

## Usage

Check the version  
`frap --version`

Create a new Flutter and Rails app.  
`frap new my_app`  
This will create a new Parent directory for the Rails and Flutter App.  
```
|__ my_app  
  |__ my_app_server  
  |__ my_app_ui
```
Generate a Rails and Flutter Resource from the app route directory `/my_app`, **currently does NOT support references, please open an ISSUE for broken data types**  
`frap generate resource post -a title:string body:text`  

The next step is to implement your Rails controller method for index action and run the migrations:
```
cd my_app/my_app_server
rails db:migrate
```
You can then edit the `app/constrollers/posts_controller.rb`:
```ruby
class PostsController < ApplicationController
  def index
    render json: { posts: Post.all.as_json }, status: :ok
  end
end
```
Next fire up Rails and Flutter (you may need to start up an emulator, just follow the terminal output:
```bash
cd my_app/my_app_server
rails s

cd my_app/my_app_ui
flutter run
```


## Motivation
Moving from the old school PHP/HTML/JS/jQuery/Yii(later came bootstrap) into the Rails way of life, I quickly fell in love with Rails and how easy it was to build basic functionality.  

In stepped in NodeJS and React and I was back to having to build everything from scratch, mixing presentation logic and business logic together "because it's the same thing" and then extracting components because as it turns out, it's not the same thing... **Not good for productivity** and it's very expensive, especially for startups.  

Since then I've been trying every new JS framework and nothing really made things less convoluted.  

When I started looking into Flutter and the recommended way to manage state using the BLoC pattern, I realized that the BLoC pattern and the way Flutter apps are structured (everythings a Widget much like everything is an Object) lends itself code automation, getting the boilerplate out the way.

The goal this CLI is to mimic Rails generators and allow you to do something like:
`frap g resource User name:string,email:string,age:int,password_digest`
This will call the rails generator as one would expect. In addition, it will create the "view", or page in Flutter with all the fields, routes and blocs ready to use, ready to save and most importantly... Already styled using the material dart package.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flippakitten/frap. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Frap project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flippakitten/frap/blob/master/CODE_OF_CONDUCT.md).
