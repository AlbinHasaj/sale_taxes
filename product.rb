# frozen_string_literal: true

class Product
  attr_accessor :name, :price, :tax_applicable, :imported, :quantity

  def initialize(name:, price:, tax_applicable:, imported:, quantity: 1)
    @name = name
    @price = price
    @tax_applicable = tax_applicable
    @imported = imported
    @quantity = quantity
  end

  def imported?
    @imported
  end

  def tax_applicable?
    @tax_applicable
  end

  def to_s
    "#{quantity} #{imported? ? 'imported ' : ''}#{name}"
  end
end
