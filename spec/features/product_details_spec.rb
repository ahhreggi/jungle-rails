require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can click the Details button to view a product's details" do
    # ACT
    visit root_path
    find_link("Details »", href: product_path(Product.first.id)).click

    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_text(Product.first.name).and have_css "article.product-detail", count: 1
  end

  scenario "They can click a product's image or name to view its details" do
    # ACT
    visit root_path
    find_link(Product.first.name, href: product_path(Product.first.id)).click

    # DEBUG/VERIFY
    save_screenshot
    expect(page).to have_text(Product.first.name).and have_css "article.product-detail", count: 1
  end

end
