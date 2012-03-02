# Straides [![Build Status](https://secure.travis-ci.org/kevgo/straides.png)](https://secure.travis-ci.org/kevgo/straides.png)

Better HTTP STatus coDES for RAIls!

Straides provides a convenient and more consistent way for handling error conditions
in controllers. It makes it possible, for example, to abort execution of a request in a before_filter.

# Installation

1.  Add the gem to your Gemfile.

    ```ruby
    gem 'straides'
    ```

2.  Update your gem bundle.

    ```bash
    $ bundle install
    ```


# Usage

Straides provides a helper method called `error`. Call it at any time with the HTTP error code
and optionally additional parameters for `render` to abort the current request and render an
error message.

```ruby
# Stop controller execution and return the request with the given HTTP error.
error 404 unless [condition]

# Abort with an error if an operation didn't return a result.
user = User.find_by_username(params[:id]) or error 401
```


## Customizing the response

Straides returns reasonable default responses dependent on the request format.

* If the request returns HTML, it renders `public/[error code].html`, similar to what Rails does.
* If the request returns JSON, it leaves the response body empty by default.

These behaviors can be customized by providing the call to `error` with the same parameters
as you would give to [render](http://apidock.com/rails/ActionController/Base/render) in Rails.

```ruby
# Provide a custom error message in the response body.
error 401, :text => 'Please log in first.'

# Render a different file in the response body.
error 404, :file => 'public/custom_404.html'

# Render a custom JSON response.
error 401, :json => { :code => 401, :message => 'Please log in first.' }
```


# Customizing Straides

Straides can be configured by creating an initializer file at _config/initializers/straides.rb_.

```ruby
Straides.configure do |config|

  # Disable auto-loading of Straides into every controller.
  config.auto_load = false
end
```


## Auto-loading

Straides loads the `error` helper method by default into every controller.
If you don't want that, for example because you only want to use Straides in certain controllers,
you can disable this auto-loading behavior with `config.auto_load = false`.
Please note that you then have to include Straides into every controller manually, like this:

```ruby
class FooController < ApplicationController
  include Straides

  ...
end
```
