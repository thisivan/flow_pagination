# FlowPagination [![](http://stillmaintained.com/mexpolk/flow_pagination.png)](http://stillmaintained.com/mexpolk/flow_pagination)

FlowPagination link renderer plugin for Mislav's
{WillPaginate}[http://github.com/mislav/will_paginate/tree/master] plugin (Twitter like pagination).

Instead of showing page links, this plugin/gem change the rendering of
WillPaginate to display, at the bottom of the page's records, the "More" button.
And when clicked it will add the next set of records (next page) right below
the previous ones.

## Requirements

* Mislav's {WillPaginate}[http://github.com/mislav/will_paginate] plugin/gem.

## Installation Rails 3

In order to get it working, setup both gems like this:

    gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git', :branch => 'rails3'
    gem 'flow_pagination', :git => 'git://github.com/mexpolk/flow_pagination.git', :branch => 'rails3'

## Installation

I've created a category listing (index action) to give a basic example.

Configure +WillPaginate+ and +FlowPagination+ gems (config/environment.rb):

    Rails::Initializer.run do |config|
        [...]
        config.gem 'mislav-will_paginate', :lib => 'will_paginate',
        :source => 'http://gems.github.com'

        config.gem 'mexpolk-flow_pagination', :lib => 'flow_pagination',
        :source => 'http://gems.github.com'
        [...]
    end

To install these gems type the following rake task:

    rake gems:install

### Install It as a Plugin

    script/plugin install git://github.com/mislav/will_paginate.git
    script/plugin install git://github.com/mexpolk/flow_pagination.git

== Problem with SearchLogic and Nested Hashes as URL parameters in Rails

It seems to be a problem with nested hashes with the url_for helper. When using SearchLogic
or parameters with nested hashes url_for does a pretty bad job:

    url_for(:controller => "posts", :action => "index", :search => { :title => "Flow" })
    => http://localhost:3000/posts?title=Flow

    # Where it should be:

    => http://localhost:3000/posts?search%5Btitle%5D=Flow

To fix this problem you should patch +Hash+ class by adding the following
code in +config/initializers/hash.rb+ to work properly:

    class Hash
        # Flatten a hash into a flat form suitable for an URL.
        # Accepts as an optional parameter an array of names that pretend to be the ancestor key names.
        #
        # Example 1:
        #
        #   { 'animals' => {
        #       'fish' => { 'legs' => 0, 'sound' => 'Blub' }
        #       'cat' => { 'legs' => 4, 'sound' => 'Miaow' }
        #   }.flatten_for_url
        #
        #   # => { 'animals[fish][legs]'  => 0,
        #          'animals[fish][sound]' => 'Blub',
        #          'animals[cat][legs]'   => 4,
        #          'animals[cat][sound]'  => 'Miaow'
        #        }
        #
        # Example 2:
        #
        #   {'color' => 'blue'}.flatten_for_url( %w(world things) )  # => {'world[things][color]' => 'blue'}
        #
        def flatten_for_url(ancestor_names = [])
          flat_hash = Hash.new

          each do |key, value|
            names = Array.new(ancestor_names)
            names << key

            if value.is_a?(Hash)
              flat_hash.merge!(value.flatten_for_url(names))
            else
              flat_key = names.shift.to_s.dup
              names.each do |name|
                flat_key << "[#{name}]"
              end
              flat_key << "[]" if value.is_a?(Array)
              flat_hash[flat_key] = value
            end
          end

          flat_hash
        end
    end

Thanks to Rowan Rodrik for the code (http://blog.bigsmoke.us/2007/02/19/nested-hashes-derail-rails-url-helpers).

## Usage

There's flow_pagination_example[http://github.com/mexpolk/flow_pagination_example/tree/master]
application to see this gem in action.

Enjoy!

## License

Copyright (c) 2009 Iván Torres

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
