require 'checkout'

RSpec.describe Checkout do

  # describe 'total' do
  #   it 'calculates total cost of all products in checkout' do
  #     expect(Checkout.new.total).to eq 200
  #   end
  # end

  describe 'scan' do
    let(:product) { { item: 'A', price: 30 } }

    it 'adds product do product list in the checkout' do
      checkout = Checkout.new
      checkout.scan(product)
      expect(checkout.products_count).to eq 1
    end
  end

end
