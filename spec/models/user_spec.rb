require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do

    it "should not save without a first name" do
      user = User.new(first_name: nil, last_name: "Novikov", email: "watsup@yahoo.com", password: "string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "should not save without a last name" do
      user = User.new(first_name: "Artem", last_name: nil, email: "watsup@yahoo.com", password: "string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should not save if password and password confirmations differ" do
      user = User.new(first_name: "Artem", last_name: "Novikov", email: "string", password: "different_string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should not save without an email" do
      user = User.new(first_name: "Artem", last_name: "Novikov", email: 'string_saying_something', password: "string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it "should not save if email is not unique" do
      user = User.new(first_name: "Artem", last_name: "Novikov", email: "blackcrack@gmail.com", password: "string", password_confirmation: "string")
      user.save
      user1 = User.new(first_name: "Hunch", last_name: "Hunchkinson", email: "BLACKCRACK@GMAIL.COM", password: "string1", password_confirmation: "string1")
      user1.save
      expect(user1.errors.full_messages).to include("Email has already been taken")
    end

    it "should not save if number of password characters is less than 4" do
      user = User.new(first_name: "Artem", last_name: "Novikov", email: "blackcrack@gmail.com", password: "ing", password_confirmation: "ing")
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it "should authenticate if password is incorrect" do
      user = User.new(
        first_name: "Artem", 
        last_name: "Novikov", 
        email: "raf@raf.com", 
        password: "12345", 
        password_confirmation: "12345")
      user.save
      
      expect(User.authenticate_with_credentials("raf@raf.com", "12345")).to eql(user)
    end

    it "should save if password has whitespace" do
      user = User.new(
        first_name: "Artem", 
        last_name: "Novikov", 
        email: "raf@raf.com", 
        password: "12345", 
        password_confirmation: "12345")
      user.save
      
      expect(User.authenticate_with_credentials("   raf@raf.com", "12345")).to eql(user)
    end

    it "should save if password has upper and lower case" do
      user = User.new(
        first_name: "Artem", 
        last_name: "Novikov", 
        email: "raf@raf.com", 
        password: "12345", 
        password_confirmation: "12345")
      user.save
      
      expect(User.authenticate_with_credentials("raF@raF.com", "12345")).to eql(user)
    end
    
  end
end
