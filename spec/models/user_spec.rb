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

    it "fails to create a new user if password is not provided" do
      user = User.new(password: nil)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("cannot be blank")

      user.password = "password"
      user.valid?
      expect(user.errors[password]).not_to include("cannot be blank")
    end

    it "fails to create a new user if password_confirmation is not provided" do
      user = User.new(password_confirmation: nil)
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("cannot be blank")

      user.password_confirmation = "password"
      user.valid?
      expect(user.errors[password_confirmation]).not_to include("cannot be blank")
    end

    it "fails to create a new user if password and password_confirmation do not match" do
      user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "wrongpassword"
      )
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("must match password")

      user.password_confirmation = "password"
      user.valid?
      expect(user.errors[:password_confirmation]).not_to include("must match password")
    end

  end
end
