# frozen_string_literal: true

module Actions
  class Action

    def self.call(*args)
      new(*args)
    end

    def perform(basket)
      process(basket)
    end

  end

  # action for modifying price of selected products
  class ChangeProductPrice < Action

    def initialize(product_id, count, price, apply_to_modified = false)
      @product_id = product_id
      @count = count
      @price = price
      @apply_to_modified = apply_to_modified
    end

    private

    def process(basket)
      # do some basket checkings
      if @apply_to_modified
        products = basket[:products].select { |p| p[:id] == @product_id }
      else
        products = basket[:products].select { |p| p[:id] == @product_id && p[:modified] != true }
      end
      products[0..@count].each do |p|
        p[:modified] = true
        p[:price] = @price
      end
    end

  end

  # action for modifying total price by a factor
  class ChangeTotalPriceByFactor < Action

    def initialize(factor)
      @factor = factor
    end

    private

    def process(basket)
      # add total modifier
      basket[:total_mods].push({
        type: 'factor',
        value: @factor
      })
    end

  end

  # action for modifying total price by a factor
  class ChangeTotalPriceByValue < Action

    def initialize(value)
      @value = value
    end

    private

    def process(basket)
      # add total modifier
      basket[:total_mods].push({
        type: 'value',
        value: @value
      })
    end

  end
end

