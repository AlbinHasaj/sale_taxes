# frozen_string_literal: true

class Basket
  attr_accessor :products

  def initialize(products:)
    @products = products
  end

  def size
    @products.size
  end

  def pop
    @products.pop
  end
end
