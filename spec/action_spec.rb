# frozen_string_literal: true

require 'action'
require 'product'

RSpec.describe Actions::Action do
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

  describe 'ChangeProductPrice' do
    it 'changes prices for 3 "A" products to 10' do
      action = Actions::ChangeProductPrice.call('A', 3, 10)
      action.perform(basket)

      expect(basket[:products][0][:price]).to be 10
      expect(basket[:products][1][:price]).to be 10
      expect(basket[:products][2][:price]).to be 10
    end
  end

  describe 'ChangeTotalPriceByFactor' do
    before do
      @action = Actions::ChangeTotalPriceByFactor.call(0.8)
    end

    it 'adds modifier to total_mods array' do
      expect { @action.perform(basket) }.to change { basket[:total_mods].count }.by(1)
    end

    it 'adds by factor type modifier to total_mods array' do
      @action.perform(basket)
      expect(basket[:total_mods].last[:type]).to eq 'factor'
    end
  end

  describe 'ChangeTotalPriceByValue' do
    before do
      @action = Actions::ChangeTotalPriceByValue.call(0.8)
    end

    it 'adds modifier to total_mods array' do
      expect { @action.perform(basket) }.to change { basket[:total_mods].count }.by(1)
    end

    it 'adds by factor type modifier to total_mods array' do
      @action.perform(basket)
      expect(basket[:total_mods].last[:type]).to eq 'value'
    end
  end
end
