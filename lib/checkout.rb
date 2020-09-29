# frozen_string_literal: true

class Checkout

  def initialize(rules=[])
    @products = []
    @rules = rules
  end

  def scan(product)
    @products.push(product)
  end

  def total
    create_basket

    @rules.each do |rule|
      check_rule(rule)
    end

    # count basket
    # count products in basket
    total = @basket[:products].inject(0) { |sum, p| sum + p[:price] }
    # count total discouts
    @basket[:total_mods].inject(total) do |sum, mod|
      if mod[:type] == 'factor'
        next sum * mod[:value]
      end
      if mod[:type] == 'value'
        next sum + mod[:value]
      end
    end
 end

  def create_basket
    @basket = {
      total_mods: [],
      products: @products.map { |product| { id: product.id, price: product.price, modified: false } }
    }
  end

  def check_rule(rule)
    rule.call(@basket)
  end

  def products_count
    @products.count
  end

end
