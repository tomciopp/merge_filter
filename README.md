# MergeFilter

MergeFilter is a minimal DSL for filtering ActiveRecord objects. Instead of writing complex branching logic in your controllers, encapsulate that logic into a PORO.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'merge_filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install merge_filter

## Usage
Imagine we have a listings model with a price_cents field. 

Instead of complex branching logic:
``` ruby
  class ListingsController < ApplicationController
    def index 
      if params[:min_price]
        Listing.where("price_cents >= ?", params[:min_price])
      elsif params[:max_price]
        Listing.where("price_cents <= ?", params[:max_price])
      else
        Listing.all
      end
    end
  end
```


Or using multiple scopes:
``` ruby
  class ListingsController < ApplicationController
    def index 
      Listing.all.max_price(params[:max_price).min_price(params[:min_price])
    end
  end
```

Encapsulate your logic in a PORO
``` ruby 
  class ListingFilter
    include MergeFilter
    
    default_scope { Listing.all }
    
    filter_by(:price_cents)
    
    filter_by(:min_price) do |value, scope|
      scope.where("price_cents >= ?", value)
    end
    
    filter_by(:max_price) do |value|
      Listing.where("price_cents <= ?", value)
    end
  end 
  
  class ListingsController < ApplicationController
    def index
      ListingFilter.new(min_price: params[:min_price], max_price: params[:max_price]).records
    end
  end
```

## Notes for including MergeFilter in your project:
  1. Classes that include the MergeFilter module need to implement a single default_scope method that takes a block, and as many filter_by methods as you like. 
  2. The filter_by method takes two arguments. The first is the column which you want to filter by, the second is an optional block which must return an ActiveRecord relation object. If you leave off the block MergeFilter defaults to a `where` query.
  3. To filter records, intitialize your MergeFilter object with a hash. The keys of the hash must correspond to the columns in the filter_by methods. The values get passed into their respective filter_by method.
  4. Call the records method when you want to return the corresponding records from your database.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/merge_filter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
