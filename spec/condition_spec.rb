# frozen_string_literal: true

require 'condition'
require 'product'

RSpec.describe Conditions::Condition do
  let(:product_a1) { Product.new('A', 20) }
  let(:product_a2) { Product.new('A', 20) }
  let(:product_a3) { Product.new('A', 20) }
  let(:product_b1) { Product.new('B', 40) }
  let(:product_c1) { Product.new('C', 50) }
  let(:products) { [product_a1, product_a2, product_a3, product_b1, product_c1] }
  let(:basket) do
    {
      total_mods: [],
      products: products.map { |product| { id: product.id, price: product.price, modified: false } }
    }
  end

  describe 'ProductExist' do
    it 'returns true for 3 products with id "A" in the basket' do
      condition = Conditions::ProductExist.call('A', 3)

      expect(condition.check(basket)).to be true
    end
  end

  describe 'TotalBasketAbove' do
    it 'returns true for basket value above 100' do
      condition = Conditions::TotalBasketAbove.call(100)

      expect(condition.check(basket)).to be true
    end
  end
end

