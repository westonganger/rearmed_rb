# Rearmed Ruby <a href='https://travis-ci.org/westonganger/rearmed-rb' target='_blank'><img src='https://api.travis-ci.org/westonganger/rearmed-rb.svg?branch=master' border='0' alt='Build Status' /></a> 

<a href='https://ko-fi.com/A5071NK' target='_blank'><img height='32' style='border:0px;height:32px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=a' border='0' alt='Buy Me a Coffee' /></a> 

A collection of helpful methods and monkey patches for Arrays, Hash, Enumerables, Strings, Objects & Dates in Ruby. [Rearmed is a collection of plugins](https://github.com/westonganger?utf8=%E2%9C%93&tab=repositories&q=rearmed) which are driven by making life easier & coding more natural.

The difference between this library and others is that all monkey patching is performed in an opt-in way because you shouldnt be using methods you dont know about anyways. 

When possible I have placed the method implementations inside the Rearmed module so if you don't like monkey patching or are working on the project with a team then you can use these methods instead. You can then skip the config and see how to use each implementation below the relevant methods documentation.


# Install

Add the following line to your gemfile:
```ruby
gem 'rearmed'
```

# Usage

## Enable Monkey Patches (all are opt-in)

```ruby
# config/initializers/rearmed.rb

Rearmed.enabled_patches = {
  array: {
    dig: false,
    delete_first: false,
    not_empty: false
  },
  date: {
    now: false
  },
  enumerable: {
    natural_sort: false,
    natural_sort_by: false,
    select_map: false
  },
  hash: {
    compact: false,
    dig: false,
    join: false,
    only: false,
    to_struct: false
  },
  object: {
    in: false,
    not_nil: false
  },
  string: {
    begins_with: false,
    casecmp?: false,
    ends_with: false,
    starts_with: false,
    to_bool: false,
    valid_float: false,
    valid_integer: false
  }
}


require 'rearmed/apply_patches'
```

## Array Methods
```ruby
array = [1,2,1,4,1]
array.delete_first(1) # => 1
puts array #=> [2,1,4,1]
array.delete_first{|x| 1 == x} # => 1
puts array # => [2,4,1]
array.delete_first # => 2
puts array # => [4,1]

array.not_empty? # => true

# Only monkey patched if using Ruby 2.2.x or below as this method was added to Ruby core in 2.3.0
items = [{foo: ['foo','bar']}, {test: 'thing'}]
items.dig(0, :foo, 1) # => 'bar'
# or without monkey patch: Rearmed.dig(items, 0, :foo, 1)
```

## Enumerable Methods (Array, Hash, etc.)
```ruby
items = ['1.1', '1.11', '1.2']
items.natural_sort 
items.natural_sort(reverse: true) # because natural_sort does not accept a block, accepting PR's on this
# or without monkey patch: Rearmed.natural_sort(items) or Rearmed.natural_sort(items, reverse: true)

items = [{version: "1.1"}, {version: "1.11"}, {version: "1.2"}]
items.natural_sort_by{|x| x[:version]} 
# or without monkey patch: Rearmed.natural_sort_by(items){|x| x[:version]}

items = [{version: "1.1"}, {version: nil}, {version: false}]
items.select_map{|x| x[:version]} #=> [{version: "1.1"}]
# or without monkey patch: Rearmed.select_map(items){|x| x[:version]}
```

## Date
```ruby
Date.now
```

## Hash Methods
```ruby
hash.join{|k,v| "#{k}: #{v}\n"}

hash = {foo: 'foo', bar: 'bar', other: 'other'}
hash.only(:foo, :bar) # => {foo: 'foo'}
# or without monkey patch: Rearmed.hash_only(hash, :foo, :bar)

hash.only!(:foo, :bar)

hash.to_struct
# or without monkey patch: Rearmed.hash_to_struct(hash)

# Only monkey patched if using Ruby 2.2.x or below as this method was added to Ruby core in 2.3.0
items = [{foo: ['foo','bar']}, {test: 'thing'}]
items.dig(0, :foo, 1) # => 'bar'
# or without monkey patch: Rearmed.dig(items, 0, :foo, 1)

# Only monkey patched if using Ruby 2.3.x or below as this method was added to Ruby core in 2.4.0
hash.compact
# or without monkey patch: Rearmed.hash_compact(hash)
hash.compact!
```

## Object
```ruby
my_var.not_nil?

# Only monkey patched if not using ActiveSupport / Rails as this method is already defined there
my_var.in?([1,2,3])
my_var.in?(1,2,3) # or with splat arguments
```

## String
```ruby
'123'.valid_integer?
# or without monkey patch: Rearmed.valid_integer?('123')

'123.123'.valid_float? 
# or without monkey patch: Rearmed.valid_float?('123.123')

'true'.to_bool 
# or without monkey patch: Rearmed.to_bool('true')

# alias of start_with? and end_with? to have more sensible method names
'foo'.starts_with?('fo') # => true
'foo'.begins_with?('fo') # => true
'bar'.ends_with?('ar') # => true

# Only monkey patched if using Ruby 2.3.x or below as this method was added to Ruby core in 2.4.0
'foo'.casecmp?('FOO') #=> true
'foo'.casecmp?('FOOBAR') #=> false
# or without monkey patch: Rearmed.casecmp?('foo', 'FOO')
```

# Contributing / Todo
If you want to request a method please raise an issue and we can discuss the implementation. 

If you want to contribute here are a couple of things you could do:

- Get the `natural_sort` method to accept a block


# Credits
Created by Weston Ganger - [@westonganger](https://github.com/westonganger)

For any consulting or contract work please contact me via my company website: [Solid Foundation Web Development](https://solidfoundationwebdev.com)

## Similar Libraries Created By Me
- [Rearmed Rails](https://github.com/westonganger/rearmed_rails)
- [Rearmed-JS](https://github.com/westonganger/rearmed-js)
- [Rearmed-CSS](https://github.com/westonganger/rearmed-css)
