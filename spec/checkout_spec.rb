# frozen_string_literal: true

require 'checkout'
require 'product'
require 'condition'
require 'action'
require 'rule'

RSpec.describe Checkout do
  let(:product_a1) { Product.new('A', 20) }
  let(:product_a2) { Product.new('A', 20) }
  let(:product_a3) { Product.new('A', 20) }
  let(:product_b1) { Product.new('B', 40) }
  let(:product_c1) { Product.new('C', 50) }

  describe 'scan' do
    it 'adds product do product list in the checkout' do
      checkout = Checkout.new
      checkout.scan(product_a1)
      expect(checkout.products_count).to eq 1
    end
  end

  describe 'total' do
    context 'if there are no rules' do
      before do
        @checkout = Checkout.new
        @checkout.scan(product_a1)
        @checkout.scan(product_a2)
        @checkout.scan(product_a3)
        @checkout.scan(product_b1)
        @checkout.scan(product_c1)
      end
      it 'counts total value of products' do
        expect(@checkout.total).to eq 150
      end
    end

    context 'if there are rules' do
      before do
        rules = [
          Rule.new([Conditions::ProductExist.call('A', 3)], [Actions::ChangeProductPrice.call('A', 3, 10)]),
          Rule.new([Conditions::TotalBasketAbove.call(80)], [Actions::ChangeTotalPriceByFactor.call(0.8)])
        ]
        @checkout = Checkout.new(rules)
        @checkout.scan(product_a1)
        @checkout.scan(product_a2)
        @checkout.scan(product_a3)
        @checkout.scan(product_b1)
        @checkout.scan(product_c1)
      end

      it 'couts value of product considering rules' do
        expect(@checkout.total).to eq 96
      end
    end
  end
end
