require 'rails_helper'

RSpec.describe User, :type => :model do
    it "is valid with valid attributes" do
        user = User.new(name:"ds", username: "saa", password: "1234", email:"ss@erf.fg", address:"asdcfg")
        expect(user).to be_valid
      end
    
      it "is not valid without username" do
        user = User.new(name:"ds", username: nil, password: "1234", email:"ss@erf.fg", address:"asdcfg")
        expect(user).to_not be_valid
      end
    
      it "is not valid without a valid email" do
        # User.create(name: "John Doe", email: "john@example.com", password: "password")
        user = User.new(name:"ds", username: "saa", password: "1234", email:"ss@erf", address:"asdcfg")
        expect(user).to_not be_valid
      end

      it "is not valid without password" do
        user = User.new(name:"ds", username: "saa", password: nil, email:"ss@erf.fg", address:"asdcfg")
        expect(user).to_not be_valid
      end

      it "is not valid without email" do
        user = User.new(name:"ds", username: "saa", password: "1234", email:nil, address:"asdcfg")
        expect(user).to_not be_valid
      end

      it "is valid without non mandatory fields" do
        user = User.new(name:"ds", username: "saa", password: "1234", email:"aaa@aa.c", address:"asdcfg", credit_card_number:"1234567890123456", phone_number:"1234567890")
        expect(user).to be_valid
      end
end
