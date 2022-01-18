# frozen_string_literal: true

class Store
  attr_accessor :basket, :total, :total_sales_tax, :receipt

  def initialize(basket:)
    @basket = basket
    @total = 0
    @total_sales_tax = 0
    @receipt = ''
  end

  def tax_rate_to_apply(product:)
    rate = 0

    rate += 10 if product.tax_applicable?
    rate += 5 if product.imported?

    rate
  end

  def calculate_tax(product:)
    tax_rate = tax_rate_to_apply(product: product)

    ((tax_rate * product.price / 100) * 20).ceil / 20.0
  end

  def add_product_to_receipt(product:, tax:)
    @receipt += "#{product} : #{format('%.2f', product.price + tax)} "
  end

  def formatted_tax
    format('%.2f', @total_sales_tax)
  end

  def formatted_total
    format('%.2f', @total)
  end

  def print_receipt
    p "#{@receipt}Sales Taxes: #{formatted_tax} Total: #{formatted_total}"
  end

  def check_out!
    @basket.size.times do
      product = @basket.pop

      sales_tax = calculate_tax(product: product) * product.quantity

      @total += sales_tax + (product.quantity * product.price)
      @total_sales_tax += sales_tax

      add_product_to_receipt(product: product, tax: sales_tax)
    end

    print_receipt
  end
end
