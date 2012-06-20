 module NimbleshopGoogleAnalytics
  class  Handler

    attr_accessor :order, :shop, :tracking_id, :payload, :errors

    def initialize(payload, shop)
      @payload = payload
      @order  = Order.find_by_number(payload[:order_number])
      @shop = shop
      @errors = []
    end

    def perform
      return if Rails.env.test?

      validations
      if errors.empty?
        Rails.logger.info "sending data to google analytics server"
        send_data
      else
        Rails.logger.info errors.to_sentence
      end
    end

    def send_data
      # TODO  remove hardcoded www.nimbleshop.net
      g = ::Gabba::Gabba.new(tracking_id, "www.nimbleshop.net")

      order.line_items.each do |line_item|
        g.add_item( order.number,                # order number
                    line_item.product.permalink, # item SKU
                    line_item.product_price,     # item price
                    line_item.quantity,          # item quantity
                    line_item.product.name,      # item name
                  )
      end

      g.transaction( order.number,                        # order number
                     order.line_items_total,              # line items total
                     shop.name,                           # shop name
                     order.tax,                           # tax
                     order.shipping_method.shipping_cost, # shipping cost
                     order.shipping_address.city,         # city
                     order.shipping_address.state_name,   # region
                     order.shipping_address.country_name, # country
                       )
    end

    def validations
      ensure_google_analytics_tracking_id if errors.empty?
      ensure_valid_order_number if errors.empty?
      ensure_shipping_method if errors.empty?
      ensure_shipping_address if errors.empty?
    end

    def ensure_shipping_address
      unless order.shipping_address
        errors << "Order #{order.number} does not have shipping address. Transaction info will not be posted to google analytics"
      end
    end

    def ensure_shipping_method
      unless order.shipping_method
        errors << "Order #{order.number} does not have shipping method. Transaction info will not be posted to google analytics"
      end
    end

    def ensure_google_analytics_tracking_id
      if tracking_id = shop.google_analytics_tracking_id
        @tracking_id = tracking_id
      else
        errors << "Shop does not have google analytics traking id. Transaction info will not be posted to google analytics"
      end
    end

    def ensure_valid_order_number
      unless order
        errors << "No order is found for order number #{payload[:order_number]}. Transaction info will not be posted to google analytics"
      end
    end
  end

end
