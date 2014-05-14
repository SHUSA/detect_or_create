# DetectOrCreate

Rails 2.3.9 introduces a change which makes find_or_create_by unusable
with a hash as an argument. This gem gives similar functionality, with
the added ability to overwrite the existing record that is found.

## Installation

Add this line to your application's Gemfile:

    gem 'detect_or_create'

Add after the Rails::Initializer block:

    require 'detect_or_create'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install detect_or_create

## Usage

Find user with email "user@domain.com" or create a new user with that
email and additional attributes:

```
User.detect_or_create(:by => { :email => "user@domain.com" },
                      :with => { :name => "User", :active => true })

```

Just including the `by` argument will also work if you don't need
additional attributes.

```
User.detect_or_create(:by => { :email => "user@domain.com" })
```

You can also modify what was found:

```
User.detect_or_create(:by => { :email => "user@domain.com" },
                      :with => { :name => "Domain User 1",
                                 :email => "user1@domain.com"},
                      :overwrite_existing => true)
```

## Run specs


    $ rspec spec/detect_or_create_spec.rb


## Contributing

1. Fork it ( http://github.com/SHUSA/detect_or_create/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
