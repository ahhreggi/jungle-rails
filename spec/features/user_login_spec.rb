require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    User.create!(
      first_name: 'Reggi',
      last_name: 'Sirilan',
      email: 'rs@rs.ca',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  scenario "Visitor is signed in after logging in with valid credentials" do
    # ACT
    visit login_path
    fill_in "email", with: "rs@rs.ca"
    fill_in "password", with: "password"
    click_button("Submit")

    # DEBUG/VERIFY
    save_screenshot
    expect(page).to have_content("Signed in as Reggi")
  end

  scenario "Visitor is redirected to the Products (home) page after signing in" do
    # ACT
    visit login_path
    fill_in "email", with: "rs@rs.ca"
    fill_in "password", with: "password"
    click_button("Submit")

    # DEBUG/VERIFY
    save_screenshot
    expect(page).to have_content("Products")
  end

end
