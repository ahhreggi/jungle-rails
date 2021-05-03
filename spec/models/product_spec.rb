require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "saves a product given a name, price, quantity, and category" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: 400, quantity: 3, category: @category)
      expect(@product.save!).to eq true
    end

    it "fails to save a product if a name is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: nil, price: 400, quantity: 3, category: @category)
      expect(@product.errors.full_messages_for(:name)).to include "Name cannot be nil"
    end

    it "fails to save a product if a price is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: nil, quantity: 3, category: @category)
      expect(@product.errors.full_messages_for(:price)).to include "Price cannot be nil"
    end

    it "fails to save a product if a quantity is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: 400, quantity: nil, category: @category)
      expect(@product.errors.full_messages_for(:quantity)).to include "Quantity cannot be nil"
    end

    it "fails to save a product if a category is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: 400, quantity: 3, category: nil)
      expect(@product.errors.full_messages_for(:category)).to include "Category cannot be nil"
    end

  end
end
