require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "create" do

    it "should be able to be created if valid" do
      expect(user).to be_valid
    end

    it "should have a default username picked up from the email address" do
      expect(user.username).to eq("joe_doe")
    end
  end
end
