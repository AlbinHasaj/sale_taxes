require 'json'
require_relative '../product'
require_relative '../basket'
require_relative '../store'

RSpec.describe 'PROBLEM TWO: SALES TAXES' do
  let(:examples) do
    file = File.read('./baskets.json')
    baskets = JSON.parse(file)

    baskets.map do |results, basket|
      products = basket.map do |product|
        Product.new(product.transform_keys(&:to_sym))
      end

      { results: results, basket: Basket.new(products: products) }
    end
  end

  let(:product) do
    Product.new(
      name: 'bottle of perfume',
      price: 27.99,
      tax_applicable: true,
      imported: true
    )
  end

  it 'rounds up the sales tax to the nearest 0.05' do
    store = Store.new(basket: [])

    expect(store.calculate_tax(product: product)).to eq(4.2)
  end

  it 'correctly adds the sales tax to the total sum' do
    store = Store.new(basket: [product])

    store.check_out!

    expect(store.total).to eq(32.19)
  end

  context 'given the inputs from github repo' do
    it 'correctly calculates the total and the total sales tax' do
      examples.each do |example|
        store = Store.new(basket: example[:basket])

        store.check_out!

        expect(store.formatted_total.to_f).to eq(example[:results]['total'])
        expect(store.formatted_tax.to_f).to eq(example[:results]['sales_tax'])
      end
    end
  end
end
