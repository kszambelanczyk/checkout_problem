$LOAD_PATH << './lib'
require 'checkout'
require 'rule'
require 'condition'
require 'product'
require 'action'

# create products
product_a1 = Product.new('A', 20)
product_a2 = Product.new('A', 20)
product_a3 = Product.new('A', 20)
product_b = Product.new('B', 30)
product_c = Product.new('C', 40)

# create checkout rule
rules = [
  Rule.new([Conditions::ProductExist.call('A', 3)], [Actions::ChangeProductPrice.call('A', 3, 10)]),
  Rule.new([Conditions::TotalBasketAbove.call(80)], [Actions::ChangeTotalPriceByFactor.call(0.8)])
]

checkout = Checkout.new(rules)

checkout.scan(product_a1)
checkout.scan(product_a2)
checkout.scan(product_a3)
checkout.scan(product_b)
checkout.scan(product_c)

puts checkout.total

