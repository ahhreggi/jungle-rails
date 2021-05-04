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

    it "fails to create a new user if first name is not provided" do
      @user = User.new(
        first_name: nil,
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:first_name)).to include "First name can't be blank"
    end

    it "fails to create a new user if last name is not provided" do
      @user = User.new(
        first_name: "Reggi",
        last_name: nil,
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:last_name)).to include "Last name can't be blank"
    end

    it "fails to create a new user if email is not provided" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: nil,
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:email)).to include "Email can't be blank"
    end

    it "fails to create a new user if the given email is already taken (exact match)" do
      @user1 = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user1.save
      @user2 = User.new(
        first_name: "Reggi2",
        last_name: "Sirilan2",
        email: "rs@rs.ca",
        password: "password2",
        password_confirmation: "password2"
      )
      @user2.save
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages_for(:email)).to include("Email has already been taken")
    end

    it "fails to create a new user if the given email is already taken (case insensitive)" do
      @user1 = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user1.save
      @user2 = User.new(
        first_name: "Reggi2",
        last_name: "Sirilan2",
        email: "RS@RS.CA",
        password: "password2",
        password_confirmation: "password2"
      )
      @user2.save
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages_for(:email)).to include("Email has already been taken")
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
      expect(@user.errors.full_messages_for(:password)).to include "Password can't be blank"
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
      expect(@user.errors.full_messages_for(:password_confirmation)).to include "Password confirmation can't be blank"
    end

    it "fails to create a new user if password and password_confirmation do not match" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "wrongpassword"
      )
      @user.save
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password_confirmation)).to include "Password confirmation doesn't match Password"
    end

    it "fails to create a new user if password is too short (< 8 characters)" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "pass",
        password_confirmation: "pass"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages_for(:password)).to include "Password is too short (minimum is 8 characters)"
    end

  end

  describe '.authenticate_with_credentials' do

    it "returns nil if authentication is unsuccessful" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      @result = User.authenticate_with_credentials("rs@rs.ca", "wrongpassword")
      expect(@result).to eq nil
    end

    it "returns a user instance if authentication is successful (exact match)" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      @result = User.authenticate_with_credentials("rs@rs.ca", "password")
      expect(@result).to eq @user
    end

    it "returns a user instance if authentication is successful (email case-insensitive)" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      @result = User.authenticate_with_credentials("RS@RS.CA", "password")
      expect(@result).to eq @user
    end

    it "returns a user instance if authentication is successful (email includes whitespace)" do
      @user = User.new(
        first_name: "Reggi",
        last_name: "Sirilan",
        email: "rs@rs.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      @result = User.authenticate_with_credentials(" rs@rs.ca ", "password")
      expect(@result).to eq @user
    end

  end

end
