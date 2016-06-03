# Rearmed Ruby
<a href='https://ko-fi.com/A5071NK' target='_blank'><img height='32' style='border:0px;height:32px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=a' border='0' alt='Buy Me a Coffee' /></a> 

A collection of helpful methods and monkey patches for Objects, Strings, Enumerables, Arrays, Hash, Dates, & Rails


Rearmed uses an opt-in way of monkey patching. Run `rails g rearmed:setup` to create a settings files in `config/initializers/rearmed.rb` where you can opt-in to the monkey patches available in the library. Set these values to true if you want to enable the applicable monkey patch

```ruby
# config/initializers/rearmed.rb

Rearmed.module_eval do
  const_set('ENABLED', {
    rails_4: {
      or: false,
      link_to_confirm: false,
      find_relation_each: false,
      find_in_relation_batches: false,
    },
    rails_3: {
      hash_compact: false,
      pluck: false,
      update_columns: false,
      all: false,
    },
    string: {
      to_bool: false,
      valid_integer: false,
      valid_float: false
    },
    hash: {
      only: false,
      dig: false
    },
    array: {
      index_all: false,
      find: false,
      dig: false,
      delete_first: false
    },
    enumerable: {
      natural_sort: false,
      natural_sort_by: false
    },
    object: {
      in: false,
      not_nil: false
    },
    date: {
      now: false
    }
  }
end

Rearmed.require_folder 'rearmed'
```

### Rearmed Methods
```ruby
Rearmed.naturalize_str(my_string) # used in the natural sorting methods
Rearmed.dig(hash_or_array, 1, :key, 2) # dig for either array or hash
```

### Object
```ruby
my_var.not_nil?
my_var.in?([1,2,3])
my_var.in?(1,2,3) # or with splat arguments
```

### String
```ruby
'123'.valid_integer?
'123.123'.valid_float?
'true'.to_bool
```

### Date
```ruby
Date.now
```

### Enumerable Methods (Array, Hash, etc.)
```ruby
['1.1', '1.11', '1.2'].natural_sort
['1.1', '1.11', '1.2'].natural_sort{|a,b| b <=> a}
[{version: "1.1"}, {version: "1.11"}, {version: "1.2"}].natural_sort_by{|x| x[:version]}

# Only available on array and hash in Ruby 2.2.x or below
[{foo: ['foo','bar']}, {test: 'thing'}].dig(1, :foo, 2) # => 'bar'
```

### Array Methods
```ruby
[1.1, 1.11, 1.2].find(1.11) # returns my_value if found
[1,2,1,2,1].index_all(1) # => [0,2,4]

array = [1,2,1,4,1]
array.delete_first(1) # => 1
puts array #=> [2,1,4,1]
array.delete_first{|x| 1 == x} # => 1
puts array # => [2,4,1]
```

### Hash Methods
```ruby
{foo: 'foo', bar: 'bar'}.only(:foo) # => {foo: 'foo'}
{foo: 'foo', bar: 'bar'}.only!(:bar)
```

### Rails

##### Rails 3.x Backports
```ruby
my_hash.compact
my_hash.compact!
Post.all # Now returns AR relation
Post.first.update_columns(a: 'foo', b: 'bar')
Post.pluck(:name, :id) # adds multi column pluck support ex. => [['first', 1], ['second', 2], ['third', 3]]
```


##### Rails 4.x Backports & Additional Methods
```ruby
Post.where(name: 'foo').or.where(content: 'bar')
= link_to 'Delete', post_path(post), method: :delete, confirm: "Are you sure you want to delete this post?" #returns rails 3 behaviour of allowing confirm attribute as well as data-confirm
Post.find_in_relation_batches # this returns a relation instead of an array
Post.find_relation_each # this returns a relation instead of an array
```

# Credits
Created by Weston Ganger - @westonganger

<a href='https://ko-fi.com/A5071NK' target='_blank'><img height='32' style='border:0px;height:32px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=a' border='0' alt='Buy Me a Coffee' /></a> 
