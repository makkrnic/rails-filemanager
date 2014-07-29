# RailsFilemanager


RailsFilemanager ajax is a mountable engine aiming to provide simple integration with existing application needing a file manager.

Currently it supports file owners and owners' maximum storage space. The files are organized in a tree-like structure.

**NOTE**: As this gem is in active development, this readme is given primarily as a reminder for myself since most of the stuff described will change daily.

## Instalation

Add this line to your Gemfile

```ruby
gem 'rails-filemanager-ajax', git: "https://github.com/makkrnic/rails-filemanager-ajax.git"
```
  
Mount the engine

```ruby
mount RailsFilemanager::Engine => "/rails_filemanager"
```
    
Run the migrations

```ruby
bundle exec rake rails_filemanager:install:migrations
bundle exec rake db:migrate
```

In the `ApplicationController` define the method `current_owner`. **This will change in the future.**

An example of such method is:
```ruby
def current_owner
    Owner.find_by params[:owner_id]
end
```

In the model you want to be owner of files add the following snippet:

```ruby
include RailsFilemanager::ActsAsFilemanagerOwner

acts_as_filemanager_owner storage_limit_method: :my_method
```

And, of course, define the method you want to use.


## TODO
* user authorization
* tests
