require "nimbleshop_google_analytics/version"
require "nimbleshop_google_analytics/railtie"
require 'gabba'

#require 'net-http-spy'

module NimbleshopGoogleAnalytics
  extend ActiveSupport::Autoload

  autoload :Handler
end
