# frozen_string_literal: true

class Product
  attr_reader :id, :price

  def initialize(id, price)
    @id = id
    @price = price
  end
end
