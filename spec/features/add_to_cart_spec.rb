require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

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

  scenario "They can add an item to 'My Cart' and see the item counter increment by 1" do
    # ACT
    visit root_path
    page.first("form.button_to").find_button("Add").click

    # DEBUG/VERIFY
    save_screenshot
    expect(page.find "nav").to have_text "My Cart (1)"
  end

end
