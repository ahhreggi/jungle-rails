require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "creates a new user given a first & last name, email, password, and valid password confirmation" do
      user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to be_valid
    end

  end
end
