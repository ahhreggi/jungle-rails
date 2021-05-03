require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "creates a new user given a first & last name, email, password, and valid password confirmation" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to be_valid
    end

    it "fails to create a new user if password is not provided" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: nil,
        password_confirmation: "password"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password)).to include "Password cannot be blank"
    end

    it "fails to create a new user if password_confirmation is not provided" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: nil
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password_confirmation)).to include "Password confirmation cannot be blank"
    end

    it "fails to create a new user if password and password_confirmation do not match" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "wrongpassword"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password_confirmation)).to include "Password and confirmation must match"
    end

    it "fails to create a new user if the given email is already taken" do
      @user1 = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user2 = User.new(
        first_name: "Reggi2",
        last_name: "Sirilan2",
        email: "rs@rs.ca",
        password: "password2",
        password_confirmation: "password2"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:email)).to include("Email has already been taken")
    end

  end
end
