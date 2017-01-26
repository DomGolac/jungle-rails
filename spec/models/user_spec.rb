require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    
    it 'should have a valid test' do
      @user = User.new(first_name: 'Frank', last_name: 'Rickard', email: 'frank_rickard@gmail.com', 
                        password: 'frank1', password_confirmation: 'frank1')
      expect(@user).to be_valid
    end

    it 'should be invalid without a matching password confirmation' do
      @user = User.new(first_name: 'Frank', last_name: 'Rickard', email: 'frank_rickard@gmail.com', 
                        password: 'frank0', password_confirmation: 'frank1')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should have a unique email address' do
      @user = User.new(first_name: 'Frank', last_name: 'Rickard', email: 'frank_rickard@gmail.com', 
                        password: 'frank1', password_confirmation: 'frank1')
      @user2 = User.new(first_name: 'Frank', last_name: 'Rickard', email: 'FRANK_RICKARD@GMAIL.COM', 
                        password: 'frank1', password_confirmation: 'frank1')
      @user.save!
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should include a first name' do
      @user = User.new(first_name: nil, last_name: 'Rickard', email: 'frank_rickard@gmail.com', 
                        password: 'frank1', password_confirmation: 'frank1')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'should include a last name' do
      @user = User.new(first_name: 'Frank', last_name: nil, email: 'frank_rickard@gmail.com', 
                        password: 'frank1', password_confirmation: 'frank1')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Last name can't be blank"    
    end

    it 'should include an email address' do
      @user = User.new(first_name: 'Frank', last_name: 'Rickard', email: nil, 
                        password: 'frank1', password_confirmation: 'frank1')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'should include a password with minimum 6 characters' do
      @user = User.new(first_name: 'Frank', last_name: 'Rickard', email: 'frank_rickard@gmail.com', 
                        password: 'frank', password_confirmation: 'frank')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end

  end

  describe '.authenticate_with_credentials' do
    
    before :each do
      @user = User.new(first_name: 'Frank', last_name: 'Rickard', email: 'FrAnK_rIcKaRd@GmAiL.cOm', 
                        password: 'frankie', password_confirmation: 'frankie')
      @user.save!
    end

    it 'should return a truthy value' do
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to be_truthy
    end

    it 'should return a truthy value' do
      expect(User.authenticate_with_credentials(' frank_rickard@gmail.com ', @user.password)).to be_truthy
    end

    it 'should return a truthy value' do
      expect(User.authenticate_with_credentials(' fRaNk_RiCkArD@gMaIl.CoM ', @user.password)).to be_truthy
    end

  end

end
