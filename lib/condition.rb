# frozen_string_literal: true

module Conditions
  class Condition

    def self.call(*args)
      new(*args)
    end

    def check(basket)
      process(basket)
    end

  end

  # condition for checking if product of given id exist n times in the basket
  class ProductExist < Condition

    def initialize(product_id, count)
      @product_id = product_id
      @count = count
    end

    private
    def process(basket)
      # do some basket checkings
      return basket[:products].count{ |p| p[:id]==@product_id } >= @count
    end

  end

  # condition for checking if basket price is over some amout of money
  class TotalBasketAbove < Condition

    def initialize(total_price)
      @total_price = total_price
    end

    private
    def process(basket)
      # do some basket checkings
      return basket[:products].inject(0) { |sum, p| sum + p[:price] } >= @total_price
    end

  end
end
