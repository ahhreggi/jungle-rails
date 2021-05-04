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
      @product.save
      expect(@product.errors.full_messages_for(:name)).to include "Name can't be blank"
    end

    it "fails to save a product if a price is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: nil, quantity: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages_for(:price)).to include "Price can't be blank"
    end

    it "fails to save a product if a quantity is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: 400, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages_for(:quantity)).to include "Quantity can't be blank"
    end

    it "fails to save a product if a category is not specified" do
      @category = Category.create!(name: "Testing")
      @product = Product.new(name: "Pandora's Box", price: 400, quantity: 3, category: nil)
      @product.save
      expect(@product.errors.full_messages_for(:category)).to include "Category can't be blank"
    end

  end

end
