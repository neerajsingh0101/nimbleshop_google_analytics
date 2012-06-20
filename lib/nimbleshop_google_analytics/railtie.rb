module NimbleshopGoogleAnalytics
  class Railtie < ::Rails::Railtie

    initializer "nimbleshop_google_analytics.consume_notifications" do
      ActiveSupport::Notifications.subscribe "order.purchased" do |name, start, finish, id, payload|
        Handler.new(payload, Shop.first).perform
      end
    end

  end
end
