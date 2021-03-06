[![Build Status](https://secure.travis-ci.org/mberube/open-config.png)](http://travis-ci.org/mberube/open-config)

Configuration class that allows values to reference other values.

Examples:

config.configure { |c| c.set :url, 'http://127.0.0.1' }
config.url => '127.0.0.1'

config.configure { |c| c.set 'abc.def', 'value' }
config.abc.def => 'value'

config.configure do |c|
  c.set(:home_url) {'http://127.0.0.1'}
  c.set(:settings_url) {"#{config.home_url}/settings.html"}
end
config.settings_url => "http://127.0.0.1/settings.html"

See other examples in the spec.
