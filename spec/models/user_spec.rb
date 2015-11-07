require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:workspaces).inverse_of(:user) }
  end

  describe "Callbacks" do
    it "creates default workspaces" do
      user = build(:user)
      expect{user.save}.to change{
        user.workspaces.count
      }.by(1)
    end
  end
end
